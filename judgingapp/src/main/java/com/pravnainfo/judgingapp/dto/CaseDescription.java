package com.pravnainfo.judgingapp.dto;

import com.pravnainfo.judgingapp.entity.*;
import es.ucm.fdi.gaia.jcolibri.cbrcore.Attribute;
import es.ucm.fdi.gaia.jcolibri.cbrcore.CaseComponent;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CaseDescription implements CaseComponent {

    private Long dbId;
    private String caseId;
    private String court;
    private String date;
    private String judge;
    private String clerk;
    private String prosecutor;
    private String defendantName;
    private String criminalOffense;
    private String appliedProvisions;
    private String verdict;
    private Boolean awareOfIllegality;
    private String mainVictimRelationship;
    private String violenceNature;
    private String injuryTypes;
    private String executionMeans;
    private Boolean protectionMeasureViolation;
    private String eventLocation;
    private String eventDate;
    private String defendantStatus;
    private String victims;
    private Integer mainVictimAge;
    private Boolean alcoholOrDrugs;
    private Boolean childrenPresent;
    private String penalty;
    private String procedureCosts;
    private Boolean useOfWeapon;
    private Integer numberOfVictims;
    private String xmlFileName;

    @Override
    public Attribute getIdAttribute() {
        return new Attribute("dbId", this.getClass());
    }

    public CaseDescription(Verdict v) {
        this.dbId = v.getId();
        this.caseId = v.getCaseId();
        this.court = v.getCourt();
        this.date = v.getDate() != null ? v.getDate().toString() : "";
        this.judge = v.getJudgeName();
        this.clerk = v.getClerkName();
        this.prosecutor = v.getProsecutor();
        this.defendantName = v.getDefendantName();
        this.criminalOffense = v.getCriminalOffense();
        this.appliedProvisions = v.getAppliedProvisions();
        this.verdict = v.getVerdictType() != null ? v.getVerdictType().name() : null;
        this.awareOfIllegality = v.getAwareOfIllegality();
        this.mainVictimRelationship = v.getMainVictimRelationship() != null ? v.getMainVictimRelationship().name() : null;
        this.violenceNature = v.getViolenceNature() != null ? v.getViolenceNature().name() : null;
        this.injuryTypes = v.getInjuryTypes() != null ? v.getInjuryTypes().name() : null;
        this.protectionMeasureViolation = v.getProtectionMeasureViolation();
        this.eventLocation = v.getEventLocation();
        this.eventDate = v.getEventDate() != null ? v.getEventDate().toString() : "";
        this.defendantStatus = v.getDefendantStatus();
        this.victims = v.getVictims();
        this.mainVictimAge = v.getMainVictimAge();
        this.alcoholOrDrugs = v.getAlcoholOrDrugs();
        this.childrenPresent = v.getChildrenPresent();
        this.penalty = v.getPenalty();
        this.procedureCosts = v.getProcedureCosts();
        this.useOfWeapon = v.getUseOfWeapon();
        this.numberOfVictims = v.getNumberOfVictims();
        this.xmlFileName = v.getXmlFileName();
    }
}