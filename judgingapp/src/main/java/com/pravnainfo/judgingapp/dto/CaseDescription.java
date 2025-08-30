package com.pravnainfo.judgingapp.dto;

import com.pravnainfo.judgingapp.entity.Verdict;
import com.pravnainfo.judgingapp.entity.VerdictType;
import es.ucm.fdi.gaia.jcolibri.cbrcore.Attribute;
import es.ucm.fdi.gaia.jcolibri.cbrcore.CaseComponent;
import java.time.LocalDate;

public class CaseDescription implements CaseComponent {
    private String id;
    private String court;
    private String verdictNumber;
    private LocalDate date;
    private String judgeName;
    private String prosecutor;
    private String defendantName;
    private String criminalOffense;
    private String appliedProvisions;
    private String verdict;
    private Integer numDefendants;
    private Boolean previouslyConvicted;
    private Boolean awareOfIllegality;
    private String victimRelationship;
    private String violenceNature;
    private String injuryTypes;
    private String executionMeans;
    private Boolean protectionMeasureViolation;
    private String eventLocation;
    private LocalDate eventDate;
    private String defendantStatus;
    private String victims;
    private Integer defendantAge;
    private Integer victimAge;
    private String previousIncidents;
    private Boolean alcoholOrDrugs;
    private Boolean childrenPresent;
    private String penalty;
    private String procedureCosts;
    private Boolean useOfWeapon;
    private Integer numberOfVictims;

    public CaseDescription() {}

    public CaseDescription(Verdict v) {
        this.id = truncate(v.getId());
        this.court = truncate(v.getCourt());
        this.verdictNumber = truncate(v.getVerdictNumber());
        this.date = v.getDate();
        this.judgeName = truncate(v.getJudgeName());
        this.prosecutor = truncate(v.getProsecutor());
        this.defendantName = truncate(v.getDefendantName());
        this.criminalOffense = truncate(v.getCriminalOffense());
        this.appliedProvisions = truncate(v.getAppliedProvisions());
        this.verdict = v.getVerdict() != null ? v.getVerdict().name() : null;
        this.previouslyConvicted = v.getPreviouslyConvicted();
        this.awareOfIllegality = v.getAwareOfIllegality();
        this.victimRelationship = truncate(v.getVictimRelationship());
        this.violenceNature = truncate(v.getViolenceNature());
        this.injuryTypes = truncate(v.getInjuryTypes());
        this.executionMeans = truncate(v.getExecutionMeans());
        this.protectionMeasureViolation = v.getProtectionMeasureViolation();
        this.eventLocation = truncate(v.getEventLocation());
        this.eventDate = v.getEventDate();
        this.defendantStatus = truncate(v.getDefendantStatus());
        this.victims = truncate(v.getVictims());
        this.defendantAge = v.getDefendantAge();
        this.victimAge = v.getVictimAge();
        this.previousIncidents = truncate(v.getPreviousIncidents());
        this.alcoholOrDrugs = v.getAlcoholOrDrugs();
        this.childrenPresent = v.getChildrenPresent();
        this.penalty = truncate(v.getPenalty());
        this.procedureCosts = truncate(v.getProcedureCosts());
        this.useOfWeapon = v.getUseOfWeapon();
        this.numberOfVictims = v.getNumberOfVictims();
    }

    private String truncate(String s) {
        if (s == null) return "";
        return s.length() > 255 ? s.substring(0, 255) : s;
    }

