import { Routes, Route } from 'react-router-dom'
import ViewCase from './pages/ViewCase'
import AddCase from './pages/AddCase'
import Home from './pages/Home'
import RetrieveSimilar from './pages/RetrieveSimilar'
import ReasonCase from './pages/ReasonCase'
import NavBar from './components/NavBar'
import { Container } from '@mui/material'
import LawsViewer from './components/LawsViewer'

function App() {
  return (
    <>
      <NavBar />
      <Container maxWidth="lg">
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/view/:id" element={<ViewCase />} />
          <Route path="/add" element={<AddCase />} />
          <Route path="/retrieve" element={<RetrieveSimilar />} />
          <Route path="/reason" element={<ReasonCase />} />
                    <Route path="/laws/:lawType" element={<LawsViewer />} />

        </Routes>
      </Container>
    </>
  )
}

export default App