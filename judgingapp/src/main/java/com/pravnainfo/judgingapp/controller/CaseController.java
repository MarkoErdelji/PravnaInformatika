package com.pravnainfo.judgingapp.controller;

import com.pravnainfo.judgingapp.cbr.CbrApplication;
import com.pravnainfo.judgingapp.dto.CaseDescription;
import com.pravnainfo.judgingapp.dto.SimilarVerdict;
import com.pravnainfo.judgingapp.entity.Verdict;
import com.pravnainfo.judgingapp.repository.IVerdictRepository;
import es.ucm.fdi.gaia.jcolibri.cbrcore.CBRQuery;
import es.ucm.fdi.gaia.jcolibri.exception.ExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

    @GetMapping
    public List<Verdict> getAllCases() {
        return verdictRepository.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Verdict> getCaseById(@PathVariable String id) {
        return verdictRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/add")
    public Verdict addCase(@RequestBody Verdict verdict) {
        return verdictRepository.save(verdict);
    }

    @GetMapping("/retrieve/{id}")
    public ResponseEntity<List<SimilarVerdict>> retrieveSimilarCases(@PathVariable String id) throws ExecutionException {
        return verdictRepository.findById(id)
                .map(verdict -> {
                    CaseDescription queryCase = new CaseDescription(verdict);
                    List<SimilarVerdict> similarCases = CbrApplication.findSimilarJudgements(queryCase, cbrApplication);
                    // Filter out the case with the same ID
                    List<SimilarVerdict> filteredCases = similarCases.stream()
                            .filter(sv -> !sv.getCaseDescription().getId().equals(id))
                            .collect(Collectors.toList());
                    return ResponseEntity.ok(filteredCases);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/reason")
    public ResponseEntity<Map<String, Object>> reasonCase(@RequestBody CaseDescription queryCase) throws ExecutionException {
        cbrApplication.configure();
        cbrApplication.preCycle();
        CBRQuery query = new CBRQuery();
        query.setDescription(queryCase);
        cbrApplication.cycle(query);
        List<SimilarVerdict> results = cbrApplication.getSimilarCases(query);
        cbrApplication.postCycle();

        // Predict verdict by weighted majority vote
        Map<String, Double> verdictScores = new HashMap<>();
        for (SimilarVerdict sv : results) {
            String verdict = sv.getCaseDescription().getVerdict();
            double similarity = sv.getSimilarity();
            verdictScores.merge(verdict, similarity, Double::sum);
        }
        String predictedVerdict = verdictScores.entrySet().stream()
                .max(Map.Entry.comparingByValue())
                .map(Map.Entry::getKey)
                .orElse("UNKNOWN");

        // Return both predicted verdict and similar cases
        Map<String, Object> response = new HashMap<>();
        response.put("predictedVerdict", predictedVerdict);
        response.put("similarCases", results);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/find-similar")
    public List<SimilarVerdict> findSimilarCases(@RequestBody CaseDescription queryCase) throws ExecutionException {
        return CbrApplication.findSimilarJudgements(queryCase, cbrApplication);
    }
}