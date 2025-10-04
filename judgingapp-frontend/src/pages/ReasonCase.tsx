import { useForm, Controller } from 'react-hook-form';
import {
  Box, Button, TextField, Typography, Select, MenuItem, FormControl, InputLabel,
  Dialog, DialogTitle, DialogContent, Table, TableContainer, TableHead, TableRow,
  TableCell, TableBody, Paper, CircularProgress, Autocomplete, Chip, Divider, Snackbar, Alert
} from '@mui/material';
import axios from 'axios';
import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import type { CaseDescription, ReasonResponse } from './types';

function ReasonCase() {
  const navigate = useNavigate();
  const { register, handleSubmit, control, formState: { errors }, setValue, watch } = useForm<CaseDescription>({
    defaultValues: {
      caseId: '',
      defendantNames: [],
      victim: '',
      accusationTypes: [],
      judgment: null,
      isMovableProperty: false,
      isTaken: false,
      intentToAppropriate: false,
      valueOfStolenItems: 0,
      isCulturalOrNaturalGood: false,
      breakingAndEntering: false,
      particularlyDangerousOrBrazen: false,
      exploitingHelplessness: false,
      duringDisaster: false,
      numberOfPerpetrators: 1,
      isArmed: false,
      useOfForceOrThreat: false,
      caughtInTheAct: false,
      intentForSmallGain: false,
      causedSevereInjury: false,
      deathCaused: false,
      attemptedCrime: false,
    },
  });

  const [result, setResult] = useState<ReasonResponse | null>(null);
  const [openModal, setOpenModal] = useState(false);
  const [status, setStatus] = useState<'idle' | 'loading' | 'success' | 'error'>('idle');
  const [accusationOptions, setAccusationOptions] = useState<string[]>([]);
  const [snackbar, setSnackbar] = useState<{ open: boolean, message: string, severity: 'error' }>({ open: false, message: '', severity: 'error' });

  const accusationsWatch = watch('accusationTypes');
  const isTakenWatch = watch('isTaken');
  const caughtInTheActWatch = watch('caughtInTheAct');
  const intentForSmallGainWatch = watch('intentForSmallGain');
  const deathCausedWatch = watch('deathCaused');
  const valueOfStolenItemsWatch = watch('valueOfStolenItems');
  const numberOfPerpetratorsWatch = watch('numberOfPerpetrators');

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

  // Constraint: MalaImovinskaKorist implies VrijednostUkradenihStvari < 150
  useEffect(() => {
    if (intentForSmallGainWatch && valueOfStolenItemsWatch >= 150) {
      setValue('intentForSmallGain', false);
      setSnackbar({ open: true, message: 'Mala imovinska korist nije moguća ako je vrijednost ≥ 150€', severity: 'error' });
    }
  }, [intentForSmallGainWatch, valueOfStolenItemsWatch, setValue]);

  // Constraint: BrojUčinilaca >= 2 for Član 241(4)
  useEffect(() => {
    if (accusationsWatch.includes('čl. 241 st. 4') && numberOfPerpetratorsWatch < 2) {
      setValue('numberOfPerpetrators', 2);
      setSnackbar({ open: true, message: 'Član 241 st. 4 zahtijeva barem 2 izvršioca', severity: 'error' });
    }
  }, [accusationsWatch, numberOfPerpetratorsWatch, setValue]);

  // Constraint: NačinIzvršenja for Član 240
  useEffect(() => {
    if (accusationsWatch.some(acc => acc.includes('240'))) {
      if (!watch('breakingAndEntering') && !watch('particularlyDangerousOrBrazen') && 
          !watch('exploitingHelplessness') && !watch('duringDisaster')) {
        setValue('breakingAndEntering', true);
        setSnackbar({ open: true, message: 'Član 240 zahtijeva barem jedan kvalifikujući način izvršenja', severity: 'error' });
      }
    }
  }, [accusationsWatch, setValue]);

  const onSubmit = (data: CaseDescription) => {
    setStatus('loading');
    const payload = {
      ...data,
      accusationTypes: data.accusationTypes.map(acc => {
        const match = acc.match(/^čl\. (\d+)(?:\s*st\. (\d+))?$/i);
        return match ? (match[2] ? `ARTICLE_${match[1]}_ST_${match[2]}` : `ARTICLE_${match[1]}`) : 'OTHER';
      }),
    };
    axios.post<ReasonResponse>('/api/cases/reason', payload)
      .then(res => {
        setResult({ ...res.data, caseDescription: data });
        setStatus('success');
        setOpenModal(true);
      })
      .catch(err => {
        console.error(err);
        setStatus('error');
        setSnackbar({ open: true, message: 'Greška prilikom obrade slučaja', severity: 'error' });
        setOpenModal(true);
      });
  };

  const handleCloseModal = () => {
    setOpenModal(false);
    setStatus('idle');
    setResult(null);
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
        <Typography variant="h6" sx={{ mt: 2, mb: 1, fontWeight: 'medium' }}>Identifikacija slučaja</Typography>
        <Box sx={{ display: 'grid', gridTemplateColumns: { xs: '1fr', md: '1fr 1fr' }, gap: 2 }}>
          <TextField
            label="ID presude"
            {...register('caseId', { required: 'ID presude je obavezan' })}
            fullWidth
            margin="normal"
            error={!!errors.caseId}
            helperText={errors.caseId?.message}
            variant="outlined"
          />
        </Box>

        <Typography variant="h6" sx={{ mt: 3, mb: 1, fontWeight: 'medium' }}>Učesnici</Typography>
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
                helperText={errors.defendantNames?.message || 'Unesite imena optuženih, odvojena zarezima'}
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
            <InputLabel>Presuda</InputLabel>
            <Controller
              name="judgment"
              control={control}
              rules={{ required: 'Presuda je obavezna' }}
              render={({ field }) => (
                <Select {...field} label="Presuda" value={field.value || ''}>
                  <MenuItem value="ACQUITTAL">Oslobađajuća</MenuItem>
                  <MenuItem value="FINE">Novčana kazna</MenuItem>
                  <MenuItem value="PRISON">Zatvor</MenuItem>
                  <MenuItem value="SUSPENDED">Uslovna</MenuItem>
                  <MenuItem value="FINE_AND_PRISON">Novčana kazna i zatvor</MenuItem>
                  <MenuItem value="DISMISSAL">Odbacivanje</MenuItem>
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
          <FormControl fullWidth margin="normal">
            <InputLabel>Status kulturnog ili prirodnog dobra</InputLabel>
            <Controller
              name="isCulturalOrNaturalGood"
              control={control}
              render={({ field }) => (
                <Select
                  {...field}
                  label="Status kulturnog ili prirodnog dobra"
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
            <InputLabel>Posebno opasan ili drzak</InputLabel>
            <Controller
              name="particularlyDangerousOrBrazen"
              control={control}
              render={({ field }) => (
                <Select
                  {...field}
                  label="Posebno opasan ili drzak"
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
            <InputLabel>Iskorištavanje bespomoćnosti</InputLabel>
            <Controller
              name="exploitingHelplessness"
              control={control}
              render={({ field }) => (
                <Select
                  {...field}
                  label="Iskorištavanje bespomoćnosti"
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
            <InputLabel>Tokom katastrofe</InputLabel>
            <Controller
              name="duringDisaster"
              control={control}
              render={({ field }) => (
                <Select
                  {...field}
                  label="Tokom katastrofe"
                  onChange={(e) => field.onChange(e.target.value === 'true')}
                  value={field.value ? 'true' : 'false'}
                >
                  <MenuItem value="true">Da</MenuItem>
                  <MenuItem value="false">Ne</MenuItem>
                </Select>
              )}
            />
          </FormControl>
          <TextField
            label="Broj izvršitelja"
            type="number"
            {...register('numberOfPerpetrators', { 
              valueAsNumber: true, 
              min: { value: 1, message: 'Broj izvršitelja mora biti barem 1' } 
            })}
            fullWidth
            margin="normal"
            error={!!errors.numberOfPerpetrators}
            helperText={errors.numberOfPerpetrators?.message}
            variant="outlined"
          />
          <FormControl fullWidth margin="normal">
            <InputLabel>Prisustvo oružja</InputLabel>
            <Controller
              name="isArmed"
              control={control}
              render={({ field }) => (
                <Select
                  {...field}
                  label="Prisustvo oružja"
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
          <FormControl fullWidth margin="normal">
            <InputLabel>Mala imovinska korist</InputLabel>
            <Controller
              name="intentForSmallGain"
              control={control}
              render={({ field }) => (
                <Select
                  {...field}
                  label="Mala imovinska korist"
                  onChange={(e) => field.onChange(e.target.value === 'true')}
                  value={field.value ? 'true' : 'false'}
                  disabled={valueOfStolenItemsWatch >= 150}
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
          <FormControl fullWidth margin="normal">
            <InputLabel>Pokušaj djela</InputLabel>
            <Controller
              name="attemptedCrime"
              control={control}
              render={({ field }) => (
                <Select
                  {...field}
                  label="Pokušaj djela"
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
        >
          Obradi slučaj
        </Button>
      </form>

      <Dialog open={openModal} onClose={handleCloseModal} maxWidth="md" fullWidth sx={{ '& .MuiDialog-paper': { borderRadius: 2 } }}>
        <DialogTitle sx={{ bgcolor: 'primary.main', color: 'white', fontWeight: 'bold' }}>
          Rezultati obrade
        </DialogTitle>
        <DialogContent sx={{ p: 3 }}>
          {status === 'loading' && (
            <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', py: 4, flexDirection: 'column' }}>
              <CircularProgress size={50} />
              <Typography sx={{ mt: 2, fontSize: '1.1rem' }}>Obrađivanje u toku...</Typography>
            </Box>
          )}

          {status === 'error' && (
            <Typography color="error" sx={{ py: 3, fontSize: '1.1rem', textAlign: 'center' }}>
              ❌ Greška prilikom obrade. Pokušajte ponovo.
            </Typography>
          )}

          {status === 'success' && result && (
            <>
              <Typography variant="h6" sx={{ mb: 2, fontWeight: 'medium' }}>
                Izabrali ste: <strong>{result.caseDescription?.judgment || 'Nema presude'}</strong>
              </Typography>
              <Typography variant="h6" sx={{ mb: 3, fontWeight: 'medium' }}>
                Predviđena presuda: <strong>{result.predictedVerdict}</strong>
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
            </>
          )}

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

export default ReasonCase;