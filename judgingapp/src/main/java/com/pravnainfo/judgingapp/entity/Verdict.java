package com.pravnainfo.judgingapp.entity;

import lombok.*;
import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Verdict {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String caseId;

    @Column(name = "court")
    private String court;

    @Column(name = "verdict_number")
    private String verdictNumber;

    @Column(name = "date")
    private LocalDate date;

    @Column(name = "judge_name")
    private String judgeName;

    @Column(name = "prosecutor")
    private String prosecutor;

    @Column(name = "defendant_name")
    private String defendantName;

    @Column(name = "criminal_offense")
    private String criminalOffense;

    @Column(name = "applied_provisions")
    private String appliedProvisions;

    @Enumerated(EnumType.STRING)
    @Column(name = "verdict")
    private VerdictType verdict;

    @Column(name = "num_defendants")
    private Integer numDefendants;

    @Column(name = "previously_convicted")
    private Boolean previouslyConvicted;

    @Column(name = "aware_of_illegality")
    private Boolean awareOfIllegality;

    @Column(name = "victim_relationship")
    private String victimRelationship;

    @Column(name = "violence_nature")
    private String violenceNature;

    @Column(name = "injury_types")
    private String injuryTypes;

    @Column(name = "execution_means")
    private String executionMeans;

    @Column(name = "protection_measure_violation")
    private Boolean protectionMeasureViolation;

    @Column(name = "event_location")
    private String eventLocation;

    @Column(name = "event_date")
    private LocalDate eventDate;

    @Column(name = "defendant_status")
    private String defendantStatus;

    @Column(name = "victims")
    private String victims;

    @Column(name = "defendant_age")
    private Integer defendantAge;

    @Column(name = "victim_age")
    private Integer victimAge;

    @Column(name = "previous_incidents")
    private String previousIncidents;

    @Column(name = "alcohol_or_drugs")
    private Boolean alcoholOrDrugs;

    @Column(name = "children_present")
    private Boolean childrenPresent;

    @Column(name = "penalty")
    private String penalty;

    @Column(name = "procedure_costs")
    private String procedureCosts;

    @Column(name = "use_of_weapon")
    private Boolean useOfWeapon;

    @Column(name = "number_of_victims")
    private Integer numberOfVictims;
}