    // Getters and setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getCourt() { return court; }
    public void setCourt(String court) { this.court = court; }
    public String getVerdictNumber() { return verdictNumber; }
    public void setVerdictNumber(String verdictNumber) { this.verdictNumber = verdictNumber; }
    public LocalDate getDate() { return date; }
    public void setDate(LocalDate date) { this.date = date; }
    public String getJudgeName() { return judgeName; }
    public void setJudgeName(String judgeName) { this.judgeName = judgeName; }
    public String getProsecutor() { return prosecutor; }
    public void setProsecutor(String prosecutor) { this.prosecutor = prosecutor; }
    public String getDefendantName() { return defendantName; }
    public void setDefendantName(String defendantName) { this.defendantName = defendantName; }
    public String getCriminalOffense() { return criminalOffense; }
    public void setCriminalOffense(String criminalOffense) { this.criminalOffense = criminalOffense; }
    public String getAppliedProvisions() { return appliedProvisions; }
    public void setAppliedProvisions(String appliedProvisions) { this.appliedProvisions = appliedProvisions; }
    public String getVerdict() { return verdict; }
    public void setVerdict(String verdict) { this.verdict = verdict; }
    public Integer getNumDefendants() { return numDefendants; }
    public void setNumDefendants(Integer numDefendants) { this.numDefendants = numDefendants; }
    public Boolean getPreviouslyConvicted() { return previouslyConvicted; }
    public void setPreviouslyConvicted(Boolean previouslyConvicted) { this.previouslyConvicted = previouslyConvicted; }
    public Boolean getAwareOfIllegality() { return awareOfIllegality; }
    public void setAwareOfIllegality(Boolean awareOfIllegality) { this.awareOfIllegality = awareOfIllegality; }
    public String getVictimRelationship() { return victimRelationship; }
    public void setVictimRelationship(String victimRelationship) { this.victimRelationship = victimRelationship; }
    public String getViolenceNature() { return violenceNature; }
    public void setViolenceNature(String violenceNature) { this.violenceNature = violenceNature; }
    public String getInjuryTypes() { return injuryTypes; }
    public void setInjuryTypes(String injuryTypes) { this.injuryTypes = injuryTypes; }
    public String getExecutionMeans() { return executionMeans; }
    public void setExecutionMeans(String executionMeans) { this.executionMeans = executionMeans; }
    public Boolean getProtectionMeasureViolation() { return protectionMeasureViolation; }
    public void setProtectionMeasureViolation(Boolean protectionMeasureViolation) { this.protectionMeasureViolation = protectionMeasureViolation; }
    public String getEventLocation() { return eventLocation; }
    public void setEventLocation(String eventLocation) { this.eventLocation = eventLocation; }
    public LocalDate getEventDate() { return eventDate; }
    public void setEventDate(LocalDate eventDate) { this.eventDate = eventDate; }
    public String getDefendantStatus() { return defendantStatus; }
    public void setDefendantStatus(String defendantStatus) { this.defendantStatus = defendantStatus; }
    public String getVictims() { return victims; }
    public void setVictims(String victims) { this.victims = victims; }
    public Integer getDefendantAge() { return defendantAge; }
    public void setDefendantAge(Integer defendantAge) { this.defendantAge = defendantAge; }
    public Integer getVictimAge() { return victimAge; }
    public void setVictimAge(Integer victimAge) { this.victimAge = victimAge; }
    public String getPreviousIncidents() { return previousIncidents; }
    public void setPreviousIncidents(String previousIncidents) { this.previousIncidents = previousIncidents; }
    public Boolean getAlcoholOrDrugs() { return alcoholOrDrugs; }
    public void setAlcoholOrDrugs(Boolean alcoholOrDrugs) { this.alcoholOrDrugs = alcoholOrDrugs; }
    public Boolean getChildrenPresent() { return childrenPresent; }
    public void setChildrenPresent(Boolean childrenPresent) { this.childrenPresent = childrenPresent; }
    public String getPenalty() { return penalty; }
    public void setPenalty(String penalty) { this.penalty = penalty; }
    public String getProcedureCosts() { return procedureCosts; }
    public void setProcedureCosts(String procedureCosts) { this.procedureCosts = procedureCosts; }
    public Boolean getUseOfWeapon() { return useOfWeapon; }
    public void setUseOfWeapon(Boolean useOfWeapon) { this.useOfWeapon = useOfWeapon; }
    public Integer getNumberOfVictims() { return numberOfVictims; }
    public void setNumberOfVictims(Integer numberOfVictims) { this.numberOfVictims = numberOfVictims; }

    @Override
    public Attribute getIdAttribute() {
        return new Attribute("id", this.getClass());
    }
}