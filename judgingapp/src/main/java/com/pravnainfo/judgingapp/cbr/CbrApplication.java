package com.pravnainfo.judgingapp.cbr;

import com.pravnainfo.judgingapp.dto.CaseDescription;
import com.pravnainfo.judgingapp.dto.SimilarVerdict;
import com.pravnainfo.judgingapp.entity.VerdictType;
import es.ucm.fdi.gaia.jcolibri.cbraplications.StandardCBRApplication;
import es.ucm.fdi.gaia.jcolibri.cbrcore.*;
import es.ucm.fdi.gaia.jcolibri.exception.ExecutionException;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.NNretrieval.NNConfig;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.NNretrieval.NNScoringMethod;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.NNretrieval.similarity.global.Average;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.NNretrieval.similarity.local.Equal;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.NNretrieval.similarity.local.Interval;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.RetrievalResult;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.selection.SelectCases;
import org.springframework.stereotype.Component;

import java.util.*;

@Component
public class CbrApplication implements StandardCBRApplication {
    private final Connector connector;
    private CBRCaseBase caseBase;
    private NNConfig simConfig;

    public CbrApplication(CsvConnector connector) {
        this.connector = connector;
    }

    @Override
    public void configure() throws ExecutionException {
        caseBase = new es.ucm.fdi.gaia.jcolibri.casebase.LinealCaseBase();
        simConfig = new NNConfig();
        simConfig.setDescriptionSimFunction(new Average());

        // Similarity for criminalOffense
        TabularSimilarity criminalOffenseSim = new TabularSimilarity(Arrays.asList(
                "cl. 220 st. 1", "cl. 220 st. 2", "cl. 220 st. 3", "cl. 220 st. 5"
        ));
        criminalOffenseSim.setSimilarity("cl. 220 st. 1", "cl. 220 st. 1", 1.0);
        criminalOffenseSim.setSimilarity("cl. 220 st. 1", "cl. 220 st. 2", 0.8);
        criminalOffenseSim.setSimilarity("cl. 220 st. 1", "cl. 220 st. 3", 0.6);
        criminalOffenseSim.setSimilarity("cl. 220 st. 1", "cl. 220 st. 5", 0.4);
        criminalOffenseSim.setSimilarity("cl. 220 st. 2", "cl. 220 st. 2", 1.0);
        criminalOffenseSim.setSimilarity("cl. 220 st. 2", "cl. 220 st. 3", 0.8);
        criminalOffenseSim.setSimilarity("cl. 220 st. 2", "cl. 220 st. 5", 0.6);
        criminalOffenseSim.setSimilarity("cl. 220 st. 3", "cl. 220 st. 3", 1.0);
        criminalOffenseSim.setSimilarity("cl. 220 st. 3", "cl. 220 st. 5", 0.8);
        criminalOffenseSim.setSimilarity("cl. 220 st. 5", "cl. 220 st. 5", 1.0);
        simConfig.addMapping(new Attribute("criminalOffense", CaseDescription.class), criminalOffenseSim);

        // Similarity for verdict
        TabularSimilarity verdictSim = new TabularSimilarity(Arrays.asList(
                VerdictType.PRISON.name(), VerdictType.SUSPENDED.name(), VerdictType.ACQUITTED.name(), VerdictType.DETENTION.name()
        ));
        Map<String, Integer> verdictOrder = Map.of(
                "PRISON", 0, "SUSPENDED", 1, "ACQUITTED", 2, "DETENTION", 3
        );
        for (String v1 : verdictOrder.keySet()) {
            for (String v2 : verdictOrder.keySet()) {
                if (v1.equals(v2)) {
                    verdictSim.setSimilarity(v1, v2, 1.0);
                } else {
                    int dist = Math.abs(verdictOrder.get(v1) - verdictOrder.get(v2));
                    double similarity = 1.0 - (dist / 3.0);
                    verdictSim.setSimilarity(v1, v2, similarity);
                }
            }
        }
        simConfig.addMapping(new Attribute("verdict", CaseDescription.class), verdictSim);

        // Similarity for injuryTypes
        TabularSimilarity injurySim = new TabularSimilarity(Arrays.asList("light", "severe", "light,severe", ""));
        injurySim.setSimilarity("light", "light", 1.0);
        injurySim.setSimilarity("light", "severe", 0.5);
        injurySim.setSimilarity("light", "light,severe", 0.7);
        injurySim.setSimilarity("light", "", 0.2);
        injurySim.setSimilarity("severe", "severe", 1.0);
        injurySim.setSimilarity("severe", "light,severe", 0.7);
        injurySim.setSimilarity("severe", "", 0.2);
        injurySim.setSimilarity("light,severe", "light,severe", 1.0);
        injurySim.setSimilarity("light,severe", "", 0.2);
        injurySim.setSimilarity("", "", 1.0);
        simConfig.addMapping(new Attribute("injuryTypes", CaseDescription.class), injurySim);

        // Similarity for violenceNature
        TabularSimilarity violenceSim = new TabularSimilarity(Arrays.asList("rough violence", "threat", "arrogant and reckless behavior", ""));
        violenceSim.setSimilarity("rough violence", "rough violence", 1.0);
        violenceSim.setSimilarity("rough violence", "threat", 0.7);
        violenceSim.setSimilarity("rough violence", "arrogant and reckless behavior", 0.6);
        violenceSim.setSimilarity("rough violence", "", 0.2);
        violenceSim.setSimilarity("threat", "threat", 1.0);
        violenceSim.setSimilarity("threat", "arrogant and reckless behavior", 0.5);
        violenceSim.setSimilarity("threat", "", 0.2);
        violenceSim.setSimilarity("arrogant and reckless behavior", "arrogant and reckless behavior", 1.0);
        violenceSim.setSimilarity("arrogant and reckless behavior", "", 0.2);
        violenceSim.setSimilarity("", "", 1.0);
        simConfig.addMapping(new Attribute("violenceNature", CaseDescription.class), violenceSim);

        // Similarity for victimRelationship
        TabularSimilarity relationshipSim = new TabularSimilarity(Arrays.asList("spouse", "parent", "sibling", "child", "other", ""));
        relationshipSim.setSimilarity("spouse", "spouse", 1.0);
        relationshipSim.setSimilarity("spouse", "parent", 0.4);
        relationshipSim.setSimilarity("spouse", "sibling", 0.3);
        relationshipSim.setSimilarity("spouse", "child", 0.5);
        relationshipSim.setSimilarity("spouse", "other", 0.1);
        relationshipSim.setSimilarity("spouse", "", 0.2);
        relationshipSim.setSimilarity("parent", "parent", 1.0);
        relationshipSim.setSimilarity("parent", "sibling", 0.7);
        relationshipSim.setSimilarity("parent", "child", 0.8);
        relationshipSim.setSimilarity("parent", "other", 0.1);
        relationshipSim.setSimilarity("parent", "", 0.2);
        relationshipSim.setSimilarity("sibling", "sibling", 1.0);
        relationshipSim.setSimilarity("sibling", "child", 0.6);
        relationshipSim.setSimilarity("sibling", "other", 0.1);
        relationshipSim.setSimilarity("sibling", "", 0.2);
        relationshipSim.setSimilarity("child", "child", 1.0);
        relationshipSim.setSimilarity("child", "other", 0.1);
        relationshipSim.setSimilarity("child", "", 0.2);
        relationshipSim.setSimilarity("other", "other", 1.0);
        relationshipSim.setSimilarity("other", "", 0.2);
        relationshipSim.setSimilarity("", "", 1.0);
        simConfig.addMapping(new Attribute("victimRelationship", CaseDescription.class), relationshipSim);

        // Similarity for executionMeans
        TabularSimilarity executionSim = new TabularSimilarity(Arrays.asList("hands", "feet", "weapon", "tool", "verbal", "other", ""));
        executionSim.setSimilarity("hands", "hands", 1.0);
        executionSim.setSimilarity("hands", "feet", 0.8);
        executionSim.setSimilarity("hands", "weapon", 0.5);
        executionSim.setSimilarity("hands", "tool", 0.6);
        executionSim.setSimilarity("hands", "verbal", 0.2);
        executionSim.setSimilarity("hands", "other", 0.1);
        executionSim.setSimilarity("hands", "", 0.2);
        executionSim.setSimilarity("feet", "feet", 1.0);
        executionSim.setSimilarity("feet", "weapon", 0.4);
        executionSim.setSimilarity("feet", "tool", 0.5);
        executionSim.setSimilarity("feet", "verbal", 0.1);
        executionSim.setSimilarity("feet", "other", 0.1);
        executionSim.setSimilarity("feet", "", 0.2);
        executionSim.setSimilarity("weapon", "weapon", 1.0);
        executionSim.setSimilarity("weapon", "tool", 0.9);
        executionSim.setSimilarity("weapon", "verbal", 0.1);
        executionSim.setSimilarity("weapon", "other", 0.2);
        executionSim.setSimilarity("weapon", "", 0.2);
        executionSim.setSimilarity("tool", "tool", 1.0);
        executionSim.setSimilarity("tool", "verbal", 0.1);
        executionSim.setSimilarity("tool", "other", 0.2);
        executionSim.setSimilarity("tool", "", 0.2);
        executionSim.setSimilarity("verbal", "verbal", 1.0);
        executionSim.setSimilarity("verbal", "other", 0.3);
        executionSim.setSimilarity("verbal", "", 0.2);
        executionSim.setSimilarity("other", "other", 1.0);
        executionSim.setSimilarity("other", "", 0.2);
        executionSim.setSimilarity("", "", 1.0);
        simConfig.addMapping(new Attribute("executionMeans", CaseDescription.class), executionSim);

        // Numeric fields
        simConfig.addMapping(new Attribute("numDefendants", CaseDescription.class), new NullAwareInterval(5));
        simConfig.addMapping(new Attribute("numberOfVictims", CaseDescription.class), new NullAwareInterval(5));
        simConfig.addMapping(new Attribute("defendantAge", CaseDescription.class), new NullAwareInterval(100));
        simConfig.addMapping(new Attribute("victimAge", CaseDescription.class), new NullAwareInterval(100));

        // Boolean fields
        TabularSimilarity boolSim = new TabularSimilarity(Arrays.asList("true", "false"));
        boolSim.setSimilarity("true", "true", 1.0);
        boolSim.setSimilarity("true", "false", 0.0);
        boolSim.setSimilarity("false", "false", 1.0);
        simConfig.addMapping(new Attribute("previouslyConvicted", CaseDescription.class), new Equal());
        simConfig.addMapping(new Attribute("awareOfIllegality", CaseDescription.class), new Equal());
        simConfig.addMapping(new Attribute("protectionMeasureViolation", CaseDescription.class), new Equal());
        simConfig.addMapping(new Attribute("alcoholOrDrugs", CaseDescription.class), new Equal());
        simConfig.addMapping(new Attribute("childrenPresent", CaseDescription.class), new Equal());
        simConfig.addMapping(new Attribute("useOfWeapon", CaseDescription.class), new Equal());
    }

