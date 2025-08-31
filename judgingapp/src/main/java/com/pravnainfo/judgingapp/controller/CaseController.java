package com.pravnainfo.judgingapp.controller;

import com.pravnainfo.judgingapp.cbr.CbrApplication;
import com.pravnainfo.judgingapp.dto.CaseDescription;
import com.pravnainfo.judgingapp.dto.SimilarVerdict;
import com.pravnainfo.judgingapp.entity.Verdict;
import com.pravnainfo.judgingapp.repository.IVerdictRepository;
import com.pravnainfo.judgingapp.service.XmlGenerationService;
import es.ucm.fdi.gaia.jcolibri.exception.ExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/cases")
public class CaseController {

    @Autowired
    private IVerdictRepository verdictRepository;

    @Autowired
    private CbrApplication cbrApplication;

    @Autowired
    private XmlGenerationService xmlGenerationService;

    private static final String DEFAULT_XML_FOLDER = "./xml/";

    private List<String> loadXmlExamples() throws IOException {
        File folder = new File("./xml/");
        if (!folder.exists() || !folder.isDirectory()) {
            return new ArrayList<>();
        }

        File[] files = folder.listFiles((dir, name) -> name.endsWith(".xml"));
        if (files == null) return new ArrayList<>();

        List<String> examples = new ArrayList<>();
        for (File file : files) {
            String content = new String(Files.readAllBytes(file.toPath()), StandardCharsets.UTF_8);
            examples.add(content);
            if (examples.size() >= 5) break; // limit to 5
        }

        return examples;
    }
    // List all cases
    @GetMapping
    public List<Verdict> getAllCases() {
        return verdictRepository.findAll();
    }

    // Get single case by DB ID
    @GetMapping("/{id}")
    public ResponseEntity<Verdict> getCaseById(@PathVariable Long id) {
        return verdictRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    private String sanitizeCaseId(String caseId) {
        return caseId.replaceAll("[^a-zA-Z0-9\\-_\\.]", "_");
    }

    @PostMapping("/add")
    public ResponseEntity<Verdict> addCase(@RequestBody Verdict newCase,
                                           @RequestParam(value = "folder", required = false) String folder) throws IOException, ExecutionException {
        if (newCase.getCaseId() == null || newCase.getCaseId().isEmpty()) {
            return ResponseEntity.badRequest().body(null);
        }

        Verdict saved = verdictRepository.save(newCase);

        String xmlContent = xmlGenerationService.generateAkomaNtosoXml(saved, loadXmlExamples());

        String targetFolder = (folder != null && !folder.isEmpty()) ? folder : DEFAULT_XML_FOLDER;
        String xmlFileName = saveXmlToFile(xmlContent, targetFolder, saved.getCaseId());

        saved.setXmlFileName(xmlFileName);
        verdictRepository.save(saved);

        return ResponseEntity.ok(saved);
    }

    private String saveXmlToFile(String xmlContent, String folder, String caseId) throws IOException {
        File dir = new File(folder);
        if (!dir.exists()) dir.mkdirs();

        String fileName = sanitizeCaseId(caseId) + ".xml";
        File file = new File(dir, fileName);

        try (FileWriter writer = new FileWriter(file)) {
            writer.write(xmlContent);
        }

        return fileName;
    }

    @PostMapping("/reason")
    public ResponseEntity<Map<String, Object>> reasonCase(@RequestBody CaseDescription queryCase) throws ExecutionException {
        // Initialize CBR
        cbrApplication.configure();
        cbrApplication.preCycle();

        List<SimilarVerdict> similarCases = cbrApplication.predictVerdict(queryCase);

        // Weighted majority vote
        Map<String, Double> verdictScores = new HashMap<>();
        for (SimilarVerdict sv : similarCases) {
            String verdict = sv.getCaseDescription().getVerdict();
            double similarity = sv.getSimilarity();
            verdictScores.merge(verdict, similarity, Double::sum);
        }
        String predictedVerdict = verdictScores.entrySet().stream()
                .max(Map.Entry.comparingByValue())
                .map(Map.Entry::getKey)
                .orElse("UNKNOWN");

        Map<String, Object> response = new HashMap<>();
        response.put("predictedVerdict", predictedVerdict);
        response.put("similarCases", similarCases);

        cbrApplication.postCycle();

        return ResponseEntity.ok(response);
    }

    // Retrieve similar cases for an existing Verdict ID
    @GetMapping("/retrieve/{id}")
    public ResponseEntity<List<SimilarVerdict>> retrieveSimilarCases(@PathVariable Long id) throws ExecutionException {
        cbrApplication.configure();
        cbrApplication.preCycle();

        return verdictRepository.findById(id)
                .map(verdict -> {
                    CaseDescription queryCase = new CaseDescription(verdict);
                    List<SimilarVerdict> similarCases = null;
                    try {
                        similarCases = cbrApplication.getSimilarCases(queryCase);
                    } catch (ExecutionException e) {
                        throw new RuntimeException(e);
                    }
                    List<SimilarVerdict> filtered = similarCases.stream()
                            .filter(sv -> !sv.getCaseDescription().getCaseId().equals(verdict.getCaseId()))
                            .collect(Collectors.toList());
                    return ResponseEntity.ok(filtered);
                })
                .orElse(ResponseEntity.notFound().build());
    }
}