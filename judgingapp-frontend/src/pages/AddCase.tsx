import { useForm, Controller } from 'react-hook-form'
import { Box, Button, TextField, Typography, Select, MenuItem, FormControl, InputLabel, Dialog, DialogTitle, DialogContent, Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Paper } from '@mui/material'
import axios from 'axios'
import { useState } from 'react'
import type { Verdict, ReasonResponse } from './types'
import { useNavigate } from 'react-router-dom'

function AddCase() {
  const navigate = useNavigate()
  const { register, handleSubmit, control, formState: { errors }, reset } = useForm<Verdict>({
    defaultValues: {
        id:'',
      caseId: '',
      court: '',
      verdictNumber: '',
      date: null,
      judgeName: '',
      prosecutor: '',
      defendantName: '',
      criminalOffense: '',
      appliedProvisions: '',
      verdict: '',
      numDefendants: null,
      previouslyConvicted: false,
      awareOfIllegality: false,
      victimRelationship: '',
      violenceNature: '',
      injuryTypes: '',
      executionMeans: '',
      protectionMeasureViolation: false,
      eventLocation: '',
      eventDate: null,
      defendantStatus: '',
      victims: '',
      defendantAge: null,
      victimAge: null,
      previousIncidents: '',
      alcoholOrDrugs: false,
      childrenPresent: false,
      penalty: '',
      procedureCosts: '',
      useOfWeapon: false,
      numberOfVictims: null,
    },
  })
  const [reasonResult, setReasonResult] = useState<ReasonResponse | null>(null)
  const [openModal, setOpenModal] = useState(false)

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
  }

  return (
    <Box sx={{ my: 4 }}>
      <Typography variant="h4">Add New Case</Typography>
      <form onSubmit={handleSubmit(onSubmit)}>
        <TextField
          label="Case Name"
          {...register('caseId', { required: 'Case Name is required' })}
          fullWidth
          margin="normal"
          error={!!errors.id}
          helperText={errors.id?.message}
        />
        <TextField label="Court" {...register('court')} fullWidth margin="normal" />
        <TextField label="Verdict Number" {...register('verdictNumber')} fullWidth margin="normal" />
        <TextField
          label="Date"
          type="date"
          {...register('date')}
          fullWidth
          margin="normal"
          InputLabelProps={{ shrink: true }}
        />
        <TextField label="Judge Name" {...register('judgeName')} fullWidth margin="normal" />
        <TextField label="Prosecutor" {...register('prosecutor')} fullWidth margin="normal" />
        <TextField label="Defendant Name" {...register('defendantName')} fullWidth margin="normal" />
        <TextField label="Criminal Offense" {...register('criminalOffense')} fullWidth margin="normal" />
        <TextField label="Applied Provisions" {...register('appliedProvisions')} fullWidth margin="normal" />
        <TextField label="Verdict" {...register('verdict')} fullWidth margin="normal" />
        <TextField label="Num Defendants" type="number" {...register('numDefendants')} fullWidth margin="normal" />
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
        <TextField label="Victim Relationship" {...register('victimRelationship')} fullWidth margin="normal" />
        <TextField label="Violence Nature" {...register('violenceNature')} fullWidth margin="normal" />
        <TextField label="Injury Types" {...register('injuryTypes')} fullWidth margin="normal" />
        <TextField label="Execution Means" {...register('executionMeans')} fullWidth margin="normal" />
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
        <TextField label="Event Location" {...register('eventLocation')} fullWidth margin="normal" />
        <TextField
          label="Event Date"
          type="date"
          {...register('eventDate')}
          fullWidth
          margin="normal"
          InputLabelProps={{ shrink: true }}
        />
        <TextField label="Defendant Status" {...register('defendantStatus')} fullWidth margin="normal" />
        <TextField label="Victims" {...register('victims')} fullWidth margin="normal" />
        <TextField label="Defendant Age" type="number" {...register('defendantAge')} fullWidth margin="normal" />
        <TextField label="Victim Age" type="number" {...register('victimAge')} fullWidth margin="normal" />
        <TextField label="Previous Incidents" {...register('previousIncidents')} fullWidth margin="normal" />
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
        <TextField label="Penalty" {...register('penalty')} fullWidth margin="normal" />
        <TextField label="Procedure Costs" {...register('procedureCosts')} fullWidth margin="normal" />
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
        <TextField label="Number of Victims" type="number" {...register('numberOfVictims')} fullWidth margin="normal" />
        <Button type="submit" variant="contained" color="primary">Reason and Add Case</Button>
      </form>

      <Dialog open={openModal} onClose={handleCloseModal} maxWidth="md" fullWidth>
        <DialogTitle>Reasoning Results</DialogTitle>
        <DialogContent>
          {reasonResult ? (
            <>
              <Typography variant="h5">Predicted Verdict: {reasonResult.predictedVerdict}</Typography>
              <Typography variant="h6" sx={{ mt: 2 }}>Similar Cases:</Typography>
              <TableContainer component={Paper}>
                <Table>
                  <TableHead>
                    <TableRow>
                      <TableCell>Name</TableCell>
                      <TableCell>Similarity</TableCell>
                    </TableRow>
                  </TableHead>
                  <TableBody>
                    {reasonResult.similarCases.map((sc, index) => (
                      <TableRow key={index}>
                        <TableCell>{sc.caseDescription.caseName}</TableCell>
                        <TableCell>{sc.similarity}</TableCell>
                         <TableCell align="right">
                            <Button
                            variant="outlined"
                            color="secondary"
                            onClick={() => {
                                navigate(`/view/${sc.caseDescription.dbId}`)
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