    @Override
    public CBRCaseBase preCycle() throws ExecutionException {
        caseBase.init(connector);
        return caseBase;
    }

    @Override
    public void cycle(CBRQuery query) throws ExecutionException {
        Collection<RetrievalResult> eval = NNScoringMethod.evaluateSimilarity(caseBase.getCases(), query, simConfig);
        eval = SelectCases.selectTopKRR(eval, 5);
        System.out.println("Retrieved cases:");
        for (RetrievalResult nse : eval) {
            System.out.println(nse.get_case().getDescription() + " -> " + nse.getEval());
        }
    }

    @Override
    public void postCycle() throws ExecutionException {}

    public List<SimilarVerdict> getSimilarCases(CBRQuery query) throws ExecutionException {
        List<SimilarVerdict> results = new ArrayList<>();
        Collection<RetrievalResult> eval = NNScoringMethod.evaluateSimilarity(caseBase.getCases(), query, simConfig);
        eval = SelectCases.selectTopKRR(eval, 5);
        for (RetrievalResult nse : eval) {
            SimilarVerdict sv = new SimilarVerdict((CaseDescription) nse.get_case().getDescription());
            sv.setSimilarity(nse.getEval());
            results.add(sv);
        }
        return results;
    }

    public static List<SimilarVerdict> findSimilarJudgements(CaseDescription queryCase, StandardCBRApplication recommender) {
        try {
            recommender.configure();
            recommender.preCycle();
            CBRQuery query = new CBRQuery();
            query.setDescription(queryCase);
            List<SimilarVerdict> results = ((CbrApplication) recommender).getSimilarCases(query);
            recommender.postCycle();
            return results;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
}