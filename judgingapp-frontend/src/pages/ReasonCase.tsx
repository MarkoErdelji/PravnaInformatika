import { useForm, Controller } from 'react-hook-form';
import {
  Box, Button, TextField, Typography, Select, MenuItem, FormControl, InputLabel,
  Dialog, DialogTitle, DialogContent, Table, TableContainer, TableHead, TableRow,
  TableCell, TableBody, Paper, CircularProgress, Autocomplete, Chip, Divider, Snackbar, Alert, Stack
} from '@mui/material';
import axios from 'axios';
import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { verdictTranslations, accusationTranslations, type CaseDescription, type ReasonResponse, type Verdict } from './types';

function ReasonCase() {
  const navigate = useNavigate();
  const { register, handleSubmit, control, formState: { errors }, setValue, watch } = useForm<CaseDescription>({
    defaultValues: {
      accusationTypes: [],
      judgment: null,
      isMovableProperty: false,
      isTaken: false,
      intentToAppropriate: false,
      valueOfStolenItems: 0,
      breakingAndEntering: false,
      useOfForceOrThreat: false,
      caughtInTheAct: false,
      causedSevereInjury: false,
      deathCaused: false,
      monetaryPenalty: null,
      prisonPenalty: null,
      defendantNames: [],
      victim: '',
    },
  });
  const [result, setResult] = useState<ReasonResponse | null>(null);
  const [openModal, setOpenModal] = useState(false);
  const [metadataModalOpen, setMetadataModalOpen] = useState(false);
  const [selectedCase, setSelectedCase] = useState<Verdict | null>(null);
  const [status, setStatus] = useState<'idle' | 'loading' | 'success' | 'error'>('idle');
  const [accusationOptions, setAccusationOptions] = useState<string[]>([]);
  const [snackbar, setSnackbar] = useState<{ open: boolean, message: string, severity: 'error' }>({ open: false, message: '', severity: 'error' });
  const accusationsWatch = watch('accusationTypes');
  const isTakenWatch = watch('isTaken');
  const caughtInTheActWatch = watch('caughtInTheAct');
  const deathCausedWatch = watch('deathCaused');

  useEffect(() => {
    axios.get<string[]>('/api/cases/accusations')
      .then(res => setAccusationOptions(res.data))
      .catch(err => {
        console.error(err);
        setSnackbar({ open: true, message: 'Greška pri dohvatanju optužbi', severity: 'error' });
      });
  }, []);

  // Constraint: SmrtLica implies NaneseneTeškePovrede
  useEffect(() => {
    if (deathCausedWatch) {
      setValue('causedSevereInjury', true);
    }
  }, [deathCausedWatch, setValue]);

  // Constraint: RadnjaOduzimanja implies VrstaStvari
  useEffect(() => {
    if (isTakenWatch) {
      setValue('isMovableProperty', true);
    }
  }, [isTakenWatch, setValue]);

  // Constraint: NamjeraPrisvajanja for krađa-related accusations
  useEffect(() => {
    if (accusationsWatch.some(acc => acc.includes('239') || acc.includes('240') || acc.includes('241'))) {
      setValue('intentToAppropriate', true);
    }
  }, [accusationsWatch, setValue]);

  // Constraint: UpotrebaSileIliPrijetnje for Član 241 when ZatečenostNaDelu
  useEffect(() => {
    if (accusationsWatch.includes('čl. 241') && caughtInTheActWatch) {
      setValue('useOfForceOrThreat', true);
    }
  }, [accusationsWatch, caughtInTheActWatch, setValue]);

  const onSubmit = (data: CaseDescription) => {
    setStatus('loading');
    axios.post<ReasonResponse>('/api/cases/reason', data)
      .then(res => {
        setResult({ ...res.data, caseDescription: data });
        setStatus('success');
        setOpenModal(true);
      })
      .catch(err => {
        console.error(err);
        setStatus('error');
        setSnackbar({ open: true, message: 'Greška prilikom obrade slučaja', severity: 'error' });
      });
  };

  const handleCloseModal = () => {
    setOpenModal(false);
    setResult(null);
  };

  const handleMetadataOpen = (caseId: string) => {
    axios.get<Verdict>(`/api/cases/${caseId}`)
      .then(res => {
        setSelectedCase(res.data);
        setMetadataModalOpen(true);
      })
      .catch(err => {
        console.error(err);
        setSnackbar({ open: true, message: 'Greška pri dohvatanju metapodataka', severity: 'error' });
      });
  };

  const handleMetadataClose = () => {
    setMetadataModalOpen(false);
    setSelectedCase(null);
  };

  const handleSnackbarClose = () => {
    setSnackbar({ ...snackbar, open: false });
  };

  return (
    <Box sx={{ maxWidth: 1200, mx: 'auto', my: 4, p: 3, bgcolor: 'background.paper', borderRadius: 2, boxShadow: 3 }}>
      <Typography variant="h4" gutterBottom sx={{ fontWeight: 'bold', color: 'primary.main' }}>
        Obradi slučaj
      </Typography>
      <Divider sx={{ mb: 3 }} />
      <form onSubmit={handleSubmit(onSubmit)}>
        <Typography variant="h6" sx={{ mt: 2, mb: 1, fontWeight: 'medium' }}>Učesnici</Typography>
        <Box sx={{ display: 'grid', gridTemplateColumns: { xs: '1fr', md: '1fr 1fr' }, gap: 2 }}>
          <Autocomplete
            multiple
            freeSolo
            options={[]}
            value={watch('defendantNames') || []}
            onChange={(event, newValue) => setValue('defendantNames', newValue)}
            renderTags={(value, getTagProps) =>
              value.map((option, index) => (
                <Chip variant="outlined" label={option} {...getTagProps({ index })} />
              ))
            }
            renderInput={(params) => (
              <TextField
                {...params}
                label="Imena optuženih"
                helperText={errors.defendantNames?.message || 'Unesite jedno ime po unosu i pritisnite Enter za dodavanje'}
                fullWidth
                margin="normal"
                error={!!errors.defendantNames}
                variant="outlined"
              />
            )}
          />
          <TextField
            label="Žrtva"
            {...register('victim', { required: 'Ime žrtve je obavezno' })}
            fullWidth
            margin="normal"
            error={!!errors.victim}
            helperText={errors.victim?.message}
            variant="outlined"
          />
        </Box>
        <Typography variant="h6" sx={{ mt: 3, mb: 1, fontWeight: 'medium' }}>Detalji slučaja</Typography>
        <Box sx={{ display: 'grid', gridTemplateColumns: { xs: '1fr', md: '1fr 1fr' }, gap: 2 }}>
          <Autocomplete
            multiple
            options={accusationOptions}
            value={watch('accusationTypes') || []}
            onChange={(event, newValue) => setValue('accusationTypes', newValue)}
            renderTags={(value, getTagProps) =>
              value.map((option, index) => (
                <Chip variant="outlined" label={option} {...getTagProps({ index })} />
              ))
            }
            renderInput={(params) => (
              <TextField
                {...params}
                label="Optužbe"
                helperText={errors.accusationTypes?.message || 'Izaberite optužbe (npr. čl. 239 st. 1)'}
                fullWidth
                margin="normal"
                error={!!errors.accusationTypes}
                variant="outlined"
              />
            )}
          />
          <FormControl fullWidth margin="normal" error={!!errors.judgment}>
            <InputLabel>Tip presude</InputLabel>
            <Controller
              name="judgment"
              control={control}
              rules={{ required: 'Tip presude je obavezan' }}
              render={({ field }) => (
                <Select {...field} label="Tip presude" value={field.value || ''}>
                  {Object.entries(verdictTranslations).map(([key, value]) => (
                    key !== 'NONE' && <MenuItem key={key} value={key}>{value}</MenuItem>
                  ))}
                </Select>
              )}
            />
            {errors.judgment && <Typography color="error">{errors.judgment.message}</Typography>}
          </FormControl>
        </Box>
        <Typography variant="h6" sx={{ mt: 3, mb: 1, fontWeight: 'medium' }}>Osnovne činjenice</Typography>
        <Box sx={{ display: 'grid', gridTemplateColumns: { xs: '1fr', md: '1fr 1fr' }, gap: 2 }}>
          <FormControl fullWidth margin="normal">
            <InputLabel>Vrsta stvari</InputLabel>
            <Controller
              name="isMovableProperty"
              control={control}
              render={({ field }) => (
                <Select
                  {...field}
                  label="Vrsta stvari"
                  onChange={(e) => field.onChange(e.target.value === 'true')}
                  value={field.value ? 'true' : 'false'}
                  disabled={isTakenWatch}
                >
                  <MenuItem value="true">Tuđa i pokretna</MenuItem>
                  <MenuItem value="false">Nije pokretna</MenuItem>
                </Select>
              )}
            />
          </FormControl>
          <FormControl fullWidth margin="normal">
            <InputLabel>Radnja oduzimanja</InputLabel>
            <Controller
              name="isTaken"
              control={control}
              render={({ field }) => (
                <Select
                  {...field}
                  label="Radnja oduzimanja"
                  onChange={(e) => field.onChange(e.target.value === 'true')}
                  value={field.value ? 'true' : 'false'}
                >
                  <MenuItem value="true">Da</MenuItem>
                  <MenuItem value="false">Ne</MenuItem>
                </Select>
              )}
            />
          </FormControl>
          <FormControl fullWidth margin="normal">
            <InputLabel>Namjera prisvajanja</InputLabel>
            <Controller
              name="intentToAppropriate"
              control={control}
              render={({ field }) => (
                <Select
                  {...field}
                  label="Namjera prisvajanja"
                  onChange={(e) => field.onChange(e.target.value === 'true')}
                  value={field.value ? 'true' : 'false'}
                  disabled={accusationsWatch.some(acc => acc.includes('239') || acc.includes('240') || acc.includes('241'))}
                >
                  <MenuItem value="true">Da</MenuItem>
                  <MenuItem value="false">Ne</MenuItem>
                </Select>
              )}
            />
          </FormControl>
          <TextField
            label="Vrijednost ukradenih stvari (€)"
            type="number"
            {...register('valueOfStolenItems', {
              valueAsNumber: true,
              min: { value: 0, message: 'Vrijednost mora biti nenegativna' }
            })}
            fullWidth
            margin="normal"
            error={!!errors.valueOfStolenItems}
            helperText={errors.valueOfStolenItems?.message}
            variant="outlined"
          />
        </Box>
        <Typography variant="h6" sx={{ mt: 3, mb: 1, fontWeight: 'medium' }}>Kvalifikujuće činjenice</Typography>
        <Box sx={{ display: 'grid', gridTemplateColumns: { xs: '1fr', md: '1fr 1fr' }, gap: 2 }}>
          <FormControl fullWidth margin="normal">
            <InputLabel>Provala</InputLabel>
            <Controller
              name="breakingAndEntering"
              control={control}
              render={({ field }) => (
                <Select
                  {...field}
                  label="Provala"
                  onChange={(e) => field.onChange(e.target.value === 'true')}
                  value={field.value ? 'true' : 'false'}
                >
                  <MenuItem value="true">Da</MenuItem>
                  <MenuItem value="false">Ne</MenuItem>
                </Select>
              )}
            />
          </FormControl>
          <FormControl fullWidth margin="normal">
            <InputLabel>Upotreba sile ili prijetnje</InputLabel>
            <Controller
              name="useOfForceOrThreat"
              control={control}
              render={({ field }) => (
                <Select
                  {...field}
                  label="Upotreba sile ili prijetnje"
                  onChange={(e) => field.onChange(e.target.value === 'true')}
                  value={field.value ? 'true' : 'false'}
                  disabled={accusationsWatch.includes('čl. 241') && caughtInTheActWatch}
                >
                  <MenuItem value="true">Da</MenuItem>
                  <MenuItem value="false">Ne</MenuItem>
                </Select>
              )}
            />
          </FormControl>
          <FormControl fullWidth margin="normal">
            <InputLabel>Zatečenost na djelu</InputLabel>
            <Controller
              name="caughtInTheAct"
              control={control}
              render={({ field }) => (
                <Select
                  {...field}
                  label="Zatečenost na djelu"
                  onChange={(e) => field.onChange(e.target.value === 'true')}
                  value={field.value ? 'true' : 'false'}
                >
                  <MenuItem value="true">Da</MenuItem>
                  <MenuItem value="false">Ne</MenuItem>
                </Select>
              )}
            />
          </FormControl>
        </Box>
        <Typography variant="h6" sx={{ mt: 3, mb: 1, fontWeight: 'medium' }}>Činjenice o posledicama</Typography>
        <Box sx={{ display: 'grid', gridTemplateColumns: { xs: '1fr', md: '1fr 1fr' }, gap: 2 }}>
          <FormControl fullWidth margin="normal">
            <InputLabel>Nanesene teške povrede</InputLabel>
            <Controller
              name="causedSevereInjury"
              control={control}
              render={({ field }) => (
                <Select
                  {...field}
                  label="Nanesene teške povrede"
                  onChange={(e) => field.onChange(e.target.value === 'true')}
                  value={field.value ? 'true' : 'false'}
                  disabled={deathCausedWatch}
                >
                  <MenuItem value="true">Da</MenuItem>
                  <MenuItem value="false">Ne</MenuItem>
                </Select>
              )}
            />
          </FormControl>
          <FormControl fullWidth margin="normal">
            <InputLabel>Smrt lica</InputLabel>
            <Controller
              name="deathCaused"
              control={control}
              render={({ field }) => (
                <Select
                  {...field}
                  label="Smrt lica"
                  onChange={(e) => field.onChange(e.target.value === 'true')}
                  value={field.value ? 'true' : 'false'}
                >
                  <MenuItem value="true">Da</MenuItem>
                  <MenuItem value="false">Ne</MenuItem>
                </Select>
              )}
            />
          </FormControl>
        </Box>
        <Button
          type="submit"
          variant="contained"
          color="primary"
          fullWidth
          sx={{ mt: 4, py: 1.5, fontSize: '1.1rem', fontWeight: 'bold' }}
          disabled={status === 'loading'}
        >
          Obradi slučaj
        </Button>
      </form>
      <Dialog open={openModal} onClose={handleCloseModal} maxWidth="md" fullWidth sx={{ '& .MuiDialog-paper': { borderRadius: 2 } }}>
        <DialogTitle sx={{ bgcolor: 'primary.main', color: 'white', fontWeight: 'bold' }}>
          Rezultati obrade
        </DialogTitle>
        <DialogContent sx={{ p: 3 }}>
          {result ? (
            <>
              <Typography variant="h6" sx={{ mb: 2, fontWeight: 'medium' }}>
                Moj izbor: <strong>{verdictTranslations[result.caseDescription.judgment || 'NONE']}</strong>
              </Typography>
              <Typography variant="h6" sx={{ mb: 2, fontWeight: 'medium' }}>
                Rasudjivanje po slučaju: <strong>{verdictTranslations[result.predictedVerdict]}</strong>
              </Typography>
              <Typography variant="h6" sx={{ mb: 2, fontWeight: 'medium' }}>
                Rasudjivanje po pravilima: <strong>{verdictTranslations[result.drDeviceResults.judgment]}</strong>
              </Typography>
              <Typography variant="body1" sx={{ mb: 2 }}>
                Kazna (po pravilima): {result.drDeviceResults.penalty}
              </Typography>
              <Typography variant="body1" sx={{ mb: 3 }}>
                Optužba (po pravilima): {result.drDeviceResults.accusation}
              </Typography>
              <Typography variant="h6" sx={{ mb: 2, fontWeight: 'medium' }}>Slični slučajevi</Typography>
              <TableContainer component={Paper} sx={{ boxShadow: 2 }}>
                <Table>
                  <TableHead>
                    <TableRow sx={{ bgcolor: 'grey.100' }}>
                      <TableCell sx={{ fontWeight: 'bold' }}>ID presude</TableCell>
                      <TableCell sx={{ fontWeight: 'bold' }}>Sličnost</TableCell>
                      <TableCell align="right" sx={{ fontWeight: 'bold' }}>Akcije</TableCell>
                    </TableRow>
                  </TableHead>
                  <TableBody>
                    {result.similarCases.map((sc, index) => (
                      <TableRow key={index} sx={{ '&:hover': { bgcolor: 'grey.50' } }}>
                        <TableCell>{sc.caseDescription.caseId}</TableCell>
                        <TableCell>{(sc.similarity * 100).toFixed(2)}%</TableCell>
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
                          <Button
                            variant="outlined"
                            color="primary"
                            onClick={() => handleMetadataOpen(sc.caseDescription.dbId!.toString())}
                            sx={{ textTransform: 'none' }}
                          >
                            Prikaz metapodataka
                          </Button>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </TableContainer>
              <Box sx={{ mt: 3, display: 'flex', gap: 2 }}>
                <Button
                  onClick={handleCloseModal}
                  variant="outlined"
                  color="secondary"
                  sx={{ flex: 1, py: 1.5, fontSize: '1.1rem', textTransform: 'none' }}
                >
                  Zatvori
                </Button>
              </Box>
            </>
          ) : (
            <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', py: 4, flexDirection: 'column' }}>
              <CircularProgress size={50} />
              <Typography sx={{ mt: 2, fontSize: '1.1rem' }}>Učitavanje...</Typography>
            </Box>
          )}
        </DialogContent>
      </Dialog>
      <Dialog open={metadataModalOpen} onClose={handleMetadataClose} maxWidth="md" fullWidth sx={{ '& .MuiDialog-paper': { borderRadius: 2 } }}>
        <DialogTitle sx={{ bgcolor: 'primary.main', color: 'white', fontWeight: 'bold' }}>
          Metapodaci slučaja {selectedCase?.caseId}
        </DialogTitle>
        <DialogContent sx={{ p: 3 }}>
          {selectedCase ? (
            <Stack spacing={1.5}>
              <Typography><b>ID presude:</b> {selectedCase.caseId}</Typography>
              <Typography><b>Sud:</b> {selectedCase.court}</Typography>
              <Typography><b>Broj presude:</b> {selectedCase.caseNumber}</Typography>
              <Typography><b>Datum presude:</b> {selectedCase.verdictDate || 'Nije naveden'}</Typography>
              <Typography><b>Sudija:</b> {selectedCase.judge}</Typography>
              <Typography><b>Pisar:</b> {selectedCase.clerk}</Typography>
              <Typography><b>Tužilac:</b> {selectedCase.prosecutor}</Typography>
              <Typography><b>Imena optuženih:</b> {selectedCase.defendantNames.join(', ')}</Typography>
              <Typography><b>Žrtva:</b> {selectedCase.victim}</Typography>
              <Typography><b>Kratak opis:</b> {selectedCase.shortDescription}</Typography>
              <Typography><b>Presuda:</b> {verdictTranslations[selectedCase.judgment || 'NONE']}</Typography>
              <Typography><b>Primijenjene odredbe:</b> {selectedCase.appliedProvisions}</Typography>
              <Typography><b>Optužbe:</b> {selectedCase.accusations.join(', ')}</Typography>
              <Typography><b>Vrsta stvari (tuđa i pokretna):</b> {selectedCase.isMovableProperty ? 'Da' : 'Ne'}</Typography>
              <Typography><b>Radnja oduzimanja:</b> {selectedCase.isTaken ? 'Da' : 'Ne'}</Typography>
              <Typography><b>Namjera prisvajanja:</b> {selectedCase.intentToAppropriate ? 'Da' : 'Ne'}</Typography>
              <Typography><b>Vrijednost ukradenih stvari (€):</b> {selectedCase.valueOfStolenItems}</Typography>
              <Typography><b>Provala:</b> {selectedCase.breakingAndEntering ? 'Da' : 'Ne'}</Typography>
              <Typography><b>Upotreba sile ili prijetnje:</b> {selectedCase.useOfForceOrThreat ? 'Da' : 'Ne'}</Typography>
              <Typography><b>Zatečenost na djelu:</b> {selectedCase.caughtInTheAct ? 'Da' : 'Ne'}</Typography>
              <Typography><b>Nanesene teške povrede:</b> {selectedCase.causedSevereInjury ? 'Da' : 'Ne'}</Typography>
              <Typography><b>Smrt lica:</b> {selectedCase.deathCaused ? 'Da' : 'Ne'}</Typography>
              <Typography><b>Novčana kazna (€):</b> {selectedCase.monetaryPenalty || 'Nema'}</Typography>
              <Typography><b>Godine zatvora:</b> {selectedCase.prisonPenalty || 'Nema'}</Typography>
            </Stack>
          ) : (
            <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', py: 4, flexDirection: 'column' }}>
              <CircularProgress size={50} />
              <Typography sx={{ mt: 2, fontSize: '1.1rem' }}>Učitavanje...</Typography>
            </Box>
          )}
          <Button
            onClick={handleMetadataClose}
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

export default ReasonCase;