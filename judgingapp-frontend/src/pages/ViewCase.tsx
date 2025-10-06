import { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import {
  Paper, Box, Typography, Stack, Collapse, Button, Divider, Dialog, DialogTitle, DialogContent,
  Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Snackbar, Alert,
  CircularProgress
} from '@mui/material';
import axios from 'axios';
import { type Verdict, type SimilarVerdict, verdictTranslations } from './types';
import JudgmentViewer from '../components/JudgmentViewer';


export default function ViewCase() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [caseData, setCaseData] = useState<Verdict | null>(null);
  const [xmlString, setXmlString] = useState<string>('');
  const [showMetadata, setShowMetadata] = useState(false);
  const [similarCases, setSimilarCases] = useState<SimilarVerdict[]>([]);
  const [openModal, setOpenModal] = useState(false);
  const [snackbar, setSnackbar] = useState<{ open: boolean, message: string, severity: 'error' }>({
    open: false,
    message: '',
    severity: 'error',
  });

  useEffect(() => {
    if (id) {
      // Fetch case details
      axios.get<Verdict>(`/api/cases/${id}`)
        .then(res => setCaseData(res.data))
        .catch(err => {
          console.error(err);
          setSnackbar({ open: true, message: 'Greška pri dohvatanju podataka o slučaju', severity: 'error' });
        });
      // Fetch XML content
      axios.get(`/api/verdicts/${id}/xml`, { responseType: 'text' })
        .then(res => setXmlString(res.data))
        .catch(err => {
          console.error(err);
          setSnackbar({ open: true, message: 'Greška pri dohvatanju XML dokumenta', severity: 'error' });
        });
    }
  }, [id]);

  const handleShowSimilar = () => {
    if (id) {
      axios.get<SimilarVerdict[]>(`/api/cases/retrieve/${id}`)
        .then(res => {
          setSimilarCases(res.data);
          setOpenModal(true);
        })
        .catch(err => {
          console.error(err);
          setSnackbar({ open: true, message: 'Greška pri pronalaženju sličnih slučajeva', severity: 'error' });
        });
    }
  };

  const handleCloseModal = () => setOpenModal(false);

  const handleSnackbarClose = () => {
    setSnackbar({ ...snackbar, open: false });
  };

  if (!caseData || !xmlString) {
    return (
      <Box sx={{ my: 4, px: 3, display: 'flex', justifyContent: 'center', alignItems: 'center', flexDirection: 'column' }}>
        <Typography variant="h6" sx={{ mb: 2 }}>Učitavanje...</Typography>
        <CircularProgress size={50} />
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

  return (
    <Box sx={{ my: 4, px: 3 }}>
      <Stack direction="row" justifyContent="space-between" alignItems="center" mb={3}>
        <Typography variant="h4" fontWeight="bold" color="primary.main">
          Slučaj: {caseData.caseId}
        </Typography>
        <Button
          variant="contained"
          color="primary"
          onClick={handleShowSimilar}
          sx={{ textTransform: 'none', fontSize: '1.1rem' }}
        >
          Prikaz sličnih slučajeva
        </Button>
      </Stack>
      {/* Judgment Viewer */}
      <JudgmentViewer xmlString={xmlString} />
      {/* Metadata Panel */}
      <Button
        variant="contained"
        color="secondary"
        onClick={() => setShowMetadata(prev => !prev)}
        sx={{ my: 2, textTransform: 'none', fontSize: '1.1rem' }}
      >
        {showMetadata ? 'Sakrij metapodatke' : 'Prikaži metapodatke'}
      </Button>
      <Collapse in={showMetadata}>
        <Paper sx={{ p: 3, borderRadius: 3, backgroundColor: '#f5f5f5', boxShadow: 2 }}>
          <Typography variant="h6" sx={{ mb: 2, fontWeight: 'medium' }}>Metapodaci slučaja</Typography>
          <Divider sx={{ mb: 2 }} />
          <Stack spacing={1.5}>
            <Typography><b>ID presude:</b> {caseData.caseId}</Typography>
            <Typography><b>Sud:</b> {caseData.court}</Typography>
            <Typography><b>Broj presude:</b> {caseData.caseNumber}</Typography>
            <Typography><b>Datum presude:</b> {caseData.verdictDate || 'Nije naveden'}</Typography>
            <Typography><b>Sudija:</b> {caseData.judge}</Typography>
            <Typography><b>Pisar:</b> {caseData.clerk}</Typography>
            <Typography><b>Tužilac:</b> {caseData.prosecutor}</Typography>
            <Typography><b>Imena optuženih:</b> {caseData.defendantNames.join(', ')}</Typography>
            <Typography><b>Žrtva:</b> {caseData.victim}</Typography>
            <Typography><b>Kratak opis:</b> {caseData.shortDescription}</Typography>
            <Typography><b>Presuda:</b> {verdictTranslations[caseData.judgment || 'NONE']}</Typography>
            <Typography><b>Primijenjene odredbe:</b> {caseData.appliedProvisions}</Typography>
            <Typography><b>Optužbe:</b> {caseData.accusations.join(', ')}</Typography>
            <Typography><b>Vrsta stvari (tuđa i pokretna):</b> {caseData.isMovableProperty ? 'Da' : 'Ne'}</Typography>
            <Typography><b>Radnja oduzimanja:</b> {caseData.isTaken ? 'Da' : 'Ne'}</Typography>
            <Typography><b>Namjera prisvajanja:</b> {caseData.intentToAppropriate ? 'Da' : 'Ne'}</Typography>
            <Typography><b>Vrijednost ukradenih stvari (€):</b> {caseData.valueOfStolenItems}</Typography>
            <Typography><b>Provala:</b> {caseData.breakingAndEntering ? 'Da' : 'Ne'}</Typography>
            <Typography><b>Upotreba sile ili prijetnje:</b> {caseData.useOfForceOrThreat ? 'Da' : 'Ne'}</Typography>
            <Typography><b>Zatečenost na djelu:</b> {caseData.caughtInTheAct ? 'Da' : 'Ne'}</Typography>
            <Typography><b>Nanesene teške povrede:</b> {caseData.causedSevereInjury ? 'Da' : 'Ne'}</Typography>
            <Typography><b>Smrt lica:</b> {caseData.deathCaused ? 'Da' : 'Ne'}</Typography>
            <Typography><b>Novčana kazna (€):</b> {caseData.monetaryPenalty || 'Nema'}</Typography>
            <Typography><b>Godine zatvora:</b> {caseData.prisonPenalty || 'Nema'}</Typography>
          </Stack>
        </Paper>
      </Collapse>
      {/* Similar Cases Modal */}
      <Dialog open={openModal} onClose={handleCloseModal} maxWidth="md" fullWidth sx={{ '& .MuiDialog-paper': { borderRadius: 2 } }}>
        <DialogTitle sx={{ bgcolor: 'primary.main', color: 'white', fontWeight: 'bold' }}>
          Slični slučajevi za {caseData.caseId}
        </DialogTitle>
        <DialogContent sx={{ p: 3 }}>
          <TableContainer component={Paper} sx={{ boxShadow: 2 }}>
            <Table>
              <TableHead>
                <TableRow sx={{ bgcolor: 'grey.100' }}>
                  <TableCell sx={{ fontWeight: 'bold' }}>ID presude</TableCell>
                  <TableCell sx={{ fontWeight: 'bold' }}>Sličnost</TableCell>
                  <TableCell sx={{ fontWeight: 'bold' }}>Presuda</TableCell>
                  <TableCell align="right" sx={{ fontWeight: 'bold' }}>Akcije</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {similarCases.map((sc, index) => (
                  <TableRow key={index} sx={{ '&:hover': { bgcolor: 'grey.50' } }}>
                    <TableCell>{sc.caseDescription.caseId}</TableCell>
                    <TableCell>{(sc.similarity * 100).toFixed(2)}%</TableCell>
                    <TableCell>{verdictTranslations[sc.caseDescription.judgment || 'NONE']}</TableCell>
                    <TableCell align="right">
                      <Button
                        variant="outlined"
                        color="secondary"
                        onClick={() => {
                          navigate(`/view/${sc.caseDescription.dbId}`);
                          setOpenModal(false);
                        }}
                        sx={{ textTransform: 'none', mr: 1 }}
                      >
                        Pogledaj
                      </Button>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </TableContainer>
          <Button
            onClick={handleCloseModal}
            variant="contained"
            color="primary"
            fullWidth
            sx={{ mt: 3, py: 1.5, fontSize: '1.1rem', textTransform: 'none' }}
          >
            Zatvori
          </Button>
        </DialogContent>
      </Dialog>
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