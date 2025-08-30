import { useEffect, useState } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import {
  Paper,
  Box,
  Typography,
  Stack,
  Collapse,
  Button,
  Divider,
  Dialog,
  DialogTitle,
  DialogContent,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow
} from '@mui/material'
import axios from 'axios'
import type { Verdict, SimilarVerdict } from './types'

function JudgmentViewer({ xmlString }: { xmlString: string }) {
  const navigate = useNavigate()
  const parser = new DOMParser()
  const xmlDoc = parser.parseFromString(xmlString, 'application/xml')
  const paragraphs = Array.from(xmlDoc.getElementsByTagName('p'))
  const listItems = Array.from(xmlDoc.getElementsByTagName('item'))

  const renderText = (html: string) => {
    html = html.replace(/<ref href="([^"]+)">([^<]+)<\/ref>/g, (_m, href, text) => {
      return `<a href="#" data-href="${href}">${text}</a>`
    })
    html = html.replace(/<party[^>]*>([^<]+)<\/party>/g, (_m, text) => `<strong>${text}</strong>`)
    html = html.replace(/<organization[^>]*>([^<]+)<\/organization>/g, (_m, text) => `<strong>${text}</strong>`)
    return html
  }

  const handleClick = (e: React.MouseEvent<HTMLDivElement>) => {
    const target = e.target as HTMLElement
    if (target.tagName === 'A' && target.dataset.href) {
      const href = target.dataset.href
      navigate(`/laws/${href.replace('/', '')}`)
    }
  }

  return (
    <Box onClick={handleClick}>
      <Stack spacing={1.5}>
        {paragraphs.map((p, i) => (
          <Typography
            key={i}
            paragraph
            dangerouslySetInnerHTML={{ __html: renderText(p.innerHTML) }}
          />
        ))}

        {listItems.length > 0 && (
          <Box component="ul" sx={{ pl: 3 }}>
            {listItems.map((item, i) => {
              const p = item.querySelector('p')
              if (!p) return null
              return (
                <Typography
                  component="li"
                  key={i}
                  dangerouslySetInnerHTML={{ __html: renderText(p.innerHTML) }}
                />
              )
            })}
          </Box>
        )}
      </Stack>
    </Box>
  )
}

export default function ViewCase() {
  const { id } = useParams<{ id: string }>()
  const navigate = useNavigate()
  const [caseData, setCaseData] = useState<Verdict | null>(null)
  const [xmlString, setXmlString] = useState<string>('')
  const [showMetadata, setShowMetadata] = useState(false)
  const [similarCases, setSimilarCases] = useState<SimilarVerdict[]>([])
  const [openModal, setOpenModal] = useState(false)

  useEffect(() => {
    if (id) {
      axios.get<Verdict>(`/api/cases/${id}`)
        .then(res => setCaseData(res.data))
        .catch(err => console.error(err))

      axios.get(`/api/verdicts/${id}/xml`, { responseType: 'text' })
        .then(res => setXmlString(res.data))
        .catch(err => console.error(err))
    }
  }, [id])

  const handleShowSimilar = () => {
    if (id) {
      axios.get<SimilarVerdict[]>(`/api/cases/retrieve/${id}`)
        .then(res => {
          setSimilarCases(res.data)
          setOpenModal(true)
        })
        .catch(err => {
          console.error(err)
          alert('Error retrieving similar cases')
        })
    }
  }

  const handleCloseModal = () => setOpenModal(false)

  if (!caseData || !xmlString) return <Typography>Loading...</Typography>

  return (
    <Box sx={{ my: 4, px: 3 }}>
      <Stack direction="row" justifyContent="space-between" alignItems="center" mb={3}>
        <Typography variant="h4" fontWeight="bold">
          Case: {caseData.caseId}
        </Typography>
        <Button variant="contained" color="primary" onClick={handleShowSimilar}>
          Show Similar Cases
        </Button>
      </Stack>

      {/* Judgment Viewer */}
      <Paper sx={{ p: 3, borderRadius: 3, boxShadow: 3, mb: 2 }}>
        <JudgmentViewer xmlString={xmlString} />
      </Paper>

      {/* Metadata Panel */}
      <Button
        variant="contained"
        onClick={() => setShowMetadata(prev => !prev)}
        sx={{ mb: 2 }}
      >
        {showMetadata ? 'Hide Metadata' : 'Show Metadata'}
      </Button>
      <Collapse in={showMetadata}>
        <Paper sx={{ p: 3, borderRadius: 3, backgroundColor: '#f5f5f5' }}>
          <Stack spacing={1.5}>
            <Typography><b>Court:</b> {caseData.court}</Typography>
            <Typography><b>Verdict Number:</b> {caseData.verdictNumber}</Typography>
            <Typography><b>Date:</b> {caseData.date}</Typography>
            <Typography><b>Judge Name:</b> {caseData.judgeName}</Typography>
            <Typography><b>Prosecutor:</b> {caseData.prosecutor}</Typography>
            <Typography><b>Defendant Name:</b> {caseData.defendantName}</Typography>
            <Typography><b>Criminal Offense:</b> {caseData.criminalOffense}</Typography>
            <Typography><b>Applied Provisions:</b> {caseData.appliedProvisions}</Typography>
            <Typography><b>Verdict:</b> {caseData.verdict}</Typography>
            {/* add the rest of metadata as needed */}
          </Stack>
        </Paper>
      </Collapse>

      {/* Similar Cases Modal */}
      <Dialog open={openModal} onClose={handleCloseModal} maxWidth="md" fullWidth>
        <DialogTitle>Similar Cases for {caseData.caseId}</DialogTitle>
        <DialogContent>
          {similarCases.length > 0 ? (
            <TableContainer component={Paper} sx={{ mt: 2 }}>
              <Table>
                <TableHead>
                  <TableRow>
                    <TableCell><b>Case</b></TableCell>
                    <TableCell><b>Similarity</b></TableCell>
                    <TableCell align="right"><b>Action</b></TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {similarCases.map((sc, index) => (
                    <TableRow key={index}>
                      <TableCell>{sc.caseDescription.caseName}</TableCell>
                      <TableCell>{(sc.similarity * 100).toFixed(2)}%</TableCell>
                      <TableCell align="right">
                        <Button
                          variant="outlined"
                          color="secondary"
                          onClick={() => {
                            navigate(`/view/${sc.caseDescription.dbId}`)
                            setOpenModal(false)
                          }}
                        >
                          View
                        </Button>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </TableContainer>
          ) : (
            <Typography sx={{ mt: 2 }}>No similar cases found.</Typography>
          )}
        </DialogContent>
      </Dialog>
    </Box>
  )
}
