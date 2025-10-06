package com.pravnainfo.judgingapp.service;

import com.pravnainfo.judgingapp.dto.CaseDescription;
import org.apache.jena.rdf.model.Model;
import org.apache.jena.rdf.model.ModelFactory;
import org.apache.jena.rdf.model.Resource;
import org.apache.jena.rdf.model.Statement;
import org.apache.jena.rdf.model.StmtIterator;

import org.springframework.stereotype.Service;

import java.io.*;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@Service
public class DrDeviceService {

    private static final String DR_DEVICE_DIR = "./dr-device/";
    private static final String EXPORT_FILE_PATH = DR_DEVICE_DIR + "export.rdf";
    private static final String NS_EXPORT = "http://startrek.csd.auth.gr/dr-device/export/export.rdf#";
    private static final String NS_DEFEASIBLE = "http://lpis.csd.auth.gr/systems/dr-device/defeasible.rdfs#";

    public Map<String, Object> reasonCase(CaseDescription caseDescription) throws IOException, InterruptedException {
        String rdfFileName = generateRdfFile(caseDescription);

        runBatScript("clean.bat");

        runBatScript("start.bat");

        waitForExportFile();

        Map<String, String> reasoningResults = parseExportFile();

        return mapResultsToResponse(reasoningResults);
    }

    private String generateRdfFile(CaseDescription caseDescription) throws IOException {
        String caseId = "theft_case";

        int valueOfStolenItems = caseDescription.getValueOfStolenItems().intValue();

        StringBuilder sb = new StringBuilder();
        sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n");
        sb.append("<rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"\n")
                .append("         xmlns:rdfs=\"http://www.w3.org/2000/01/rdf-schema#\"\n")
                .append("         xmlns:xsd=\"http://www.w3.org/2001/XMLSchema#\"\n")
                .append("         xmlns:lc=\"http://ftn.uns.ac.rs/legal-case#\">\n");
        sb.append("  <rdfs:Class rdf:about=\"http://ftn.uns.ac.rs/legal-case#Case\"/>\n");
        sb.append("  <lc:case rdf:about=\"http://ftn.uns.ac.rs/legal-case#").append(caseId).append("\">\n");

        sb.append("    <lc:defendant>").append(caseDescription.getDefendantNames().get(0)).append("</lc:defendant>\n");
        sb.append("    <lc:is_movable_property>").append(caseDescription.getIsMovableProperty()).append("</lc:is_movable_property>\n");
        sb.append("    <lc:is_taken>").append(caseDescription.getIsTaken()).append("</lc:is_taken>\n");
        sb.append("    <lc:intent_to_appropriate>").append(caseDescription.getIntentToAppropriate()).append("</lc:intent_to_appropriate>\n");
        sb.append("    <lc:breaking_and_entering>").append(caseDescription.getBreakingAndEntering()).append("</lc:breaking_and_entering>\n");
        sb.append("    <lc:use_of_force_or_threat>").append(caseDescription.getUseOfForceOrThreat()).append("</lc:use_of_force_or_threat>\n");
        sb.append("    <lc:caught_in_the_act>").append(caseDescription.getCaughtInTheAct()).append("</lc:caught_in_the_act>\n");
        sb.append("    <lc:caused_severe_injury>").append(caseDescription.getCausedSevereInjury()).append("</lc:caused_severe_injury>\n");
        sb.append("    <lc:death_caused>").append(caseDescription.getDeathCaused()).append("</lc:death_caused>\n");
        sb.append("    <lc:case>").append(caseDescription.getCaseId()).append("</lc:case>\n");
        sb.append("    <lc:value_of_stolen_items rdf:datatype=\"http://www.w3.org/2001/XMLSchema#integer\">")
                .append(valueOfStolenItems).append("</lc:value_of_stolen_items>\n");

        sb.append("  </lc:case>\n");
        sb.append("</rdf:RDF>\n");

        String FACTS_FILE = DR_DEVICE_DIR + "facts.rdf";
        File dir = new File(DR_DEVICE_DIR);
        if (!dir.exists()) dir.mkdirs();

        try (FileOutputStream out = new FileOutputStream(FACTS_FILE)) {
            out.write(sb.toString().getBytes());
        }

        return FACTS_FILE;
    }

    private void runBatScript(String batFileName) throws IOException, InterruptedException {
        ProcessBuilder pb = new ProcessBuilder("cmd.exe", "/c", batFileName);
        pb.directory(new File(DR_DEVICE_DIR));
        pb.redirectErrorStream(true);

        Process process = pb.start();

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
            String line;
            while ((line = reader.readLine()) != null) {
                System.out.println("[DR-DEVICE] " + line);
            }
        }

        boolean finished = process.waitFor(60, TimeUnit.SECONDS);
        if (!finished) {
            process.destroy();
            throw new RuntimeException("Timeout while executing: " + batFileName);
        }

        int exitCode = process.exitValue();
        if (exitCode != 0) {
            throw new RuntimeException("Script failed: " + batFileName + " (exit code " + exitCode + ")");
        }
    }


