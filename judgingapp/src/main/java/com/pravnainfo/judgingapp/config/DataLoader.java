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
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

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
        verdictRepository.deleteAll();

        try (InputStreamReader reader = new InputStreamReader(
                new ClassPathResource("verdicts.csv").getInputStream(), StandardCharsets.UTF_8);
             CSVParser csvParser = new CSVParser(reader, CSVFormat.DEFAULT
                     .withDelimiter(';')
                     .withHeader()
                     .withSkipHeaderRecord(true))) {

            for (CSVRecord record : csvParser) {
                String defendantStr = getSafeString(record, "DEFENDANT");
                List<String> defendantList = List.of(defendantStr.split(","))
                        .stream().map(String::trim).filter(s -> !s.isEmpty()).collect(Collectors.toList());

                String accusationStr = getSafeString(record, "ACCUSATION");
                List<String> accusationList = List.of(accusationStr.split(";"))
                        .stream().map(String::trim).filter(s -> !s.isEmpty()).collect(Collectors.toList());

                Verdict verdict = Verdict.builder()
                        .caseId(getSafeString(record, "ID"))
                        .court(getSafeString(record, "COURT"))
                        .caseNumber(getSafeString(record, "CASE NUMBER"))
                        .judge(getSafeString(record, "JUDGE"))
                        .clerk(getSafeString(record, "CLERK"))
                        .prosecutor(getSafeString(record, "PROSECUTOR"))
                        .defendantNames(defendantList)
                        .victim(getSafeString(record, "VICTIM"))
                        .shortDescription(getSafeString(record, "SHORT DESCRIPTION"))
                        .judgment(getSafeString(record, "JUDGMENT"))
                        .appliedProvisions(getSafeString(record, "APPLIED PROVISIONS"))
                        .accusations(accusationList)
                        .verdictDate(parseDate(getSafeString(record, "VERDICT DATE")))
                        .isMovableProperty(parseBoolean(getSafeString(record, "IS MOVABLE PROPERTY")))
                        .isTaken(parseBoolean(getSafeString(record, "IS TAKEN")))
                        .intentToAppropriate(parseBoolean(getSafeString(record, "INTENT TO APPROPRIATE")))
                        .valueOfStolenItems(parseDouble(getSafeString(record, "VALUE OF STOLEN ITEMS"), 0.0))
                        .isCulturalOrNaturalGood(parseBoolean(getSafeString(record, "IS CULTURAL OR NATURAL GOOD")))
                        .breakingAndEntering(parseBoolean(getSafeString(record, "BREAKING AND ENTERING")))
                        .particularlyDangerousOrBrazen(parseBoolean(getSafeString(record, "PARTICULARLY DANGEROUS OR BRAZEN")))
                        .exploitingHelplessness(parseBoolean(getSafeString(record, "EXPLOITING HELPLESSNESS")))
                        .duringDisaster(parseBoolean(getSafeString(record, "DURING DISASTER")))
                        .isArmed(parseBoolean(getSafeString(record, "IS ARMED")))
                        .useOfForceOrThreat(parseBoolean(getSafeString(record, "USE OF FORCE OR THREAT")))
                        .caughtInTheAct(parseBoolean(getSafeString(record, "CAUGHT IN THE ACT")))
                        .causedSevereInjury(parseBoolean(getSafeString(record, "CAUSED SEVERE INJURY")))
                        .deathCaused(parseBoolean(getSafeString(record, "DEATH CAUSED")))
                        .attemptedCrime(parseBoolean(getSafeString(record, "ATTEMPTED CRIME")))
                        .numberOfPerpetrators(parseInteger(getSafeString(record, "NUMBER OF PERPETRATORS"), 1))
                        .xmlFileName(sanitizeCaseId(getSafeString(record, "ID")) + ".xml")
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

    private Boolean parseBoolean(String value) {
        try {
            return value != null && !value.isEmpty() ? Boolean.parseBoolean(value.toLowerCase()) : false;
        } catch (Exception e) {
            return false;
        }
    }

    private Double parseDouble(String value, double defaultValue) {
        try {
            return value != null && !value.isEmpty() ? Double.parseDouble(value) : defaultValue;
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private Integer parseInteger(String value, int defaultValue) {
        try {
            return value != null && !value.isEmpty() ? Integer.parseInt(value) : defaultValue;
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }
}