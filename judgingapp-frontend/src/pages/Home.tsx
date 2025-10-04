import { useEffect, useState } from 'react';
import { Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Paper, Typography, Snackbar, Alert, Box } from '@mui/material';
import axios from 'axios';
import { Link } from 'react-router-dom';
import Button from '@mui/material/Button';
import type { Verdict } from './types';

function Home() {
  const [cases, setCases] = useState<Verdict[]>([]);
  const [snackbar, setSnackbar] = useState<{ open: boolean, message: string, severity: 'error' }>({ open: false, message: '', severity: 'error' });

  useEffect(() => {
    axios.get<Verdict[]>('/api/cases')
      .then(res => setCases(res.data))
      .catch(err => {
        console.error(err);
        setSnackbar({ open: true, message: 'Greška pri dohvatanju slučajeva', severity: 'error' });
      });
  }, []);

  const handleSnackbarClose = () => {
    setSnackbar({ ...snackbar, open: false });
  };

  return (
    <Box sx={{ my: 4, px: 3 }}>
      <Typography variant="h4" sx={{ my: 4, fontWeight: 'bold', color: 'primary.main' }}>Svi slučajevi</Typography>
      <TableContainer component={Paper} sx={{ boxShadow: 2 }}>
        <Table>
          <TableHead>
            <TableRow sx={{ bgcolor: 'grey.100' }}>
              <TableCell sx={{ fontWeight: 'bold' }}>ID presude</TableCell>
              <TableCell sx={{ fontWeight: 'bold' }}>Sud</TableCell>
              <TableCell sx={{ fontWeight: 'bold' }}>Presuda</TableCell>
              <TableCell sx={{ fontWeight: 'bold' }}>Akcije</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {cases.map(c => (
              <TableRow key={c.id} sx={{ '&:hover': { bgcolor: 'grey.50' } }}>
                <TableCell>{c.caseId}</TableCell>
                <TableCell>{c.court}</TableCell>
                <TableCell>{c.judgment || 'Nema presude'}</TableCell>
                <TableCell>
                  <Button component={Link} to={`/view/${c.id}`} variant="outlined" color="secondary" sx={{ textTransform: 'none' }}>
                    Pogledaj
                  </Button>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>
      <Snackbar
        open={snackbar.open}
        autoHideDuration={6000}
        onClose={handleSnackbarClose}
        anchorOrigin={{ vertical: 'bottom', horizontal: 'center' }}
      >
        <Alert onClose={handleSnackbarClose} severity={snackbar.severity} sx={{ width: '100%' }}>
          {snackbar.message}
        </Alert>
      </Snackbar>
    </Box>
  );
}

export default Home;