    private void waitForExportFile() throws InterruptedException {
        File exportFile = new File(EXPORT_FILE_PATH);
        int maxWaitSeconds = 30;
        int waitedSeconds = 0;
        while (!exportFile.exists() && waitedSeconds < maxWaitSeconds) {
            Thread.sleep(1000);
            waitedSeconds++;
        }
        if (!exportFile.exists()) {
            throw new RuntimeException("Izvoz fajla nije generisan u roku od " + maxWaitSeconds + " sekundi.");
        }
    }

    private Map<String, String> parseExportFile() throws IOException {
        Map<String, String> results = new HashMap<>();
        Model model = ModelFactory.createDefaultModel();
        try (FileInputStream in = new FileInputStream(EXPORT_FILE_PATH)) {
            model.read(in, null, "RDF/XML");
        }

        String[] levels = {"is_theft_lv1", "is_theft_lv2", "is_theft_lv3", "is_theft_lv4", "is_theft_lv5", "is_theft_lv6"};
        for (String level : levels) {
            StmtIterator iter = model.listStatements(null, model.getProperty(NS_DEFEASIBLE + "truthStatus"), "defeasibly-proven-positive");
            while (iter.hasNext()) {
                Statement stmt = iter.next();
                Resource resource = stmt.getSubject();
                if (resource.getURI().contains(level)) {
                    results.put("theft_level", level);
                    break;
                }
            }
            if (results.containsKey("theft_level")) break;
        }

        StmtIterator minIter = model.listStatements(null, model.getProperty(NS_DEFEASIBLE + "truthStatus"), "defeasibly-proven-positive");
        while (minIter.hasNext()) {
            Statement stmt = minIter.next();
            Resource resource = stmt.getSubject();
            if (resource.getURI().contains("min_imprisonment")) {
                Statement valueStmt = resource.getProperty(model.getProperty(NS_EXPORT + "value"));
                if (valueStmt != null) {
                    results.put("min_imprisonment", valueStmt.getString());
                    break;
                }
            }
        }

        StmtIterator maxIter = model.listStatements(null, model.getProperty(NS_DEFEASIBLE + "truthStatus"), "defeasibly-proven-positive");
        while (maxIter.hasNext()) {
            Statement stmt = maxIter.next();
            Resource resource = stmt.getSubject();
            if (resource.getURI().contains("max_imprisonment")) {
                Statement valueStmt = resource.getProperty(model.getProperty(NS_EXPORT + "value"));
                if (valueStmt != null) {
                    results.put("max_imprisonment", valueStmt.getString());
                    break;
                }
            }
        }

        StmtIterator monetaryIter = model.listStatements(null, model.getProperty(NS_DEFEASIBLE + "truthStatus"), "defeasibly-proven-positive");
        while (monetaryIter.hasNext()) {
            Statement stmt = monetaryIter.next();
            Resource resource = stmt.getSubject();
            if (resource.getURI().contains("monetary_penalty")) {
                Statement valueStmt = resource.getProperty(model.getProperty(NS_EXPORT + "value"));
                if (valueStmt != null) {
                    results.put("monetary_penalty", valueStmt.getString());
                    break;
                }
            }
        }

        return results;
    }

    private Map<String, Object> mapResultsToResponse(Map<String, String> reasoningResults) {
        Map<String, Object> response = new HashMap<>();
        String theftLevel = reasoningResults.get("theft_level");
        String judgment;
        String penalty;
        String accusation;

        String minImprisonment = reasoningResults.getOrDefault("min_imprisonment", "0");
        String maxImprisonment = reasoningResults.getOrDefault("max_imprisonment", "0");
        String monetaryPenalty = reasoningResults.get("monetary_penalty");

        switch (theftLevel != null ? theftLevel : "") {
            case "is_theft_lv1":
                judgment = "FINE_AND_PRISON";
                penalty = monetaryPenalty != null
                        ? "Novčana kazna ili zatvor do " + maxImprisonment + " godina"
                        : "Zatvor do " + maxImprisonment + " godina";
                accusation = "čl. 239 st. 1";
                break;
            case "is_theft_lv2":
                judgment = "PRISON";
                penalty = "Zatvor od " + minImprisonment + " do " + maxImprisonment + " godina";
                accusation = "čl. 240 st. 1";
                break;
            case "is_theft_lv3":
                judgment = "PRISON";
                penalty = "Zatvor od " + minImprisonment + " do " + maxImprisonment + " godina";
                accusation = "čl. 240 st. 3";
                break;
            case "is_theft_lv4":
                judgment = "PRISON";
                penalty = "Zatvor od " + minImprisonment + " do " + maxImprisonment + " godina";
                accusation = "čl. 241 st. 1";
                break;
            case "is_theft_lv5":
                judgment = "PRISON";
                penalty = "Zatvor od " + minImprisonment + " do " + maxImprisonment + " godina";
                accusation = "čl. 241 st. 4";
                break;
            case "is_theft_lv6":
                judgment = "PRISON";
                penalty = minImprisonment.equals("10")
                        ? "Zatvor od najmanje " + minImprisonment + " godina ili dugotrajni zatvor"
                        : "Zatvor od " + minImprisonment + " do " + maxImprisonment + " godina";
                accusation = "čl. 241 st. 5";
                break;
            default:
                judgment = "NONE";
                penalty = "Nije utvrđena odgovarajuća kazna";
                accusation = "Ostalo";
        }

        response.put("judgment", judgment);
        response.put("penalty", penalty);
        response.put("accusation", accusation);

        return response;
    }
}