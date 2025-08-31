package com.pravnainfo.judgingapp.config;

import com.pravnainfo.judgingapp.entity.*;
import com.pravnainfo.judgingapp.repository.IVerdictRepository;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Component
public class DataLoader implements CommandLineRunner {

    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    @Autowired
    private IVerdictRepository verdictRepository;

    private String sanitizeCaseId(String caseId) {
        return caseId.replaceAll("[^a-zA-Z0-9\\-_\\.]", "_");
    }

    @Override
    public void run(String... args) throws Exception {
        // Clear existing data
        verdictRepository.deleteAll();

        // Load CSV
        try (InputStreamReader reader = new InputStreamReader(
                new ClassPathResource("verdicts.csv").getInputStream(), StandardCharsets.UTF_8);
             CSVParser csvParser = new CSVParser(reader, CSVFormat.DEFAULT
                     .withDelimiter(';')
                     .withHeader()
                     .withSkipHeaderRecord(true))) {

            for (CSVRecord record : csvParser) {
                Verdict verdict = Verdict.builder()
                        .caseId(getSafeString(record, "id"))
                        .court(getSafeString(record, "Court"))
                        .verdictNumber(getSafeString(record, "Case Number"))
                        .date(parseDate(getSafeString(record, "Verdict Date")))
                        .judgeName(getSafeString(record, "Judge"))
                        .prosecutor(getSafeString(record, "Prosecutor"))
                        .defendantName(getSafeString(record, "Defendant"))
                        .criminalOffense(getSafeString(record, "Criminal Offense"))
                        .appliedProvisions(getSafeString(record, "Applied Provisions"))
                        .verdict(parseVerdictType(getSafeString(record, "Verdict Type")))
                        .numDefendants(parseInteger(getSafeString(record, "Number of Defendants"), 1))
                        .previouslyConvicted(!getSafeString(record, "Previous Incidents").isEmpty())
                        .awareOfIllegality(Boolean.parseBoolean(getSafeString(record, "Aware of Illegality")))
                        .victimRelationship(parseVictimRelationship(getSafeString(record, "Victim Relationship")))
                        .violenceNature(parseViolenceNature(getSafeString(record, "Violence Nature")))
                        .injuryTypes(parseInjuryTypes(getSafeString(record, "Injury Types")))
                        .executionMeans(parseExecutionMeans(getSafeString(record, "Execution Means")))
                        .protectionMeasureViolation(Boolean.parseBoolean(getSafeString(record, "Protection Measure Violation")))
                        .eventLocation(getSafeString(record, "Event Location"))
                        .eventDate(parseDate(getSafeString(record, "Event Date")))
                        .defendantStatus(getSafeString(record, "Defendant Status"))
                        .victims(getSafeString(record, "Victim"))
                        .defendantAge(parseAge(getSafeString(record, "Defendant Age")))
                        .victimAge(parseAge(getSafeString(record, "Victim Age")))
                        .previousIncidents(getSafeString(record, "Previous Incidents"))
                        .alcoholOrDrugs(Boolean.parseBoolean(getSafeString(record, "Alcohol or Drugs")))
                        .childrenPresent(Boolean.parseBoolean(getSafeString(record, "Children Present")))
                        .penalty(getSafeString(record, "Penalty"))
                        .procedureCosts(getSafeString(record, "Procedure Costs"))
                        .useOfWeapon(Boolean.parseBoolean(getSafeString(record, "Use of Weapon")))
                        .numberOfVictims(parseInteger(getSafeString(record, "Number of Victims"), 0))
                        .xmlFileName(sanitizeCaseId(getSafeString(record, "id")) + ".xml")
                        .build();

                verdictRepository.save(verdict);
            }
        }
        System.out.println("Loaded verdicts.csv into H2 database");
    }

    private String getSafeString(CSVRecord record, String column) {
        try {
            return record.isSet(column) && !record.get(column).isEmpty() ? record.get(column).trim() : "";
        } catch (Exception e) {
            return "";
        }
    }

    private LocalDate parseDate(String date) {
        try {
            return date != null && !date.isEmpty() ? LocalDate.parse(date, DATE_FORMATTER) : null;
        } catch (Exception e) {
            return null;
        }
    }

    private VerdictType parseVerdictType(String verdict) {
        if (verdict == null || verdict.isEmpty()) return VerdictType.SUSPENDED;
        try {
            return VerdictType.valueOf(verdict.toUpperCase());
        } catch (IllegalArgumentException e) {
            return VerdictType.SUSPENDED;
        }
    }

    private VictimRelationship parseVictimRelationship(String relationship) {
        if (relationship == null || relationship.isEmpty()) return VictimRelationship.OTHER;
        try {
            return VictimRelationship.valueOf(relationship.toUpperCase());
        } catch (IllegalArgumentException e) {
            return VictimRelationship.OTHER;
        }
    }

    private ViolenceNature parseViolenceNature(String violence) {
        if (violence == null || violence.isEmpty()) return ViolenceNature.NONE;
        String normalized = violence.toLowerCase();
        if (normalized.contains("rough violence")) {
            return ViolenceNature.VIOLENCE;
        } else if (normalized.contains("threat")) {
            return ViolenceNature.THREAT;
        } else if (normalized.contains("arrogant and reckless behavior")) {
            return ViolenceNature.RECKLESS_BEHAVIOUR;
        } else {
            return ViolenceNature.NONE;
        }
    }

    private InjuryTypes parseInjuryTypes(String injuries) {
        if (injuries == null || injuries.isEmpty()) return InjuryTypes.NONE;
        String normalized = injuries.toLowerCase();
        if (normalized.contains("light") && normalized.contains("severe")) {
            return InjuryTypes.LIGHT_SEVERE;
        } else if (normalized.contains("light")) {
            return InjuryTypes.LIGHT;
        } else if (normalized.contains("severe")) {
            return InjuryTypes.SEVERE;
        } else {
            return InjuryTypes.NONE;
        }
    }

    private ExecutionMeans parseExecutionMeans(String means) {
        if (means == null || means.isEmpty()) return ExecutionMeans.OTHER;
        String normalized = means.toLowerCase();
        if (normalized.contains("hands")) {
            return ExecutionMeans.HANDS;
        } else if (normalized.contains("feet")) {
            return ExecutionMeans.FEET;
        } else if (normalized.contains("weapon")) {
            return ExecutionMeans.WEAPON;
        } else if (normalized.contains("tool")) {
            return ExecutionMeans.TOOL;
        } else if (normalized.contains("verbal")) {
            return ExecutionMeans.VERBAL;
        } else {
            return ExecutionMeans.OTHER;
        }
    }

    private Integer parseInteger(String value, int defaultValue) {
        try {
            return value != null && !value.isEmpty() ? Integer.parseInt(value) : defaultValue;
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private Integer parseAge(String age) {
        if (age == null || age.isEmpty()) return null;
        try {
            return Integer.parseInt(age.replaceAll("[^0-9]", ""));
        } catch (NumberFormatException e) {
            return null;
        }
    }
}