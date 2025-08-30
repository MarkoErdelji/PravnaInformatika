package com.pravnainfo.judgingapp.controller;

import com.pravnainfo.judgingapp.cbr.CbrApplication;
import com.pravnainfo.judgingapp.dto.CaseDescription;
import com.pravnainfo.judgingapp.dto.SimilarVerdict;
import com.pravnainfo.judgingapp.entity.Verdict;
import com.pravnainfo.judgingapp.entity.VerdictType;
import com.pravnainfo.judgingapp.repository.IVerdictRepository;
import es.ucm.fdi.gaia.jcolibri.exception.ExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/cases")
public class CaseController {

    @Autowired
    private IVerdictRepository verdictRepository;

    @Autowired
    private CbrApplication cbrApplication;

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

    // Add a new user-submitted case
    @PostMapping("/add")
    public ResponseEntity<Verdict> addCase(@RequestBody Verdict newCase) {
        Verdict saved = verdictRepository.save(newCase);
        return ResponseEntity.ok(saved);
    }

    // Predict verdict for a new case (reasoning)
    @PostMapping("/reason")
    public ResponseEntity<Map<String, Object>> reasonCase(@RequestBody CaseDescription queryCase) throws ExecutionException {

        // Convert DTO -> Verdict for DB ID
        Verdict tempVerdict = new Verdict();
        tempVerdict.setCriminalOffense(queryCase.getCriminalOffense());
        tempVerdict.setNumDefendants(queryCase.getNumDefendants());
        tempVerdict.setPreviouslyConvicted(queryCase.getPreviouslyConvicted());
        tempVerdict.setAwareOfIllegality(queryCase.getAwareOfIllegality());
        tempVerdict.setVictimRelationship(queryCase.getVictimRelationship());
        tempVerdict.setViolenceNature(queryCase.getViolenceNature());
        tempVerdict.setInjuryTypes(queryCase.getInjuryTypes());
        tempVerdict.setExecutionMeans(queryCase.getExecutionMeans());
        tempVerdict.setProtectionMeasureViolation(queryCase.getProtectionMeasureViolation());
        tempVerdict.setDefendantAge(queryCase.getDefendantAge());
        tempVerdict.setVictimAge(queryCase.getVictimAge());
        tempVerdict.setAlcoholOrDrugs(queryCase.getAlcoholOrDrugs());
        tempVerdict.setChildrenPresent(queryCase.getChildrenPresent());
        tempVerdict.setUseOfWeapon(queryCase.getUseOfWeapon());
        tempVerdict.setNumberOfVictims(queryCase.getNumberOfVictims());

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
                    // Filter out the same case
                    List<SimilarVerdict> filtered = similarCases.stream()
                            .filter(sv -> !sv.getCaseDescription().getDbId().equals(id))
                            .collect(Collectors.toList());
                    return ResponseEntity.ok(filtered);
                })
                .orElse(ResponseEntity.notFound().build());
    }
}
