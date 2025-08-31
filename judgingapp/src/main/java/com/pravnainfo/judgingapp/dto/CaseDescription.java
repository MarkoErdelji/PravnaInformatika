package com.pravnainfo.judgingapp.dto;

import com.pravnainfo.judgingapp.entity.Verdict;
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
    private String criminalOffense;
    private Integer numDefendants;
    private Boolean previouslyConvicted;
    private Boolean awareOfIllegality;
    private String victimRelationship;
    private String violenceNature;
    private String injuryTypes;
    private String executionMeans;
    private Boolean protectionMeasureViolation;
    private Integer defendantAge;
    private Integer victimAge;
    private Boolean alcoholOrDrugs;
    private Boolean childrenPresent;
    private Boolean useOfWeapon;
    private Integer numberOfVictims;
    private String verdict; // optional for explanation/prediction

    @Override
    public Attribute getIdAttribute() {
        return new Attribute("dbId", this.getClass());
    }

    public CaseDescription(Verdict v) {
        this.dbId = v.getId();
        this.caseId = v.getCaseId();
        this.court = v.getCourt();
        this.date = v.getDate().toString();
        this.judge = v.getJudgeName();
        this.criminalOffense = v.getCriminalOffense();
        this.numDefendants = v.getNumDefendants();
        this.previouslyConvicted = v.getPreviouslyConvicted();
        this.awareOfIllegality = v.getAwareOfIllegality();
        this.victimRelationship = String.valueOf(v.getVictimRelationship());
        this.violenceNature = String.valueOf(v.getViolenceNature());
        this.injuryTypes = String.valueOf(v.getInjuryTypes());
        this.executionMeans = String.valueOf(v.getExecutionMeans());
        this.protectionMeasureViolation = v.getProtectionMeasureViolation();
        this.defendantAge = v.getDefendantAge();
        this.victimAge = v.getVictimAge();
        this.alcoholOrDrugs = v.getAlcoholOrDrugs();
        this.childrenPresent = v.getChildrenPresent();
        this.useOfWeapon = v.getUseOfWeapon();
        this.numberOfVictims = v.getNumberOfVictims();
        this.verdict = v.getVerdict() != null ? v.getVerdict().name() : null;
    }
}
