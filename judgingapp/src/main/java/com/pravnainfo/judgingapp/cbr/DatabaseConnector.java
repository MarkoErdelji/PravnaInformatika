package com.pravnainfo.judgingapp.cbr;

import com.pravnainfo.judgingapp.dto.CaseDescription;
import com.pravnainfo.judgingapp.entity.*;
import com.pravnainfo.judgingapp.repository.IVerdictRepository;
import es.ucm.fdi.gaia.jcolibri.cbrcore.CBRCase;
import es.ucm.fdi.gaia.jcolibri.cbrcore.CaseBaseFilter;
import es.ucm.fdi.gaia.jcolibri.cbrcore.Connector;
import es.ucm.fdi.gaia.jcolibri.exception.InitializingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.net.URL;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

@Component
public class DatabaseConnector implements Connector {

    @Autowired
    private IVerdictRepository verdictRepository;

    @Override
    public void initFromXMLfile(URL file) throws InitializingException {}

    @Override
    public Collection<CBRCase> retrieveAllCases() {
        List<Verdict> verdicts = verdictRepository.findAll();
        verdicts.forEach(verdict -> {        System.out.print(verdict.getCaseId());});
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
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MMM-dd");
            LocalDate date = LocalDate.parse(cd.getDate(), formatter);
            Verdict v = Verdict.builder()
                    .court(cd.getCourt())
                    .judgeName(cd.getJudge())
                    .date(date)
                    .criminalOffense(cd.getCriminalOffense())
                    .numDefendants(cd.getNumDefendants())
                    .previouslyConvicted(cd.getPreviouslyConvicted())
                    .awareOfIllegality(cd.getAwareOfIllegality())
                    .victimRelationship(VictimRelationship.valueOf(cd.getVictimRelationship()))
                    .violenceNature(ViolenceNature.valueOf(cd.getViolenceNature()))
                    .injuryTypes(InjuryTypes.valueOf(cd.getInjuryTypes()))
                    .executionMeans(ExecutionMeans.valueOf(cd.getExecutionMeans()))
                    .protectionMeasureViolation(cd.getProtectionMeasureViolation())
                    .defendantAge(cd.getDefendantAge())
                    .victimAge(cd.getVictimAge())
                    .alcoholOrDrugs(cd.getAlcoholOrDrugs())
                    .childrenPresent(cd.getChildrenPresent())
                    .useOfWeapon(cd.getUseOfWeapon())
                    .numberOfVictims(cd.getNumberOfVictims())
                    .verdict(cd.getVerdict() != null ? Enum.valueOf(VerdictType.class, cd.getVerdict()) : null)
                    .build();
            Verdict saved = verdictRepository.save(v);
            cd.setDbId(saved.getId()); // update CBR case with DB ID
        }
    }

    @Override
    public void deleteCases(Collection<CBRCase> cases) {}

    @Override
    public void close() {}
}
