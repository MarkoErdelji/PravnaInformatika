import { useEffect, useState } from 'react'
import { Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Paper, Typography } from '@mui/material'
import axios from 'axios'
import { Link } from 'react-router-dom'
import Button from '@mui/material/Button'
import type { Verdict } from './types'

function Home() {
  const [cases, setCases] = useState<Verdict[]>([])

  useEffect(() => {
    axios.get<Verdict[]>('/api/cases')
      .then(res => setCases(res.data))
      .catch(err => console.error(err))
  }, [])

  return (
    <div>
      <Typography variant="h4" sx={{ my: 4 }}>All Cases</Typography>
      <TableContainer component={Paper}>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>ID</TableCell>
              <TableCell>Court</TableCell>
              <TableCell>Verdict Number</TableCell>
              <TableCell>Actions</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {cases.map(c => (
              <TableRow key={c.id}>
                <TableCell>{c.caseId}</TableCell>
                <TableCell>{c.court}</TableCell>
                <TableCell>{c.verdictNumber}</TableCell>
                <TableCell>
                  <Button component={Link} to={`/view/${c.id}`}>View</Button>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>
    </div>
  )
}

export default Home