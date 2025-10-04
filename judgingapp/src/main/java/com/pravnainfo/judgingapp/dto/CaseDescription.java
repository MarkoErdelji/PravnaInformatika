package com.pravnainfo.judgingapp.dto;

import com.pravnainfo.judgingapp.entity.Verdict;
import com.pravnainfo.judgingapp.entity.AccusationType;
import es.ucm.fdi.gaia.jcolibri.cbrcore.Attribute;
import es.ucm.fdi.gaia.jcolibri.cbrcore.CaseComponent;
import lombok.*;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CaseDescription implements CaseComponent {

    private Long dbId;
    private String caseId;
    private List<String> defendantNames;
    private String victim;
    private List<AccusationType> accusationTypes;
    private String judgment;
    private Boolean isMovableProperty;
    private Boolean isTaken;
    private Boolean intentToAppropriate;
    private Double valueOfStolenItems;
    private Boolean isCulturalOrNaturalGood;
    private Boolean breakingAndEntering;
    private Boolean particularlyDangerousOrBrazen;
    private Boolean exploitingHelplessness;
    private Boolean duringDisaster;
    private Boolean isArmed;
    private Boolean useOfForceOrThreat;
    private Boolean caughtInTheAct;
    private Boolean intentForSmallGain;
    private Boolean causedSevereInjury;
    private Boolean deathCaused;
    private Boolean attemptedCrime;
    private Integer numberOfPerpetrators;

    public CaseDescription(Verdict verdict) {
        this.dbId = verdict.getId();
        this.caseId = verdict.getCaseId();
        this.defendantNames = verdict.getDefendantNames() != null ? new ArrayList<>(verdict.getDefendantNames()) : new ArrayList<>();
        this.victim = verdict.getVictim();
        this.accusationTypes = verdict.getAccusationTypes() != null ? new ArrayList<>(verdict.getAccusationTypes()) : new ArrayList<>();
        this.judgment = verdict.getJudgment();
        this.isMovableProperty = verdict.getIsMovableProperty();
        this.isTaken = verdict.getIsTaken();
        this.intentToAppropriate = verdict.getIntentToAppropriate();
        this.valueOfStolenItems = verdict.getValueOfStolenItems();
        this.isCulturalOrNaturalGood = verdict.getIsCulturalOrNaturalGood();
        this.breakingAndEntering = verdict.getBreakingAndEntering();
        this.particularlyDangerousOrBrazen = verdict.getParticularlyDangerousOrBrazen();
        this.exploitingHelplessness = verdict.getExploitingHelplessness();
        this.duringDisaster = verdict.getDuringDisaster();
        this.isArmed = verdict.getIsArmed();
        this.useOfForceOrThreat = verdict.getUseOfForceOrThreat();
        this.caughtInTheAct = verdict.getCaughtInTheAct();
        this.intentForSmallGain = verdict.getIntentForSmallGain();
        this.causedSevereInjury = verdict.getCausedSevereInjury();
        this.deathCaused = verdict.getDeathCaused();
        this.attemptedCrime = verdict.getAttemptedCrime();
        this.numberOfPerpetrators = verdict.getNumberOfPerpetrators();
    }


    @Override
    public Attribute getIdAttribute() {
        return new Attribute("dbId", this.getClass());
    }
}