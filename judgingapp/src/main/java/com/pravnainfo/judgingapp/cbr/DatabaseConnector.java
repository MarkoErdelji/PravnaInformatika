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

    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    @Override
    public void initFromXMLfile(URL file) throws InitializingException {}

    @Override
    public Collection<CBRCase> retrieveAllCases() {
        List<Verdict> verdicts = verdictRepository.findAll();
        verdicts.forEach(verdict -> System.out.print(verdict.getCaseId() + " "));
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
            Verdict v = Verdict.builder()
                    .caseId(cd.getCaseId() != null ? cd.getCaseId() : "")
                    .court(cd.getCourt() != null ? cd.getCourt() : "")
                    .verdictNumber(cd.getCaseId() != null ? cd.getCaseId() : "")
                    .date(parseDate(cd.getDate()))
                    .judgeName(cd.getJudge() != null ? cd.getJudge() : "")
                    .clerkName(cd.getClerk() != null ? cd.getClerk() : "")
                    .prosecutor(cd.getProsecutor() != null ? cd.getProsecutor() : "")
                    .defendantName(cd.getDefendantName() != null ? cd.getDefendantName() : "")
                    .criminalOffense(cd.getCriminalOffense() != null ? cd.getCriminalOffense() : "")
                    .appliedProvisions(cd.getAppliedProvisions() != null ? cd.getAppliedProvisions() : "")
                    .verdictType(cd.getVerdict() != null ? parseVerdictType(cd.getVerdict()) : VerdictType.DISMISSAL)
                    .awareOfIllegality(cd.getAwareOfIllegality() != null ? cd.getAwareOfIllegality() : true)
                    .mainVictimRelationship(cd.getMainVictimRelationship() != null ? parseVictimRelationship(cd.getMainVictimRelationship()) : VictimRelationship.OTHER_RELATIVE)
                    .violenceNature(cd.getViolenceNature() != null ? parseViolenceNature(cd.getViolenceNature()) : ViolenceNature.NONE)
                    .injuryTypes(cd.getInjuryTypes() != null ? parseInjuryTypes(cd.getInjuryTypes()) : InjuryTypes.NONE)
                    .protectionMeasureViolation(cd.getProtectionMeasureViolation() != null ? cd.getProtectionMeasureViolation() : false)
                    .eventLocation(cd.getEventLocation() != null ? cd.getEventLocation() : "")
                    .eventDate(parseDate(cd.getEventDate()))
                    .defendantStatus(cd.getDefendantStatus() != null ? cd.getDefendantStatus() : "")
                    .victims(cd.getVictims() != null ? cd.getVictims() : "")
                    .mainVictimAge(cd.getMainVictimAge() != null ? cd.getMainVictimAge() : 0)
                    .alcoholOrDrugs(cd.getAlcoholOrDrugs() != null ? cd.getAlcoholOrDrugs() : false)
                    .childrenPresent(cd.getChildrenPresent() != null ? cd.getChildrenPresent() : false)
                    .penalty(cd.getPenalty() != null ? cd.getPenalty() : "")
                    .procedureCosts(cd.getProcedureCosts() != null ? cd.getProcedureCosts() : "")
                    .useOfWeapon(cd.getUseOfWeapon() != null ? cd.getUseOfWeapon() : false)
                    .numberOfVictims(cd.getNumberOfVictims() != null ? cd.getNumberOfVictims() : 0)
                    .xmlFileName(cd.getXmlFileName() != null ? cd.getXmlFileName() : "")
                    .build();
            Verdict saved = verdictRepository.save(v);
            cd.setDbId(saved.getId()); // update CBR case with DB ID
        }
    }

    @Override
    public void deleteCases(Collection<CBRCase> cases) {}

    @Override
    public void close() {}

    private LocalDate parseDate(String date) {
        try {
            return date != null && !date.isEmpty() ? LocalDate.parse(date, DATE_FORMATTER) : null;
        } catch (Exception e) {
            return null;
        }
    }

    private VerdictType parseVerdictType(String verdict) {
        if (verdict == null || verdict.isEmpty() || verdict.equalsIgnoreCase("NONE")) {
            return VerdictType.DISMISSAL;
        }
        try {
            return VerdictType.valueOf(verdict.toUpperCase());
        } catch (IllegalArgumentException e) {
            return VerdictType.DISMISSAL;
        }
    }

    private VictimRelationship parseVictimRelationship(String relationship) {
        if (relationship == null || relationship.isEmpty()) {
            return VictimRelationship.OTHER_RELATIVE;
        }
        try {
            return VictimRelationship.valueOf(relationship.toUpperCase());
        } catch (IllegalArgumentException e) {
            return VictimRelationship.OTHER_RELATIVE;
        }
    }

    private ViolenceNature parseViolenceNature(String violence) {
        if (violence == null || violence.isEmpty()) {
            return ViolenceNature.NONE;
        }
        try {
            return ViolenceNature.valueOf(violence.toUpperCase());
        } catch (IllegalArgumentException e) {
            return ViolenceNature.NONE;
        }
    }

    private InjuryTypes parseInjuryTypes(String injuries) {
        if (injuries == null || injuries.isEmpty()) {
            return InjuryTypes.NONE;
        }
        try {
            return InjuryTypes.valueOf(injuries.toUpperCase());
        } catch (IllegalArgumentException e) {
            return InjuryTypes.NONE;
        }
    }
}