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
  const [snackbar, setSnackbar] = useState<{ open: boolean, message: string, severity: 'success' | 'error' }>({
    open: false,
    message: '',
    severity: 'success',
  });
  const deathCausedWatch = watch('deathCaused');
  const judgmentWatch = watch('judgment');

  useEffect(() => {
    axios.get<string[]>('/api/cases/accusations')
      .then(res => setAccusationOptions(res.data))
      .catch(err => {
        console.error(err);
        setSnackbar({ open: true, message: 'Greška pri dohvatanju optužbi', severity: 'error' });
      });
  }, []);

  useEffect(() => {
    if (deathCausedWatch) {
      setValue('causedSevereInjury', true);
    }
  }, [deathCausedWatch, setValue]);

  useEffect(() => {
    if (judgmentWatch) {
      if (!['FINE', 'FINE_AND_PRISON'].includes(judgmentWatch)) {
        setValue('monetaryPenalty', null);
      }
      if (!['PRISON', 'FINE_AND_PRISON'].includes(judgmentWatch)) {
        setValue('prisonPenalty', null);
      }
    }
  }, [judgmentWatch, setValue]);

  const onSubmit = (data: Verdict) => {
    const caseDescription = {
      caseId: data.caseId,
      defendantNames: data.defendantNames.length > 0 ? [data.defendantNames[0]] : [],
      accusationTypes: data.accusations.map(acc => {
        const match = acc.match(/^čl\. (\d+)(?:\s*st\. (\d+))?(?:\s*tač\. (\d+))?$/i);
        if (!match) return 'OTHER';
        const article = match[1];
        const paragraph = match[2] || 'NONE';
        const point = match[3] ? `_TAC_${match[3]}` : '';
        return `ARTICLE_${article}_ST_${paragraph}${point}`;
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
      monetaryPenalty: ['FINE', 'FINE_AND_PRISON'].includes(data.judgment || '') ? data.monetaryPenalty : null,
      prisonPenalty: ['PRISON', 'FINE_AND_PRISON'].includes(data.judgment || '') ? data.prisonPenalty : null,
    };
    console.log('Payload to /api/cases/reason:', caseDescription);
    axios.post<ReasonResponse>('/api/cases/reason', caseDescription)
      .then(res => {
        setReasonResult({ ...res.data, caseDescription });
        setSelectedVerdict(null);
        setOpenModal(true);
      })
      .catch(err => {
        console.error(err);
        setSnackbar({ open: true, message: `Greška prilikom obrade slučaja: ${err.response?.data?.message || err.message}`, severity: 'error' });
      });
  };

  const handleConfirmAdd = () => {
    if (reasonResult && selectedVerdict) {
      const formData = getValues();
      const verdictValue = selectedVerdict.split('*')[1];
      const caseData: Verdict = {
        ...formData,
        judgment: verdictValue,
        monetaryPenalty: ['FINE', 'FINE_AND_PRISON'].includes(verdictValue) ? formData.monetaryPenalty : null,
        prisonPenalty: ['PRISON', 'FINE_AND_PRISON'].includes(verdictValue) ? formData.prisonPenalty : null,
        defendantNames: formData.defendantNames.length > 0 ? [formData.defendantNames[0]] : [],
        appliedProvisions: formData.appliedProvisions || '',
      };
      console.log('Payload to /api/cases/add:', caseData);
      axios.post('/api/cases/add', caseData)
        .then(res => {
          setSnackbar({ open: true, message: 'Slučaj uspješno dodan!', severity: 'success' });
          setOpenModal(false);
          reset();
          setSelectedVerdict(null);
        })
        .catch(err => {
          console.error(err);
          setSnackbar({ open: true, message: `Greška prilikom dodavanja slučaja: ${err.response?.data?.message || err.message}`, severity: 'error' });
        });
    }
  };

  const handleCloseModal = () => {
    setOpenModal(false);
    setReasonResult(null);
    setSelectedVerdict(null);
  };

  const handleMetadataOpen = (caseId: string) => {
    axios.get<Verdict>(`/api/cases/${caseId}`)
      .then(res => {
        setSelectedCase(res.data);
        setMetadataModalOpen(true);
      })
      .catch(err => {
        console.error(err);
        setSnackbar({ open: true, message: `Greška pri dohvatanju metapodataka: ${err.response?.data?.message || err.message}`, severity: 'error' });
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
          <TextField
            label="Ime optuženog"
            {...register('defendantNames.0', { required: 'Ime optuženog je obavezno' })}
            fullWidth
            margin="normal"
            error={!!errors.defendantNames?.[0]}
            helperText={errors.defendantNames?.[0]?.message || 'Unesite ime optuženog'}
            variant="outlined"
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
                helperText={errors.accusations?.message || 'Izaberite optužbe (npr. čl. 240 st. 1)'}
                fullWidth
                margin="normal"
                error={!!errors.accusations}
                variant="outlined"
              />
            )}
          />
          <TextField
            label="Primijenjene odredbe"
            {...register('appliedProvisions')}
            fullWidth
            margin="normal"
            error={!!errors.appliedProvisions}
            helperText={errors.appliedProvisions?.message || 'Unesite odredbe (npr. krivični čl. 240 st. 1 tač. 1, ZKP čl. 226)'}
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
                <Select
                  {...field}
                  label="Tip presude"
                  value={field.value || ''}
                  onChange={(e) => {
                    console.log('Selected judgment:', e.target.value);
                    field.onChange(e.target.value);
                  }}
                >
                  {Object.entries(verdictTranslations).map(([key, value]) => (
                    key !== 'NONE' && <MenuItem key={key} value={key}>{value}</MenuItem>
                  ))}
                </Select>
              )}
            />
            {errors.judgment && <Typography color="error">{errors.judgment.message}</Typography>}
          </FormControl>
          {shouldShowMonetary(judgmentWatch || '') && (
            <TextField
              label="Novčana kazna (€)"
              type="number"
              {...register('monetaryPenalty', {
                valueAsNumber: true,
                min: { value: 0, message: 'Novčana kazna mora biti nenegativna' },
              })}
              fullWidth
              margin="normal"
              error={!!errors.monetaryPenalty}
              helperText={errors.monetaryPenalty?.message}
              variant="outlined"
            />
          )}
          {shouldShowPrison(judgmentWatch || '') && (
            <TextField
              label="Godine zatvora"
              type="number"
              {...register('prisonPenalty', {
                valueAsNumber: true,
                min: { value: 0, message: 'Godine zatvora moraju biti nenegativne' },
              })}
              fullWidth
              margin="normal"
              error={!!errors.prisonPenalty}
              helperText={errors.prisonPenalty?.message}
              variant="outlined"
            />
          )}
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
                Rasuđivanje po slučaju: <strong>{verdictTranslations[reasonResult.predictedVerdict]}</strong>
              </Typography>
              <Typography variant="h6" sx={{ mb: 2, fontWeight: 'medium' }}>
                Rasuđivanje po pravilima: <strong>{verdictTranslations[reasonResult.drDeviceResults.judgment]}</strong>
              </Typography>
              <Typography variant="body1" sx={{ mb: 2 }}>
                Kazna (po pravilima): {reasonResult.drDeviceResults.penalty}
              </Typography>
              <Typography variant="body1" sx={{ mb: 3 }}>
                Optužba (po pravilima): {reasonResult.drDeviceResults.accusation}
              </Typography>
              <FormControl fullWidth sx={{ mb: 3 }}>
                <InputLabel>Konačna presuda</InputLabel>
                <Select
                  value={selectedVerdict || ''}
                  onChange={(e) => {
                    setSelectedVerdict(e.target.value);
                    const verdictValue = e.target.value.split('*')[1];
                    console.log(verdictValue)
                    if (!shouldShowMonetary(verdictValue)) {
                      setValue('monetaryPenalty', null);
                    }
                    if (!shouldShowPrison(verdictValue)) {
                      setValue('prisonPenalty', null);
                    }
                  }}
                >
                  <MenuItem value="" disabled>Izaberite presudu</MenuItem>
                  <MenuItem value={`user*${reasonResult.caseDescription.judgment || 'NONE'}`}>
                    Moj izbor ({verdictTranslations[reasonResult.caseDescription.judgment || 'NONE']})
                  </MenuItem>
                  <MenuItem value={`case*${reasonResult.predictedVerdict}`}>
                    Rasuđivanje po slučaju ({verdictTranslations[reasonResult.predictedVerdict]})
                  </MenuItem>
                  {reasonResult.drDeviceResults.judgment !== 'NONE' && (
                    <MenuItem value={`rule*${reasonResult.drDeviceResults.judgment}`}>
                      Rasuđivanje po pravilima ({verdictTranslations[reasonResult.drDeviceResults.judgment]})
                    </MenuItem>
                  )}
                </Select>
              </FormControl>
              {selectedVerdict && (
                <Box sx={{ display: 'grid', gridTemplateColumns: { xs: '1fr', md: '1fr 1fr' }, gap: 2, mb: 3 }}>
                  {shouldShowMonetary(selectedVerdict.split('*')[1]) && (
                    <TextField
                      label="Novčana kazna (€)"
                      type="number"
                      {...register('monetaryPenalty', {
                        valueAsNumber: true,
                        min: { value: 0, message: 'Novčana kazna mora biti nenegativna' },
                      })}
                      fullWidth
                      variant="outlined"
                      error={!!errors.monetaryPenalty}
                      helperText={errors.monetaryPenalty?.message}
                    />
                  )}
                  {shouldShowPrison(selectedVerdict.split('*')[1]) && (
                    <TextField
                      label="Godine zatvora"
                      type="number"
                      {...register('prisonPenalty', {
                        valueAsNumber: true,
                        min: { value: 0, message: 'Godine zatvora moraju biti nenegativne' },
                      })}
                      fullWidth
                      variant="outlined"
                      error={!!errors.prisonPenalty}
                      helperText={errors.prisonPenalty?.message}
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
              <Typography><b>Ime optuženog:</b> {selectedCase.defendantNames[0] || 'Nije navedeno'}</Typography>
              <Typography><b>Žrtva:</b> {selectedCase.victim || 'Nije navedena'}</Typography>
              <Typography><b>Kratak opis:</b> {selectedCase.shortDescription}</Typography>
              <Typography><b>Presuda:</b> {verdictTranslations[selectedCase.judgment || 'NONE']}</Typography>
              <Typography><b>Primenjene odredbe:</b> {selectedCase.appliedProvisions || 'Nema'}</Typography>
              <Typography><b>Optužbe:</b> {selectedCase.accusations.join(', ')}</Typography>
              <Typography><b>Vrsta stvari (tuđa i pokretna):</b> {selectedCase.isMovableProperty ? 'Da' : 'Ne'}</Typography>
              <Typography><b>Radnja oduzimanja:</b> {selectedCase.isTaken ? 'Da' : 'Ne'}</Typography>
              <Typography><b>Namera prisvajanja:</b> {selectedCase.intentToAppropriate ? 'Da' : 'Ne'}</Typography>
              <Typography><b>Vrednost ukradenih stvari (€):</b> {selectedCase.valueOfStolenItems}</Typography>
              <Typography><b>Provala:</b> {selectedCase.breakingAndEntering ? 'Da' : 'Ne'}</Typography>
              <Typography><b>Upotreba sile ili prtnje:</b> {selectedCase.useOfForceOrThreat ? 'Da' : 'Ne'}</Typography>
              <Typography><b>Zatečenost na delu:</b> {selectedCase.caughtInTheAct ? 'Da' : 'Ne'}</Typography>
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