import { useState } from 'react';
import { Box, Button, TextField, Typography, Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Paper, Snackbar, Alert } from '@mui/material';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import type { SimilarVerdict } from './types';

function RetrieveSimilar() {
  const navigate = useNavigate();
  const [id, setId] = useState<string>('');
  const [similarCases, setSimilarCases] = useState<SimilarVerdict[]>([]);
  const [snackbar, setSnackbar] = useState<{ open: boolean, message: string, severity: 'error' }>({ open: false, message: '', severity: 'error' });

  const handleSubmit = () => {
    if (!id) {
      setSnackbar({ open: true, message: 'ID presude je obavezan', severity: 'error' });
      return;
    }
    axios.get<SimilarVerdict[]>(`/api/cases/retrieve/${id}`)
      .then(res => setSimilarCases(res.data))
      .catch(err => {
        console.error(err);
        setSnackbar({ open: true, message: 'Greška pri pronalaženju sličnih slučajeva', severity: 'error' });
      });
  };

  const handleSnackbarClose = () => {
    setSnackbar({ ...snackbar, open: false });
  };

  return (
    <Box sx={{ my: 4, px: 3 }}>
      <Typography variant="h4" sx={{ mb: 3, fontWeight: 'bold', color: 'primary.main' }}>Pronađi slične slučajeve</Typography>
      <Box sx={{ display: 'flex', gap: 2, mb: 3 }}>
        <TextField 
          label="ID presude" 
          value={id} 
          onChange={(e) => setId(e.target.value)} 
          fullWidth 
          margin="normal" 
          variant="outlined"
          error={!!id && id.trim() === ''}
          helperText={id && id.trim() === '' ? 'ID presude ne može biti prazan' : ''}
        />
        <Button 
          variant="contained" 
          color="primary" 
          onClick={handleSubmit} 
          sx={{ alignSelf: 'center', py: 1.5, fontSize: '1.1rem', textTransform: 'none' }}
        >
          Pronađi
        </Button>
      </Box>
      {similarCases.length > 0 && (
        <TableContainer component={Paper} sx={{ mt: 4, boxShadow: 2 }}>
          <Table>
            <TableHead>
              <TableRow sx={{ bgcolor: 'grey.100' }}>
                <TableCell sx={{ fontWeight: 'bold' }}>ID presude</TableCell>
                <TableCell sx={{ fontWeight: 'bold' }}>Sličnost</TableCell>
                <TableCell sx={{ fontWeight: 'bold' }}>Akcije</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {similarCases.map((sc, index) => (
                <TableRow key={index} sx={{ '&:hover': { bgcolor: 'grey.50' } }}>
                  <TableCell>{sc.caseDescription.caseId}</TableCell>
                  <TableCell>{(sc.similarity * 100).toFixed(2)}%</TableCell>
                  <TableCell>
                    <Button
                      variant="outlined"
                      color="secondary"
                      onClick={() => navigate(`/view/${sc.caseDescription.dbId}`)}
                      sx={{ textTransform: 'none' }}
                    >
                      Pogledaj
                    </Button>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
      )}
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

export default RetrieveSimilar;