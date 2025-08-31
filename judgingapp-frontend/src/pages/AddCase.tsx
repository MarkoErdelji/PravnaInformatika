import { useForm, Controller } from 'react-hook-form'
import { Box, Button, TextField, Typography, Select, MenuItem, FormControl, InputLabel, Dialog, DialogTitle, DialogContent, Table, TableContainer, TableHead, TableRow, TableCell, TableBody, Paper, Autocomplete, Chip } from '@mui/material'
import axios from 'axios'
import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import type { Verdict, ReasonResponse } from './types'

function AddCase() {
  const navigate = useNavigate()
  const { register, handleSubmit, control, formState: { errors }, reset, setValue } = useForm<Verdict>({
    defaultValues: {
      id: undefined,
      caseId: '',
      court: '',
      verdictNumber: '',
      date: null,
      judgeName: '',
      prosecutor: '',
      defendantName: '',
      criminalOffense: '',
      appliedProvisions: '',
      verdict: null,
      numDefendants: 1,
      previouslyConvicted: false,
      awareOfIllegality: true,
      victimRelationship: null,
      violenceNature: null,
      injuryTypes: null,
      executionMeans: null,
      protectionMeasureViolation: false,
      eventLocation: '',
      eventDate: null,
      defendantStatus: '',
      victims: '',
      defendantAge: null,
      victimAge: null,
      previousIncidents: false,
      alcoholOrDrugs: false,
      childrenPresent: false,
      penalty: '',
      procedureCosts: '',
      useOfWeapon: false,
      numberOfVictims: 0,
    },
  })
  const [reasonResult, setReasonResult] = useState<ReasonResponse | null>(null)
  const [openModal, setOpenModal] = useState(false)
  const [statusOptions, setStatusOptions] = useState<string[]>([])
  const [criminalOffenseOptions, setCriminalOffenseOptions] = useState<string[]>([])

  const statusChoices = ['unemployed', 'unmarried', 'previously convicted']
  const statuteChoices = ['st. 1', 'st. 2', 'st. 3', 'st. 4', 'st. 5']

  const onSubmit = (data: Verdict) => {
    axios.post<ReasonResponse>('/api/cases/reason', data)
      .then(res => {
        setReasonResult({ ...res.data, caseDescription: data })
        setOpenModal(true)
      })
      .catch(err => {
        console.error(err)
        alert('Error during reasoning')
      })
  }

  const handleConfirmAdd = () => {
    if (reasonResult) {
      const caseData: Verdict = {
        ...reasonResult.caseDescription,
        verdict: reasonResult.predictedVerdict, // Use predicted verdict
      }
      axios.post('/api/cases/add', caseData)
        .then(res => {
          console.log('Case added:', res.data)
          alert('Case added successfully!')
          setOpenModal(false)
          reset()
          setStatusOptions([])
          setCriminalOffenseOptions([])
        })
        .catch(err => {
          console.error(err)
          alert('Error adding case')
        })
    }
  }

  const handleCloseModal = () => {
    setOpenModal(false)
    setReasonResult(null)
    setStatusOptions([])
    setCriminalOffenseOptions([])
  }

  return (
    <Box sx={{ my: 4 }}>
      <Typography variant="h4">Add New Case</Typography>
      <form onSubmit={handleSubmit(onSubmit)}>
        {/* Case Identification */}
        <TextField
          label="Case ID"
          {...register('caseId', { required: 'Case ID is required' })}
          fullWidth
          margin="normal"
          error={!!errors.caseId}
          helperText={errors.caseId?.message}
        />
        <TextField
          label="Court"
          {...register('court')}
          fullWidth
          margin="normal"
          error={!!errors.court}
          helperText={errors.court?.message}
        />
        <TextField
          label="Verdict Number"
          {...register('verdictNumber')}
          fullWidth
          margin="normal"
          error={!!errors.verdictNumber}
          helperText={errors.verdictNumber?.message}
        />
        <TextField
          label="Verdict Date"
          type="date"
          {...register('date')}
          fullWidth
          margin="normal"
          InputLabelProps={{ shrink: true }}
          error={!!errors.date}
          helperText={errors.date?.message}
        />

        {/* Parties Involved */}
        <TextField
          label="Judge Name"
          {...register('judgeName')}
          fullWidth
          margin="normal"
          error={!!errors.judgeName}
          helperText={errors.judgeName?.message}
        />
        <TextField
          label="Prosecutor"
          {...register('prosecutor')}
          fullWidth
          margin="normal"
          error={!!errors.prosecutor}
          helperText={errors.prosecutor?.message}
        />
        <TextField
          label="Defendant Name"
          {...register('defendantName')}
          fullWidth
          margin="normal"
          error={!!errors.defendantName}
          helperText={errors.defendantName?.message}
        />
        <TextField
          label="Victims"
          {...register('victims')}
          fullWidth
          margin="normal"
          error={!!errors.victims}
          helperText={errors.victims?.message}
        />

        {/* Case Details */}
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
            />
          )}
        />
        <TextField
          label="Applied Provisions"
          {...register('appliedProvisions')}
          fullWidth
          margin="normal"
          error={!!errors.appliedProvisions}
          helperText={errors.appliedProvisions?.message}
        />
        <FormControl fullWidth margin="normal" error={!!errors.verdict}>
          <InputLabel>Verdict Type</InputLabel>
          <Controller
            name="verdict"
            control={control}
            rules={{ required: 'Verdict Type is required' }}
            render={({ field }) => (
              <Select {...field} label="Verdict Type" value={field.value || ''}>
                <MenuItem value="PRISON">Prison</MenuItem>
                <MenuItem value="SUSPENDED">Suspended</MenuItem>
                <MenuItem value="ACQUITTED">Acquitted</MenuItem>
                <MenuItem value="DETENTION">Detention</MenuItem>
              </Select>
            )}
          />
          {errors.verdict && <Typography color="error">{errors.verdict.message}</Typography>}
        </FormControl>

        {/* Incident Details */}
        <TextField
          label="Event Location"
          {...register('eventLocation')}
          fullWidth
          margin="normal"
          error={!!errors.eventLocation}
          helperText={errors.eventLocation?.message}
        />
        <TextField
          label="Event Date"
          type="date"
          {...register('eventDate')}
          fullWidth
          margin="normal"
          InputLabelProps={{ shrink: true }}
          error={!!errors.eventDate}
          helperText={errors.eventDate?.message}
        />
        <FormControl fullWidth margin="normal" error={!!errors.violenceNature}>
          <InputLabel>Violence Nature</InputLabel>
          <Controller
            name="violenceNature"
            control={control}
            rules={{ required: 'Violence Nature is required' }}
            render={({ field }) => (
              <Select {...field} label="Violence Nature" value={field.value || ''}>
                <MenuItem value="VIOLENCE">Violence</MenuItem>
                <MenuItem value="THREAT">Threat</MenuItem>
                <MenuItem value="RECKLESS_BEHAVIOUR">Reckless Behaviour</MenuItem>
                <MenuItem value="NONE">None</MenuItem>
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
                <MenuItem value="LIGHT">Light</MenuItem>
                <MenuItem value="SEVERE">Severe</MenuItem>
                <MenuItem value="LIGHT_SEVERE">Light and Severe</MenuItem>
                <MenuItem value="NONE">None</MenuItem>
              </Select>
            )}
          />
          {errors.injuryTypes && <Typography color="error">{errors.injuryTypes.message}</Typography>}
        </FormControl>
        <FormControl fullWidth margin="normal" error={!!errors.executionMeans}>
          <InputLabel>Execution Means</InputLabel>
          <Controller
            name="executionMeans"
            control={control}
            rules={{ required: 'Execution Means is required' }}
            render={({ field }) => (
              <Select {...field} label="Execution Means" value={field.value || ''}>
                <MenuItem value="HANDS">Hands</MenuItem>
                <MenuItem value="FEET">Feet</MenuItem>
                <MenuItem value="WEAPON">Weapon</MenuItem>
                <MenuItem value="TOOL">Tool</MenuItem>
                <MenuItem value="VERBAL">Verbal</MenuItem>
                <MenuItem value="OTHER">Other</MenuItem>
              </Select>
            )}
          />
          {errors.executionMeans && <Typography color="error">{errors.executionMeans.message}</Typography>}
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

        {/* Defendant Information */}
        <TextField
          label="Number of Defendants"
          type="number"
          {...register('numDefendants', { 
            valueAsNumber: true,
            required: 'Number of Defendants is required',
            min: { value: 1, message: 'At least one defendant required' }
          })}
          fullWidth
          margin="normal"
          error={!!errors.numDefendants}
          helperText={errors.numDefendants?.message}
        />
        <TextField
          label="Defendant Age"
          type="number"
          {...register('defendantAge', { valueAsNumber: true })}
          fullWidth
          margin="normal"
          error={!!errors.defendantAge}
          helperText={errors.defendantAge?.message}
        />
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
            />
          )}
        />
        <FormControl fullWidth margin="normal">
          <InputLabel>Previously Convicted</InputLabel>
          <Controller
            name="previouslyConvicted"
            control={control}
            render={({ field }) => (
              <Select
                {...field}
                label="Previously Convicted"
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
          <InputLabel>Previous Incidents</InputLabel>
          <Controller
            name="previousIncidents"
            control={control}
            render={({ field }) => (
              <Select
                {...field}
                label="Previous Incidents"
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

        {/* Victim Information */}
        <TextField
          label="Number of Victims"
          type="number"
          {...register('numberOfVictims', { 
            valueAsNumber: true,
            required: 'Number of Victims is required',
            min: { value: 0, message: 'Number of victims cannot be negative' }
          })}
          fullWidth
          margin="normal"
          error={!!errors.numberOfVictims}
          helperText={errors.numberOfVictims?.message}
        />
        <TextField
          label="Victim Age"
          type="number"
          {...register('victimAge', { valueAsNumber: true })}
          fullWidth
          margin="normal"
          error={!!errors.victimAge}
          helperText={errors.victimAge?.message}
        />
        <FormControl fullWidth margin="normal" error={!!errors.victimRelationship}>
          <InputLabel>Victim Relationship</InputLabel>
          <Controller
            name="victimRelationship"
            control={control}
            rules={{ required: 'Victim Relationship is required' }}
            render={({ field }) => (
              <Select {...field} label="Victim Relationship" value={field.value || ''}>
                <MenuItem value="SPOUSE">Spouse</MenuItem>
                <MenuItem value="PARENT">Parent</MenuItem>
                <MenuItem value="SIBLING">Sibling</MenuItem>
                <MenuItem value="CHILD">Child</MenuItem>
                <MenuItem value="OTHER">Other</MenuItem>
              </Select>
            )}
          />
          {errors.victimRelationship && <Typography color="error">{errors.victimRelationship.message}</Typography>}
        </FormControl>

        {/* Case Outcomes */}
        <TextField
          label="Penalty"
          {...register('penalty')}
          fullWidth
          margin="normal"
          error={!!errors.penalty}
          helperText={errors.penalty?.message}
        />
        <TextField
          label="Procedure Costs"
          {...register('procedureCosts')}
          fullWidth
          margin="normal"
          error={!!errors.procedureCosts}
          helperText={errors.procedureCosts?.message}
        />

        {/* Additional Factors */}
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

        <Button type="submit" variant="contained" color="primary" fullWidth sx={{ mt: 2 }}>
          Reason and Add Case
        </Button>
      </form>

      <Dialog open={openModal} onClose={handleCloseModal} maxWidth="md" fullWidth>
        <DialogTitle>Reasoning Results</DialogTitle>
        <DialogContent>
          {reasonResult ? (
            <>
              <Typography variant="h5">
                You chose {reasonResult.caseDescription.verdict || 'no verdict'}. The predicted verdict is {reasonResult.predictedVerdict}.
              </Typography>
              <Typography variant="h6" sx={{ mt: 2 }}>Similar Cases:</Typography>
              <TableContainer component={Paper}>
                <Table>
                  <TableHead>
                    <TableRow>
                      <TableCell>Case ID</TableCell>
                      <TableCell>Similarity</TableCell>
                      <TableCell align="right">Actions</TableCell>
                    </TableRow>
                  </TableHead>
                  <TableBody>
                    {reasonResult.similarCases.map((sc, index) => (
                      <TableRow key={index}>
                        <TableCell>{sc.caseDescription.caseId}</TableCell>
                        <TableCell>{(sc.similarity * 100).toFixed(2)}%</TableCell>
                        <TableCell align="right">
                          <Button
                            variant="outlined"
                            color="secondary"
                            onClick={() => {
                              navigate(`/view/${sc.caseDescription.caseId}`)
                              setOpenModal(false)
                            }}
                          >
                            View
                          </Button>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </TableContainer>
              <Box sx={{ mt: 2, display: 'flex', gap: 2 }}>
                <Button onClick={handleConfirmAdd} variant="contained" color="primary">
                  Confirm Add
                </Button>
                <Button onClick={handleCloseModal} variant="outlined" color="secondary">
                  Cancel
                </Button>
              </Box>
            </>
          ) : (
            <Typography>Loading...</Typography>
          )}
        </DialogContent>
      </Dialog>
    </Box>
  )
}

export default AddCase