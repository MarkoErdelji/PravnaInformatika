import { useForm, Controller } from 'react-hook-form';
import {
  Box, Button, TextField, Typography, Select, MenuItem, FormControl, InputLabel,
  Dialog, DialogTitle, DialogContent, Table, TableContainer, TableHead, TableRow,
  TableCell, TableBody, Paper, Autocomplete, Chip, Divider, Snackbar, Alert,
  CircularProgress, Stack
} from '@mui/material';
import axios from 'axios';
import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { type Verdict, type ReasonResponse, verdictTranslations, accusationTranslations } from './types';

function AddCase() {
  const navigate = useNavigate();
  const { register, handleSubmit, control, formState: { errors }, reset, setValue, watch, getValues } = useForm<Verdict>({
    defaultValues: {
      id: undefined,
      caseId: '',
      court: '',
      caseNumber: '',
      verdictDate: null,
      judge: '',
      clerk: '',
      prosecutor: '',
      defendantNames: [],
      victim: '',
      shortDescription: '',
      judgment: null,
      appliedProvisions: '',
      accusations: [],
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
    },
  });
  const [reasonResult, setReasonResult] = useState<ReasonResponse | null>(null);
  const [openModal, setOpenModal] = useState(false);
  const [metadataModalOpen, setMetadataModalOpen] = useState(false);
  const [selectedCase, setSelectedCase] = useState<Verdict | null>(null);
  const [accusationOptions, setAccusationOptions] = useState<string[]>([]);
  const [selectedVerdict, setSelectedVerdict] = useState<string | null>(null);
  const [monetaryPenalty, setMonetaryPenalty] = useState<number | null>(null);
  const [prisonPenalty, setPrisonPenalty] = useState<number | null>(null);
  const [snackbar, setSnackbar] = useState<{ open: boolean, message: string, severity: 'success' | 'error' }>({
    open: false,
    message: '',
    severity: 'success',
  });
  const accusationsWatch = watch('accusations');
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

  const onSubmit = (data: Verdict) => {
    const caseDescription = {
      caseId: data.caseId,
      defendantNames: data.defendantNames,
      victim: data.victim,
      accusationTypes: data.accusations.map(acc => {
        const match = acc.match(/^čl\. (\d+)(?:\s*st\. (\d+))?$/i);
        return match ? (match[2] ? `ARTICLE_${match[1]}_ST_${match[2]}` : `ARTICLE_${match[1]}_NONE`) : 'OTHER';
      }),
      judgment: data.judgment,
      isMovableProperty: data.isMovableProperty,
      isTaken: data.isTaken,
      intentToAppropriate: data.intentToAppropriate,
      valueOfStolenItems: data.valueOfStolenItems,
      breakingAndEntering: data.breakingAndEntering,
      useOfForceOrThreat: data.useOfForceOrThreat,
      caughtInTheAct: data.caughtInTheAct,
      causedSevereInjury: data.causedSevereInjury,
      deathCaused: data.deathCaused,
      monetaryPenalty: null,
      prisonPenalty: null,
    };
    axios.post<ReasonResponse>('/api/cases/reason', caseDescription)
      .then(res => {
        setReasonResult({ ...res.data, caseDescription });
        setSelectedVerdict(data.judgment);
        setOpenModal(true);
      })
      .catch(err => {
        console.error(err);
        setSnackbar({ open: true, message: 'Greška prilikom obrade slučaja', severity: 'error' });
      });
  };

  const handleConfirmAdd = () => {
    if (reasonResult && selectedVerdict) {
      const formData = getValues();
      const caseData: Verdict = {
        ...formData,
        judgment: selectedVerdict,
        monetaryPenalty: shouldShowMonetary(selectedVerdict) ? monetaryPenalty : null,
        prisonPenalty: shouldShowPrison(selectedVerdict) ? prisonPenalty : null,
      };
      axios.post('/api/cases/add', caseData)
        .then(res => {
          setSnackbar({ open: true, message: 'Slučaj uspješno dodan!', severity: 'success' });
          setOpenModal(false);
          reset();
          setSelectedVerdict(null);
          setMonetaryPenalty(null);
          setPrisonPenalty(null);
        })
        .catch(err => {
          console.error(err);
          setSnackbar({ open: true, message: 'Greška prilikom dodavanja slučaja', severity: 'error' });
        });
    }
  };

  const handleCloseModal = () => {
    setOpenModal(false);
    setReasonResult(null);
    setSelectedVerdict(null);
    setMonetaryPenalty(null);
    setPrisonPenalty(null);
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

  const shouldShowMonetary = (verdict: string) => ['FINE', 'FINE_AND_PRISON'].includes(verdict);
  const shouldShowPrison = (verdict: string) => ['PRISON', 'FINE_AND_PRISON'].includes(verdict);

  useEffect(() => {
    if (selectedVerdict && !shouldShowMonetary(selectedVerdict)) {
      setMonetaryPenalty(null);
    }
    if (selectedVerdict && !shouldShowPrison(selectedVerdict)) {
      setPrisonPenalty(null);
    }
  }, [selectedVerdict]);

  return (
    <Box sx={{ maxWidth: 1200, mx: 'auto', my: 4, p: 3, bgcolor: 'background.paper', borderRadius: 2, boxShadow: 3 }}>
      <Typography variant="h4" gutterBottom sx={{ fontWeight: 'bold', color: 'primary.main' }}>
        Dodaj novi slučaj
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
          <TextField
            label="Sud"
            {...register('court', { required: 'Sud je obavezan' })}
            fullWidth
            margin="normal"
            error={!!errors.court}
            helperText={errors.court?.message}
            variant="outlined"
          />
          <TextField
            label="Broj presude"
            {...register('caseNumber', { required: 'Broj presude je obavezan' })}
            fullWidth
            margin="normal"
            error={!!errors.caseNumber}
            helperText={errors.caseNumber?.message}
            variant="outlined"
          />
          <TextField
            label="Datum presude"
            type="date"
            {...register('verdictDate', { required: 'Datum presude je obavezan' })}
            fullWidth
            margin="normal"
            InputLabelProps={{ shrink: true }}
            error={!!errors.verdictDate}
            helperText={errors.verdictDate?.message}
            variant="outlined"
          />
        </Box>
        <Typography variant="h6" sx={{ mt: 3, mb: 1, fontWeight: 'medium' }}>Učesnici</Typography>
        <Box sx={{ display: 'grid', gridTemplateColumns: { xs: '1fr', md: '1fr 1fr' }, gap: 2 }}>
          <TextField
            label="Sudija"
            {...register('judge', { required: 'Ime sudije je obavezno' })}
            fullWidth
            margin="normal"
            error={!!errors.judge}
            helperText={errors.judge?.message}
            variant="outlined"
          />
          <TextField
            label="Pisar"
            {...register('clerk')}
            fullWidth
            margin="normal"
            error={!!errors.clerk}
            helperText={errors.clerk?.message}
            variant="outlined"
          />
          <TextField
            label="Tužilac"
            {...register('prosecutor', { required: 'Tužilac je obavezan' })}
            fullWidth
            margin="normal"
            error={!!errors.prosecutor}
            helperText={errors.prosecutor?.message}
            variant="outlined"
          />
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
            value={watch('accusations') || []}
            onChange={(event, newValue) => setValue('accusations', newValue)}
            renderTags={(value, getTagProps) =>
              value.map((option, index) => (
                <Chip variant="outlined" label={option} {...getTagProps({ index })} />
              ))
            }
            renderInput={(params) => (
              <TextField
                {...params}
                label="Optužbe"
                helperText={errors.accusations?.message || 'Izaberite optužbe (npr. čl. 239 st. 1)'}
                fullWidth
                margin="normal"
                error={!!errors.accusations}
                variant="outlined"
              />
            )}
          />
          <TextField
            label="Primijenjene odredbe"
            {...register('appliedProvisions', { required: 'Primijenjene odredbe su obavezne' })}
            fullWidth
            margin="normal"
            error={!!errors.appliedProvisions}
            helperText={errors.appliedProvisions?.message}
            variant="outlined"
          />
          <TextField
            label="Kratak opis"
            {...register('shortDescription', { required: 'Kratak opis je obavezan' })}
            fullWidth
            margin="normal"
            multiline
            rows={4}
            error={!!errors.shortDescription}
            helperText={errors.shortDescription?.message}
            variant="outlined"
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
        >
          Obradi i dodaj slučaj
        </Button>
      </form>
      <Dialog open={openModal} onClose={handleCloseModal} maxWidth="md" fullWidth sx={{ '& .MuiDialog-paper': { borderRadius: 2 } }}>
        <DialogTitle sx={{ bgcolor: 'primary.main', color: 'white', fontWeight: 'bold' }}>
          Rezultati obrade
        </DialogTitle>
        <DialogContent sx={{ p: 3 }}>
          {reasonResult ? (
            <>
              <Typography variant="h6" sx={{ mb: 2, fontWeight: 'medium' }}>
                Moj izbor: <strong>{verdictTranslations[reasonResult.caseDescription.judgment || 'NONE']}</strong>
              </Typography>
              <Typography variant="h6" sx={{ mb: 2, fontWeight: 'medium' }}>
                Rasudjivanje po slučaju: <strong>{verdictTranslations[reasonResult.predictedVerdict]}</strong>
              </Typography>
              <Typography variant="h6" sx={{ mb: 2, fontWeight: 'medium' }}>
                Rasudjivanje po pravilima: <strong>{verdictTranslations[reasonResult.drDeviceResults.judgment]}</strong>
              </Typography>
              <Typography variant="body1" sx={{ mb: 2 }}>
                Kazna (po pravilima): {reasonResult.drDeviceResults.penalty}
              </Typography>
              <Typography variant="body1" sx={{ mb: 3 }}>
                Optužba (po pravilima): {reasonResult.drDeviceResults.accusation}
              </Typography>
              <FormControl fullWidth sx={{ mb: 3 }}>
                <InputLabel>Konačna presuda za spremanje</InputLabel>
                <Select
                  value={selectedVerdict || ''}
                  onChange={(e) => setSelectedVerdict(e.target.value)}
                >
                  <MenuItem value={reasonResult.caseDescription.judgment || 'NONE'}>
                    Moj izbor ({verdictTranslations[reasonResult.caseDescription.judgment || 'NONE']})
                  </MenuItem>
                  <MenuItem value={reasonResult.predictedVerdict}>
                    Rasudjivanje po slučaju ({verdictTranslations[reasonResult.predictedVerdict]})
                  </MenuItem>
                  <MenuItem value={reasonResult.drDeviceResults.judgment}>
                    Rasudjivanje po pravilima ({verdictTranslations[reasonResult.drDeviceResults.judgment]})
                  </MenuItem>
                </Select>
              </FormControl>
              {selectedVerdict && (
                <Box sx={{ display: 'grid', gridTemplateColumns: { xs: '1fr', md: '1fr 1fr' }, gap: 2, mb: 3 }}>
                  {shouldShowMonetary(selectedVerdict) && (
                    <TextField
                      label="Novčana kazna (€)"
                      type="number"
                      value={monetaryPenalty ?? ''}
                      onChange={(e) => setMonetaryPenalty(e.target.value ? Number(e.target.value) : null)}
                      fullWidth
                      variant="outlined"
                    />
                  )}
                  {shouldShowPrison(selectedVerdict) && (
                    <TextField
                      label="Godine zatvora"
                      type="number"
                      value={prisonPenalty ?? ''}
                      onChange={(e) => setPrisonPenalty(e.target.value ? Number(e.target.value) : null)}
                      fullWidth
                      variant="outlined"
                    />
                  )}
                </Box>
              )}
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
                    {reasonResult.similarCases.map((sc, index) => (
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
                  onClick={handleConfirmAdd}
                  variant="contained"
                  color="primary"
                  sx={{ flex: 1, py: 1.5, fontSize: '1.1rem', textTransform: 'none' }}
                  disabled={!selectedVerdict}
                >
                  Potvrdi dodavanje
                </Button>
                <Button
                  onClick={handleCloseModal}
                  variant="outlined"
                  color="secondary"
                  sx={{ flex: 1, py: 1.5, fontSize: '1.1rem', textTransform: 'none' }}
                >
                  Otkaži
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

export default AddCase;