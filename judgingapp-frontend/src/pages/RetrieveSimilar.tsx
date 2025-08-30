import { useState } from 'react'
import { Box, Button, TextField, Typography, Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Paper } from '@mui/material'
import axios from 'axios'
import type { SimilarVerdict } from './types.ts'

function RetrieveSimilar() {
  const [id, setId] = useState<string>('')
  const [similarCases, setSimilarCases] = useState<SimilarVerdict[]>([])

  const handleSubmit = () => {
    axios.get<SimilarVerdict[]>(`/api/cases/retrieve/${id}`)
      .then(res => setSimilarCases(res.data))
      .catch(err => console.error(err))
  }

  return (
    <Box sx={{ my: 4 }}>
      <Typography variant="h4">Retrieve Similar Cases</Typography>
      <TextField label="Case ID" value={id} onChange={(e) => setId(e.target.value)} fullWidth margin="normal" />
      <Button variant="contained" onClick={handleSubmit}>Retrieve</Button>
      {similarCases.length > 0 && (
        <TableContainer component={Paper} sx={{ mt: 4 }}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>Case</TableCell>
                <TableCell>Similarity</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {similarCases.map((sc, index) => (
                <TableRow key={index}>
                  <TableCell>{sc.caseDescription.caseName}</TableCell>
                  <TableCell>{sc.similarity}</TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
      )}
    </Box>
  )
}

export default RetrieveSimilar