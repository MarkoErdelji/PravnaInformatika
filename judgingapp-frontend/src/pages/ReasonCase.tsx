import { useForm, Controller } from 'react-hook-form'
import {
  Box,
  Button,
  TextField,
  Typography,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  Select,
  MenuItem,
  FormControl,
  InputLabel,
  Dialog,
  DialogTitle,
  DialogContent,
  CircularProgress,
  Stack
} from '@mui/material'
import axios from 'axios'
import { useState } from 'react'
import type { CaseDescription, ReasonResponse } from './types'
import { useNavigate } from 'react-router-dom'

function ReasonCase() {
  const navigate = useNavigate();
  const { register, handleSubmit, control, formState: { errors } } = useForm<CaseDescription>({
    defaultValues: {
      dbId: '',
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

  const [result, setResult] = useState<ReasonResponse | null>(null)
  const [openModal, setOpenModal] = useState(false)
  const [status, setStatus] = useState<'idle' | 'loading' | 'success' | 'error'>('idle')

  const onSubmit = (data: CaseDescription) => {
    setStatus('loading')
    axios.post<ReasonResponse>('/api/cases/reason', data)
      .then(res => {
        setResult(res.data)
        setStatus('success')
        setOpenModal(true)
      })
      .catch(err => {
        console.error(err)
        setStatus('error')
        setOpenModal(true)
      })
  }

  const handleCloseModal = () => {
    setOpenModal(false)
    setStatus('idle')
    setResult(null)
  }

  return (
    <Box sx={{ my: 4 }}>
      <Typography variant="h4" gutterBottom>Reason Case</Typography>

      <form onSubmit={handleSubmit(onSubmit)}>
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

        <FormControl fullWidth margin="normal">
          <InputLabel>Verdict</InputLabel>
          <Controller
            name="verdict"
            control={control}
            render={({ field }) => (
              <Select {...field} label="Verdict">
                <MenuItem value="PRISON">PRISON</MenuItem>
                <MenuItem value="SUSPENDED">SUSPENDED</MenuItem>
                <MenuItem value="ACQUITTED">ACQUITTED</MenuItem>
                <MenuItem value="DETENTION">DETENTION</MenuItem>
              </Select>
            )}
          />
        </FormControl>

        <TextField label="Num Defendants" type="number" {...register('numDefendants')} fullWidth margin="normal" />

        {/* Boolean selects */}
        {[
          { name: 'previouslyConvicted', label: 'Previously Convicted' },
          { name: 'awareOfIllegality', label: 'Aware of Illegality' },
          { name: 'protectionMeasureViolation', label: 'Protection Measure Violation' },
          { name: 'alcoholOrDrugs', label: 'Alcohol or Drugs' },
          { name: 'childrenPresent', label: 'Children Present' },
          { name: 'useOfWeapon', label: 'Use of Weapon' },
        ].map(({ name, label }) => (
          <FormControl fullWidth margin="normal" key={name}>
            <InputLabel>{label}</InputLabel>
            <Controller
              name={name as keyof CaseDescription}
              control={control}
              render={({ field }) => (
                <Select
                  {...field}
                  label={label}
                  onChange={(e) => field.onChange(e.target.value === 'true')}
                  value={field.value ? 'true' : 'false'}
                >
                  <MenuItem value="true">Yes</MenuItem>
                  <MenuItem value="false">No</MenuItem>
                </Select>
              )}
            />
          </FormControl>
        ))}

        <TextField label="Victim Relationship" {...register('victimRelationship')} fullWidth margin="normal" />
        <TextField label="Violence Nature" {...register('violenceNature')} fullWidth margin="normal" />
        <TextField label="Injury Types" {...register('injuryTypes')} fullWidth margin="normal" />
        <TextField label="Execution Means" {...register('executionMeans')} fullWidth margin="normal" />

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
        <TextField label="Penalty" {...register('penalty')} fullWidth margin="normal" />
        <TextField label="Procedure Costs" {...register('procedureCosts')} fullWidth margin="normal" />
        <TextField label="Number of Victims" type="number" {...register('numberOfVictims')} fullWidth margin="normal" />

        <Button type="submit" variant="contained" color="primary" fullWidth sx={{ mt: 2 }}>
          Reason
        </Button>
      </form>

      {/* Result Modal */}
      <Dialog open={openModal} onClose={handleCloseModal} maxWidth="md" fullWidth>
        <DialogTitle>Reasoning Result</DialogTitle>
        <DialogContent>
          {status === 'loading' && (
            <Stack alignItems="center" sx={{ py: 3 }}>
              <CircularProgress />
              <Typography sx={{ mt: 2 }}>Reasoning in progress...</Typography>
            </Stack>
          )}

          {status === 'error' && (
            <Typography color="error" sx={{ py: 2 }}>
              ❌ Error during reasoning. Please try again.
            </Typography>
          )}

          {status === 'success' && result && (
            <>
              <Typography variant="h6" sx={{ mb: 2 }}>
                Predicted Verdict: <b>{result.predictedVerdict}</b>
              </Typography>
              <Typography variant="subtitle1">Similar Cases:</Typography>
              <TableContainer component={Paper} sx={{ mt: 2 }}>
                <Table>
                  <TableHead>
                    <TableRow>
                      <TableCell><b>ID</b></TableCell>
                      <TableCell><b>Similarity</b></TableCell>
                    </TableRow>
                  </TableHead>
                  <TableBody>
                    {result.similarCases.map((sc, index) => (
                      <TableRow key={index}>
                        <TableCell>{sc.caseDescription.caseName}</TableCell>
                        <TableCell>{(sc.similarity * 100).toFixed(2)}%</TableCell>
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
            </>
          )}

          <Button onClick={handleCloseModal} variant="contained" color="primary" fullWidth sx={{ mt: 3 }}>
            Close
          </Button>
        </DialogContent>
      </Dialog>
    </Box>
  )
}

export default ReasonCase
