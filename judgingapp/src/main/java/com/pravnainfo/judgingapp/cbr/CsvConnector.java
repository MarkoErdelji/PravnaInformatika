package com.pravnainfo.judgingapp.cbr;

import com.pravnainfo.judgingapp.entity.VerdictType;
import com.pravnainfo.judgingapp.repository.IVerdictRepository;
import es.ucm.fdi.gaia.jcolibri.cbrcore.CBRCase;
import es.ucm.fdi.gaia.jcolibri.cbrcore.CaseBaseFilter;
import es.ucm.fdi.gaia.jcolibri.cbrcore.Connector;
import es.ucm.fdi.gaia.jcolibri.exception.InitializingException;
import com.pravnainfo.judgingapp.dto.CaseDescription;
import com.pravnainfo.judgingapp.entity.Verdict;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.net.URL;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

@Component
public class CsvConnector implements Connector {
    @Autowired
    private IVerdictRepository verdictRepository;

    @Override
    public void initFromXMLfile(URL file) throws InitializingException {}

    @Override
    public Collection<CBRCase> retrieveAllCases() {
        List<Verdict> verdicts = verdictRepository.findAll();
        LinkedList<CBRCase> cases = new LinkedList<>();
        for (Verdict v : verdicts) {
            CBRCase cbrCase = new CBRCase();
            cbrCase.setDescription(new CaseDescription(v));
            cases.add(cbrCase);
        }
        return cases;
    }

    @Override
    public Collection<CBRCase> retrieveSomeCases(CaseBaseFilter filter) {
        return new LinkedList<>();
    }

    @Override
    public void storeCases(Collection<CBRCase> cases) {
        for (CBRCase cbrCase : cases) {
            CaseDescription cd = (CaseDescription) cbrCase.getDescription();
            Verdict v = new Verdict();
            v.setId(cd.getId());
            v.setCourt(cd.getCourt());
            v.setVerdictNumber(cd.getVerdictNumber());
            v.setDate(cd.getDate());
            v.setJudgeName(cd.getJudgeName());
            v.setProsecutor(cd.getProsecutor());
            v.setDefendantName(cd.getDefendantName());
            v.setCriminalOffense(cd.getCriminalOffense());
            v.setAppliedProvisions(cd.getAppliedProvisions());
            v.setVerdict(VerdictType.valueOf(cd.getVerdict()));
            v.setNumDefendants(cd.getNumDefendants());
            v.setPreviouslyConvicted(cd.getPreviouslyConvicted());
            v.setAwareOfIllegality(cd.getAwareOfIllegality());
            v.setVictimRelationship(cd.getVictimRelationship());
            v.setViolenceNature(cd.getViolenceNature());
            v.setInjuryTypes(cd.getInjuryTypes());
            v.setExecutionMeans(cd.getExecutionMeans());
            v.setProtectionMeasureViolation(cd.getProtectionMeasureViolation());
            v.setEventLocation(cd.getEventLocation());
            v.setEventDate(cd.getEventDate());
            v.setDefendantStatus(cd.getDefendantStatus());
            v.setVictims(cd.getVictims());
            v.setDefendantAge(cd.getDefendantAge());
            v.setVictimAge(cd.getVictimAge());
            v.setPreviousIncidents(cd.getPreviousIncidents());
            v.setAlcoholOrDrugs(cd.getAlcoholOrDrugs());
            v.setChildrenPresent(cd.getChildrenPresent());
            v.setPenalty(cd.getPenalty());
            v.setProcedureCosts(cd.getProcedureCosts());
            v.setUseOfWeapon(cd.getUseOfWeapon());
            v.setNumberOfVictims(cd.getNumberOfVictims());
            verdictRepository.save(v);
        }
    }

    @Override
    public void deleteCases(Collection<CBRCase> cases) {}

    @Override
    public void close() {}
}