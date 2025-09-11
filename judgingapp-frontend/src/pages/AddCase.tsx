import { useForm, Controller } from 'react-hook-form'
import {
  Box, Button, TextField, Typography, Select, MenuItem, FormControl, InputLabel,
  Dialog, DialogTitle, DialogContent, Table, TableContainer, TableHead, TableRow,
  TableCell, TableBody, Paper, Autocomplete, Chip, Divider, Snackbar, Alert,
  CircularProgress
} from '@mui/material'
import axios from 'axios'
import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import type { Verdict, ReasonResponse } from './types'

function AddCase() {
  const navigate = useNavigate()
  const { register, handleSubmit, control, formState: { errors }, reset, setValue, watch, getValues } =
    useForm<Verdict>({
      defaultValues: {
        caseId: '',
        court: '',
        verdictNumber: '',
        date: null,
        judgeName: '',
        clerkName: '',
        prosecutor: '',
        defendantName: '',
        criminalOffense: '',
        appliedProvisions: '',
        verdictType: null,
        awareOfIllegality: true,
        mainVictimRelationship: null,
        violenceNature: null,
        injuryTypes: null,
        protectionMeasureViolation: false,
        eventLocation: '',
        eventDate: null,
        defendantStatus: '',
        victims: '',
        mainVictimAge: 0,
        alcoholOrDrugs: false,
        childrenPresent: false,
        penalty: '',
        procedureCosts: '',
        useOfWeapon: false,
        numberOfVictims: 0,
        xmlFileName: '',
      },
    })

  const [reasonResult, setReasonResult] = useState<ReasonResponse | null>(null)
  const [openModal, setOpenModal] = useState(false)
  const [statusOptions, setStatusOptions] = useState<string[]>([])
  const [criminalOffenseOptions, setCriminalOffenseOptions] = useState<string[]>([])
  const [appliedProvisionsOptions, setAppliedProvisionsOptions] = useState<string[]>([])
  const [selectedVerdict, setSelectedVerdict] = useState<string | null>(null)
  const [snackbar, setSnackbar] = useState<{ open: boolean, message: string, severity: 'success' | 'error' }>({
    open: false,
    message: '',
    severity: 'success',
  })

  const statusChoices = ['unemployed', 'married', 'father of children', 'retired']
  const statuteChoices = ['st. 1', 'st. 2', 'st. 3', 'st. 4', 'st. 5']
  const clauseChoices = Array.from({ length: 500 }, (_, i) => (i + 1).toString()) // cl. 1 to cl. 500

  const victimsWatch = watch('victims')

  useEffect(() => {
    const victimList = victimsWatch ? victimsWatch.split(',').map(v => v.trim()).filter(v => v.length > 0) : []
    setValue('numberOfVictims', victimList.length)
  }, [victimsWatch, setValue])

  const onSubmit = (data: Verdict) => {
    axios.post<ReasonResponse>('/api/cases/reason', data)
      .then(res => {
        setReasonResult({ ...res.data, caseDescription: data })
        setSelectedVerdict(data.verdictType)
        setOpenModal(true)
      })
      .catch(err => {
        console.error(err)
        setSnackbar({ open: true, message: 'Error during reasoning', severity: 'error' })
      })
  }

  const handleConfirmAdd = () => {
    if (reasonResult && selectedVerdict) {
      const formData = getValues()
      const caseData: Verdict = {
        ...formData,
        verdictType: selectedVerdict,
      }
      axios.post('/api/cases/add', caseData)
        .then(res => {
          console.log('Case added:', res.data)
          setSnackbar({ open: true, message: 'Case added successfully!', severity: 'success' })
          setOpenModal(false)
          reset()
          setStatusOptions([])
          setCriminalOffenseOptions([])
          setAppliedProvisionsOptions([])
          setSelectedVerdict(null)
        })
        .catch(err => {
          console.error(err)
          setSnackbar({ open: true, message: 'Error adding case', severity: 'error' })
        })
    }
  }

  const handleCloseModal = () => {
    setOpenModal(false)
    setReasonResult(null)
    setStatusOptions([])
    setCriminalOffenseOptions([])
    setAppliedProvisionsOptions([])
    setSelectedVerdict(null)
  }

  const handleSnackbarClose = () => {
    setSnackbar({ ...snackbar, open: false })
  }

  return (
    <Box sx={{ maxWidth: 1200, mx: 'auto', my: 4, p: 3, bgcolor: 'background.paper', borderRadius: 2, boxShadow: 3 }}>
      <Typography variant="h4" gutterBottom sx={{ fontWeight: 'bold', color: 'primary.main' }}>
        Add New Case
      </Typography>
      <Divider sx={{ mb: 3 }} />

      <form onSubmit={handleSubmit(onSubmit)}>
        {/* Case Identification */}
        <Typography variant="h6" sx={{ mt: 2, mb: 1, fontWeight: 'medium' }}>Case Identification</Typography>
        <Box sx={{ display: 'grid', gridTemplateColumns: { xs: '1fr', md: '1fr 1fr' }, gap: 2 }}>
          <TextField
            label="Case ID"
            {...register('caseId', { required: 'Case ID is required' })}
            fullWidth
            margin="normal"
            error={!!errors.caseId}
            helperText={errors.caseId?.message}
            variant="outlined"
          />
          <TextField
            label="Court"
            {...register('court', { required: 'Court is required' })}
            fullWidth
            margin="normal"
            error={!!errors.court}
            helperText={errors.court?.message}
            variant="outlined"
          />
          <TextField
            label="Verdict Number"
            {...register('verdictNumber', { required: 'Verdict Number is required' })}
            fullWidth
            margin="normal"
            error={!!errors.verdictNumber}
            helperText={errors.verdictNumber?.message}
            variant="outlined"
          />
          <TextField
            label="Verdict Date"
            type="date"
            {...register('date', { required: 'Verdict Date is required' })}
            fullWidth
            margin="normal"
            InputLabelProps={{ shrink: true }}
            error={!!errors.date}
            helperText={errors.date?.message}
            variant="outlined"
          />
        </Box>

        {/* Parties Involved */}
        <Typography variant="h6" sx={{ mt: 3, mb: 1, fontWeight: 'medium' }}>Parties Involved</Typography>
        <Box sx={{ display: 'grid', gridTemplateColumns: { xs: '1fr', md: '1fr 1fr' }, gap: 2 }}>
          <TextField
            label="Judge Name"
            {...register('judgeName', { required: 'Judge Name is required' })}
            fullWidth
            margin="normal"
            error={!!errors.judgeName}
            helperText={errors.judgeName?.message}
            variant="outlined"
          />
          <TextField
            label="Clerk Name"
            {...register('clerkName')}
            fullWidth
            margin="normal"
            error={!!errors.clerkName}
            helperText={errors.clerkName?.message}
            variant="outlined"
          />
          <TextField
            label="Prosecutor"
            {...register('prosecutor', { required: 'Prosecutor is required' })}
            fullWidth
            margin="normal"
            error={!!errors.prosecutor}
            helperText={errors.prosecutor?.message}
            variant="outlined"
          />
          <TextField
            label="Defendant Name"
            {...register('defendantName', { required: 'Defendant Name is required' })}
            fullWidth
            margin="normal"
            error={!!errors.defendantName}
            helperText={errors.defendantName?.message}
            variant="outlined"
          />
          <TextField
            label="Victims (comma separated)"
            {...register('victims', { required: 'Victims are required' })}
            fullWidth
            margin="normal"
            error={!!errors.victims}
            helperText={errors.victims?.message || 'Enter victims separated by commas (e.g., Victim1, Victim2)'}
            variant="outlined"
          />
        </Box>

        {/* Case Details */}
        <Typography variant="h6" sx={{ mt: 3, mb: 1, fontWeight: 'medium' }}>Case Details</Typography>
        <Box sx={{ display: 'grid', gridTemplateColumns: { xs: '1fr', md: '1fr 1fr' }, gap: 2 }}>
          <Autocomplete
            multiple
            options={statuteChoices}
            value={criminalOffenseOptions}
            onChange={(event, newValue) => {
              setCriminalOffenseOptions(newValue)
              setValue('criminalOffense', newValue.length > 0 ? `cl. 220 ${newValue.join(', ')}` : '')
            }}
            renderTags={(value, getTagProps) =>
              value.map((option, index) => (
                <Chip variant="outlined" label={option} {...getTagProps({ index })} />
              ))
            }
            renderInput={(params) => (
              <TextField
                {...params}
                label="Criminal Offense"
                helperText="Select statutes for cl. 220"
                fullWidth
                margin="normal"
                error={!!errors.criminalOffense}
                variant="outlined"
              />
            )}
          />
          <Autocomplete
            multiple
            freeSolo
            options={clauseChoices}
            value={appliedProvisionsOptions}
            onChange={(event, newValue) => {
              setAppliedProvisionsOptions(newValue)
              const formatted = newValue.map(v => {
                const match = v.match(/^(\d+)(?:\s*st\.(\d+))?$/i)
                if (match) {
                  return match[2] ? `cl. ${match[1]} st. ${match[2]}` : `cl. ${match[1]}`
                }
                return v
              }).join(', ')
              setValue('appliedProvisions', formatted)
            }}
            renderTags={(value, getTagProps) =>
              value.map((option, index) => (
                <Chip variant="outlined" label={option} {...getTagProps({ index })} />
              ))
            }
            renderInput={(params) => (
              <TextField
                {...params}
                label="Applied Provisions"
                helperText={errors.appliedProvisions?.message || "Enter clauses (e.g., '3', '226 st. 3', '374')"}
                fullWidth
                margin="normal"
                error={!!errors.appliedProvisions}
                variant="outlined"
              />
            )}
          />
          <Controller
            name="appliedProvisions"
            control={control}
            rules={{
              validate: value => {
                if (!value) return true
                const clauses = value.split(',').map(c => c.trim())
                return clauses.every(c => /^cl\. \d+( st\.\d+)?$/.test(c)) || "Enter in format 'cl. [number]' or 'cl. [number] st.[number]' (e.g., 'cl. 200', 'cl. 226 st. 3')"
              }
            }}
            render={({ field }) => <input type="hidden" {...field} />}
          />
          <FormControl fullWidth margin="normal" error={!!errors.verdictType}>
            <InputLabel>Verdict Type</InputLabel>
            <Controller
              name="verdictType"
              control={control}
              rules={{ required: 'Verdict Type is required' }}
              render={({ field }) => (
                <Select {...field} label="Verdict Type" value={field.value || ''}>
                  <MenuItem value="ACQUITTAL">Acquittal</MenuItem>
                  <MenuItem value="FINE">Fine</MenuItem>
                  <MenuItem value="PRISON">Prison</MenuItem>
                  <MenuItem value="SUSPENDED">Suspended</MenuItem>
                  <MenuItem value="FINE_AND_PRISON">Fine and Prison</MenuItem>
                  <MenuItem value="DISMISSAL">Dismissal</MenuItem>
                </Select>
              )}
            />
            {errors.verdictType && <Typography color="error">{errors.verdictType.message}</Typography>}
          </FormControl>
        </Box>

        {/* Incident Details */}
        <Typography variant="h6" sx={{ mt: 3, mb: 1, fontWeight: 'medium' }}>Incident Details</Typography>
        <Box sx={{ display: 'grid', gridTemplateColumns: { xs: '1fr', md: '1fr 1fr' }, gap: 2 }}>
          <TextField
            label="Event Location"
            {...register('eventLocation', { required: 'Event Location is required' })}
            fullWidth
            margin="normal"
            error={!!errors.eventLocation}
            helperText={errors.eventLocation?.message}
            variant="outlined"
          />
          <TextField
            label="Event Date"
            type="date"
            {...register('eventDate', { required: 'Event Date is required' })}
            fullWidth
            margin="normal"
            InputLabelProps={{ shrink: true }}
            error={!!errors.eventDate}
            helperText={errors.eventDate?.message}
            variant="outlined"
          />
          <FormControl fullWidth margin="normal" error={!!errors.violenceNature}>
            <InputLabel>Violence Nature</InputLabel>
            <Controller
              name="violenceNature"
              control={control}
              rules={{ required: 'Violence Nature is required' }}
              render={({ field }) => (
                <Select {...field} label="Violence Nature" value={field.value || ''}>
                  <MenuItem value="NONE">None</MenuItem>
                  <MenuItem value="PHYSICAL">Physical</MenuItem>
                  <MenuItem value="PSYCHOLOGICAL">Psychological</MenuItem>
                </Select>
              )}
            />
            {errors.violenceNature && <Typography color="error">{errors.violenceNature.message}</Typography>}
          </FormControl>
          <FormControl fullWidth margin="normal" error={!!errors.injuryTypes}>
            <InputLabel>Injury Types</InputLabel>
            <Controller
              name="injuryTypes"
              control={control}
              rules={{ required: 'Injury Types is required' }}
              render={({ field }) => (
                <Select {...field} label="Injury Types" value={field.value || ''}>
                  <MenuItem value="NONE">None</MenuItem>
                  <MenuItem value="MINOR">Minor</MenuItem>
                  <MenuItem value="SERIOUS">Serious</MenuItem>
                  <MenuItem value="DEATH">Death</MenuItem>
                </Select>
              )}
            />
            {errors.injuryTypes && <Typography color="error">{errors.injuryTypes.message}</Typography>}
          </FormControl>
          <FormControl fullWidth margin="normal">
            <InputLabel>Use of Weapon</InputLabel>
            <Controller
              name="useOfWeapon"
              control={control}
              render={({ field }) => (
                <Select
                  {...field}
                  label="Use of Weapon"
                  onChange={(e) => field.onChange(e.target.value === 'true')}
                  value={field.value ? 'true' : 'false'}
                >
                  <MenuItem value="true">Yes</MenuItem>
                  <MenuItem value="false">No</MenuItem>
                </Select>
              )}
            />
          </FormControl>
          <FormControl fullWidth margin="normal">
            <InputLabel>Protection Measure Violation</InputLabel>
            <Controller
              name="protectionMeasureViolation"
              control={control}
              render={({ field }) => (
                <Select
                  {...field}
                  label="Protection Measure Violation"
                  onChange={(e) => field.onChange(e.target.value === 'true')}
                  value={field.value ? 'true' : 'false'}
                >
                  <MenuItem value="true">Yes</MenuItem>
                  <MenuItem value="false">No</MenuItem>
                </Select>
              )}
            />
          </FormControl>
        </Box>

        {/* Defendant Information */}
        <Typography variant="h6" sx={{ mt: 3, mb: 1, fontWeight: 'medium' }}>Defendant Information</Typography>
        <Box sx={{ display: 'grid', gridTemplateColumns: { xs: '1fr', md: '1fr 1fr' }, gap: 2 }}>
          <Autocomplete
            multiple
            freeSolo
            options={statusChoices}
            value={statusOptions}
            onChange={(event, newValue) => {
              setStatusOptions(newValue)
              setValue('defendantStatus', newValue.join(', '))
            }}
            renderTags={(value, getTagProps) =>
              value.map((option, index) => (
                <Chip variant="outlined" label={option} {...getTagProps({ index })} />
              ))
            }
            renderInput={(params) => (
              <TextField
                {...params}
                label="Defendant Status"
                helperText="Select or add statuses (comma-separated)"
                fullWidth
                margin="normal"
                error={!!errors.defendantStatus}
                variant="outlined"
              />
            )}
          />
          <FormControl fullWidth margin="normal">
            <InputLabel>Aware of Illegality</InputLabel>
            <Controller
              name="awareOfIllegality"
              control={control}
              render={({ field }) => (
                <Select
                  {...field}
                  label="Aware of Illegality"
                  onChange={(e) => field.onChange(e.target.value === 'true')}
                  value={field.value ? 'true' : 'false'}
                >
                  <MenuItem value="true">Yes</MenuItem>
                  <MenuItem value="false">No</MenuItem>
                </Select>
              )}
            />
          </FormControl>
        </Box>

        {/* Victim Information */}
        <Typography variant="h6" sx={{ mt: 3, mb: 1, fontWeight: 'medium' }}>Victim Information</Typography>
        <Box sx={{ display: 'grid', gridTemplateColumns: { xs: '1fr', md: '1fr 1fr' }, gap: 2 }}>
          <TextField
            label="Number of Victims"
            type="number"
            {...register('numberOfVictims', { valueAsNumber: true })}
            fullWidth
            margin="normal"
            disabled
            helperText="Automatically calculated from Victims field"
            variant="outlined"
          />
          <TextField
            label="Main Victim Age"
            type="number"
            {...register('mainVictimAge', { valueAsNumber: true })}
            fullWidth
            margin="normal"
            error={!!errors.mainVictimAge}
            helperText={errors.mainVictimAge?.message}
            variant="outlined"
          />
          <FormControl fullWidth margin="normal" error={!!errors.mainVictimRelationship}>
            <InputLabel>Main Victim Relationship</InputLabel>
            <Controller
              name="mainVictimRelationship"
              control={control}
              rules={{ required: 'Main Victim Relationship is required' }}
              render={({ field }) => (
                <Select {...field} label="Main Victim Relationship" value={field.value || ''}>
                  <MenuItem value="SPOUSE">Spouse</MenuItem>
                  <MenuItem value="CHILD">Child</MenuItem>
                  <MenuItem value="PARENT">Parent</MenuItem>
                  <MenuItem value="SIBLING">Sibling</MenuItem>
                  <MenuItem value="OTHER_RELATIVE">Other Relative</MenuItem>
                </Select>
              )}
            />
            {errors.mainVictimRelationship && <Typography color="error">{errors.mainVictimRelationship.message}</Typography>}
          </FormControl>
        </Box>

        {/* Case Outcomes */}
        <Typography variant="h6" sx={{ mt: 3, mb: 1, fontWeight: 'medium' }}>Case Outcomes</Typography>
        <Box sx={{ display: 'grid', gridTemplateColumns: { xs: '1fr', md: '1fr 1fr' }, gap: 2 }}>
          <TextField
            label="Penalty"
            {...register('penalty')}
            fullWidth
            margin="normal"
            error={!!errors.penalty}
            helperText={errors.penalty?.message}
            variant="outlined"
          />
          <TextField
            label="Procedure Costs"
            {...register('procedureCosts')}
            fullWidth
            margin="normal"
            error={!!errors.procedureCosts}
            helperText={errors.procedureCosts?.message}
            variant="outlined"
          />
        </Box>

        {/* Additional Factors */}
        <Typography variant="h6" sx={{ mt: 3, mb: 1, fontWeight: 'medium' }}>Additional Factors</Typography>
        <Box sx={{ display: 'grid', gridTemplateColumns: { xs: '1fr', md: '1fr 1fr' }, gap: 2 }}>
          <FormControl fullWidth margin="normal">
            <InputLabel>Alcohol or Drugs</InputLabel>
            <Controller
              name="alcoholOrDrugs"
              control={control}
              render={({ field }) => (
                <Select
                  {...field}
                  label="Alcohol or Drugs"
                  onChange={(e) => field.onChange(e.target.value === 'true')}
                  value={field.value ? 'true' : 'false'}
                >
                  <MenuItem value="true">Yes</MenuItem>
                  <MenuItem value="false">No</MenuItem>
                </Select>
              )}
            />
          </FormControl>
          <FormControl fullWidth margin="normal">
            <InputLabel>Children Present</InputLabel>
            <Controller
              name="childrenPresent"
              control={control}
              render={({ field }) => (
                <Select
                  {...field}
                  label="Children Present"
                  onChange={(e) => field.onChange(e.target.value === 'true')}
                  value={field.value ? 'true' : 'false'}
                >
                  <MenuItem value="true">Yes</MenuItem>
                  <MenuItem value="false">No</MenuItem>
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
          Reason and Add Case
        </Button>
      </form>

      <Dialog open={openModal} onClose={handleCloseModal} maxWidth="md" fullWidth sx={{ '& .MuiDialog-paper': { borderRadius: 2 } }}>
        <DialogTitle sx={{ bgcolor: 'primary.main', color: 'white', fontWeight: 'bold' }}>
          Reasoning Results
        </DialogTitle>
        <DialogContent sx={{ p: 3 }}>
          {reasonResult ? (
            <>
              <Typography variant="h6" sx={{ mb: 2, fontWeight: 'medium' }}>
                You entered: <strong>{reasonResult.caseDescription.verdictType || 'None'}</strong>
              </Typography>
              <Typography variant="h6" sx={{ mb: 3, fontWeight: 'medium' }}>
                Predicted verdict: <strong>{reasonResult.predictedVerdict}</strong>
              </Typography>
              <FormControl fullWidth sx={{ mb: 3 }}>
                <InputLabel>Final Verdict to Save</InputLabel>
                <Select
                  value={selectedVerdict || ''}
                  onChange={(e) => setSelectedVerdict(e.target.value)}
                >
                  <MenuItem value={reasonResult.caseDescription.verdictType || ''}>
                    Use My Choice ({reasonResult.caseDescription.verdictType || 'None'})
                  </MenuItem>
                  <MenuItem value={reasonResult.predictedVerdict}>
                    Use Predicted Verdict ({reasonResult.predictedVerdict})
                  </MenuItem>
                </Select>
              </FormControl>
              <Typography variant="h6" sx={{ mb: 2, fontWeight: 'medium' }}>Similar Cases</Typography>
              <TableContainer component={Paper} sx={{ boxShadow: 2 }}>
                <Table>
                  <TableHead>
                    <TableRow sx={{ bgcolor: 'grey.100' }}>
                      <TableCell sx={{ fontWeight: 'bold' }}>Case ID</TableCell>
                      <TableCell sx={{ fontWeight: 'bold' }}>Similarity</TableCell>
                      <TableCell align="right" sx={{ fontWeight: 'bold' }}>Actions</TableCell>
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
                              navigate(`/view/${sc.caseDescription.dbId}`)
                              setOpenModal(false)
                            }}
                            sx={{ textTransform: 'none' }}
                          >
                            View
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
                >
                  Confirm Add
                </Button>
                <Button
                  onClick={handleCloseModal}
                  variant="outlined"
                  color="secondary"
                  sx={{ flex: 1, py: 1.5, fontSize: '1.1rem', textTransform: 'none' }}
                >
                  Cancel
                </Button>
              </Box>
            </>
          ) : (
            <Box sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', py: 4, flexDirection: 'column' }}>
              <CircularProgress size={50} />
              <Typography sx={{ mt: 2, fontSize: '1.1rem' }}>Loading...</Typography>
            </Box>
          )}
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
  )
}

export default AddCase