import { useForm, Controller } from 'react-hook-form'
import {
  Box,
  Button,
  TextField,
  Typography,
  Select,
  MenuItem,
  FormControl,
  InputLabel,
  Dialog,
  DialogTitle,
  DialogContent,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  CircularProgress,
  Stack,
  Autocomplete,
  Chip
} from '@mui/material'
import axios from 'axios'
import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import type { CaseDescription, ReasonResponse } from './types'

function ReasonCase() {
  const navigate = useNavigate()
  const { register, handleSubmit, control, formState: { errors }, setValue } = useForm<CaseDescription>({
    defaultValues: {
      id: '',
      criminalOffense: '',
      verdict: null,
      numDefendants: 1,
      previouslyConvicted: false,
      awareOfIllegality: true,
      victimRelationship: null,
      violenceNature: null,
      injuryTypes: null,
      executionMeans: null,
      protectionMeasureViolation: false,
      defendantAge: null,
      victimAge: null,
      previousIncidents: false,
      alcoholOrDrugs: false,
      childrenPresent: false,
      useOfWeapon: false,
      numberOfVictims: 0,
    },
  })

  const [result, setResult] = useState<ReasonResponse | null>(null)
  const [openModal, setOpenModal] = useState(false)
  const [status, setStatus] = useState<'idle' | 'loading' | 'success' | 'error'>('idle')
  const [criminalOffenseOptions, setCriminalOffenseOptions] = useState<string[]>([])

  const statuteChoices = ['st. 1', 'st. 2', 'st. 3', 'st. 4', 'st. 5']

  const onSubmit = (data: CaseDescription) => {
    setStatus('loading')
    axios.post<ReasonResponse>('/api/cases/reason', data)
      .then(res => {
        setResult({ ...res.data, caseDescription: data })
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
    setCriminalOffenseOptions([])
  }

  return (
    <Box sx={{ my: 4 }}>
      <Typography variant="h4" gutterBottom>Reason Case</Typography>

      <form onSubmit={handleSubmit(onSubmit)}>
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
          label="Defendant Age"
          type="number"
          {...register('defendantAge', { valueAsNumber: true })}
          fullWidth
          margin="normal"
          error={!!errors.defendantAge}
          helperText={errors.defendantAge?.message}
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

        {[
          { name: 'previouslyConvicted', label: 'Previously Convicted' },
          { name: 'awareOfIllegality', label: 'Aware of Illegality' },
          { name: 'protectionMeasureViolation', label: 'Protection Measure Violation' },
          { name: 'previousIncidents', label: 'Previous Incidents' },
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

        <Button type="submit" variant="contained" color="primary" fullWidth sx={{ mt: 2 }}>
          Reason
        </Button>
      </form>

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
                You chose {result.caseDescription?.verdict || 'no verdict'}. The predicted verdict is <b>{result.predictedVerdict}</b>.
              </Typography>
              <Typography variant="subtitle1">Similar Cases:</Typography>
              <TableContainer component={Paper} sx={{ mt: 2 }}>
                <Table>
                  <TableHead>
                    <TableRow>
                      <TableCell><b>Case ID</b></TableCell>
                      <TableCell><b>Similarity</b></TableCell>
                      <TableCell align="right"><b>Actions</b></TableCell>
                    </TableRow>
                  </TableHead>
                  <TableBody>
                    {result.similarCases.map((sc, index) => (
                      <TableRow key={index}>
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