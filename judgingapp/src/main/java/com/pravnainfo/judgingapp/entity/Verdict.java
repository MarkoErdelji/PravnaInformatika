package com.pravnainfo.judgingapp.entity;

import lombok.*;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Verdict {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "case_id", unique = true, nullable = false)
    private String caseId;

    @Column(name = "court")
    private String court;

    @Column(name = "case_number")
    private String caseNumber;

    @Column(name = "judge")
    private String judge;

    @Column(name = "clerk")
    private String clerk;

    @Column(name = "prosecutor")
    private String prosecutor;

    @Builder.Default
    @ElementCollection
    @CollectionTable(name = "verdict_defendants", joinColumns = @JoinColumn(name = "verdict_id"))
    @Column(name = "defendant_name")
    private List<String> defendantNames = new ArrayList<>();

    @Column(name = "victim")
    private String victim;

    @Column(name = "short_description")
    private String shortDescription;

    @Column(name = "judgment")
    private String judgment;

    @Column(name = "applied_provisions")
    private String appliedProvisions;

    @Builder.Default
    @ElementCollection
    @CollectionTable(name = "verdict_accusations", joinColumns = @JoinColumn(name = "verdict_id"))
    @Column(name = "accusation")
    private List<String> accusations = new ArrayList<>();

    @Column(name = "verdict_date")
    private LocalDate verdictDate;

    @Column(name = "is_movable_property")
    private Boolean isMovableProperty;

    @Column(name = "is_taken")
    private Boolean isTaken;

    @Column(name = "intent_to_appropriate")
    private Boolean intentToAppropriate;

    @Column(name = "value_of_stolen_items")
    private Double valueOfStolenItems;

    @Column(name = "breaking_and_entering")
    private Boolean breakingAndEntering;

    @Column(name = "use_of_force_or_threat")
    private Boolean useOfForceOrThreat;

    @Column(name = "caught_in_the_act")
    private Boolean caughtInTheAct;

    @Column(name = "caused_severe_injury")
    private Boolean causedSevereInjury;

    @Column(name = "death_caused")
    private Boolean deathCaused;

    @Column(name = "xml_file_name")
    private String xmlFileName;

    @Column(name = "monetary_penalty")
    private Double monetaryPenalty;

    @Column(name = "prison_penalty")
    private Double prisonPenalty;

    public List<AccusationType> getAccusationTypes() {
        return accusations.stream()
                .map(AccusationType::parse)
                .collect(Collectors.toList());
    }
}