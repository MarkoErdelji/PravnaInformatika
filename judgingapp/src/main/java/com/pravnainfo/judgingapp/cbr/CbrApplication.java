package com.pravnainfo.judgingapp.cbr;

import com.pravnainfo.judgingapp.dto.CaseDescription;
import com.pravnainfo.judgingapp.dto.SimilarVerdict;
import com.pravnainfo.judgingapp.entity.*;
import es.ucm.fdi.gaia.jcolibri.cbraplications.StandardCBRApplication;
import es.ucm.fdi.gaia.jcolibri.cbrcore.*;
import es.ucm.fdi.gaia.jcolibri.exception.ExecutionException;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.NNretrieval.*;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.NNretrieval.similarity.global.Average;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.NNretrieval.similarity.local.Equal;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.RetrievalResult;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.selection.SelectCases;
import org.springframework.stereotype.Component;

import java.util.*;

@Component
public class CbrApplication implements StandardCBRApplication {

    private final DatabaseConnector connector;
    private CBRCaseBase caseBase;
    private NNConfig predictConfig;
    private NNConfig retrievalConfig;

    public CbrApplication(DatabaseConnector connector) {
        this.connector = connector;
    }

    @Override
    public void configure() throws ExecutionException {
        caseBase = new es.ucm.fdi.gaia.jcolibri.casebase.LinealCaseBase();
        predictConfig = createNNConfig(false);
        retrievalConfig = createNNConfig(true);
    }

    private NNConfig createNNConfig(boolean includeVerdict) {
        NNConfig config = new NNConfig();
        config.setDescriptionSimFunction(new Average());

        config.addMapping(new Attribute("previouslyConvicted", CaseDescription.class), new Equal());
        config.addMapping(new Attribute("awareOfIllegality", CaseDescription.class), new Equal());
        config.addMapping(new Attribute("protectionMeasureViolation", CaseDescription.class), new Equal());
        config.addMapping(new Attribute("alcoholOrDrugs", CaseDescription.class), new Equal());
        config.addMapping(new Attribute("childrenPresent", CaseDescription.class), new Equal());
        config.addMapping(new Attribute("useOfWeapon", CaseDescription.class), new Equal());

        config.addMapping(new Attribute("numDefendants", CaseDescription.class), new NullAwareInterval(5));
        config.addMapping(new Attribute("numberOfVictims", CaseDescription.class), new NullAwareInterval(5));
        config.addMapping(new Attribute("defendantAge", CaseDescription.class), new NullAwareInterval(100));
        config.addMapping(new Attribute("victimAge", CaseDescription.class), new NullAwareInterval(100));

        TabularSimilarity execSim = new TabularSimilarity(
                Arrays.stream(ExecutionMeans.values()).map(Enum::name).toList()
        );
        for (String m1 : execSim.getCategories()) {
            for (String m2 : execSim.getCategories()) {
                double sim = m1.equals(m2) ? 1.0 : 0.2;
                if ((m1.equals("HANDS") && m2.equals("FEET")) || (m1.equals("FEET") && m2.equals("HANDS"))) sim = 0.8;
                if ((m1.equals("WEAPON") && m2.equals("TOOL")) || (m1.equals("TOOL") && m2.equals("WEAPON"))) sim = 0.7;
                execSim.setSimilarity(m1, m2, sim);
            }
        }
        config.addMapping(new Attribute("executionMeans", CaseDescription.class), execSim);

        TabularSimilarity injurySim = new TabularSimilarity(
                Arrays.stream(InjuryTypes.values()).map(Enum::name).toList()
        );
        for (String i1 : injurySim.getCategories()) {
            for (String i2 : injurySim.getCategories()) {
                double sim = i1.equals(i2) ? 1.0 : 0.2;
                if (i1.contains("LIGHT") && i2.contains("LIGHT")) sim = 0.7;
                if (i1.contains("SEVERE") && i2.contains("SEVERE")) sim = 0.7;
                if (i1.equals("LIGHT_SEVERE") || i2.equals("LIGHT_SEVERE")) sim = 0.6;
                injurySim.setSimilarity(i1, i2, sim);
            }
        }
        config.addMapping(new Attribute("injuryTypes", CaseDescription.class), injurySim);

        TabularSimilarity relationSim = new TabularSimilarity(
                Arrays.stream(VictimRelationship.values()).map(Enum::name).toList()
        );
        for (String r1 : relationSim.getCategories()) {
            for (String r2 : relationSim.getCategories()) {
                double sim = r1.equals(r2) ? 1.0 : 0.1;
                if ((r1.equals("PARENT") && r2.equals("CHILD")) || (r1.equals("CHILD") && r2.equals("PARENT"))) sim = 0.7;
                if ((r1.equals("SIBLING") && r2.equals("SPOUSE")) || (r1.equals("SPOUSE") && r2.equals("SIBLING"))) sim = 0.5;
                relationSim.setSimilarity(r1, r2, sim);
            }
        }
        config.addMapping(new Attribute("victimRelationship", CaseDescription.class), relationSim);

        TabularSimilarity violenceSim = new TabularSimilarity(
                Arrays.stream(ViolenceNature.values()).map(Enum::name).toList()
        );
        for (String v1 : violenceSim.getCategories()) {
            for (String v2 : violenceSim.getCategories()) {
                double sim = v1.equals(v2) ? 1.0 : 0.2;
                if ((v1.equals("VIOLENCE") && v2.equals("THREAT")) || (v1.equals("THREAT") && v2.equals("VIOLENCE"))) sim = 0.6;
                if ((v1.equals("RECKLESS_BEHAVIOUR") && !v2.equals("NONE")) || (v2.equals("RECKLESS_BEHAVIOUR") && !v1.equals("NONE"))) sim = 0.5;
                violenceSim.setSimilarity(v1, v2, sim);
            }
        }
        config.addMapping(new Attribute("violenceNature", CaseDescription.class), violenceSim);

        if (includeVerdict) {
            TabularSimilarity verdictSim = new TabularSimilarity(
                    Arrays.stream(VerdictType.values()).map(Enum::name).toList()
            );
            for (String v1 : verdictSim.getCategories()) {
                for (String v2 : verdictSim.getCategories()) {
                    double sim = v1.equals(v2) ? 1.0 : 0.3;
                    if ((v1.equals("PRISON") && v2.equals("DETENTION")) || (v1.equals("DETENTION") && v2.equals("PRISON"))) sim = 0.6;
                    if ((v1.equals("SUSPENDED") && v2.equals("PRISON")) || (v1.equals("PRISON") && v2.equals("SUSPENDED"))) sim = 0.5;
                    verdictSim.setSimilarity(v1, v2, sim);
                }
            }
            config.addMapping(new Attribute("verdict", CaseDescription.class), verdictSim);
        }
        return config;
    }

    public void addAndPersistCase(CaseDescription newCase) throws ExecutionException {
        if (caseBase == null) throw new ExecutionException("CBR not initialized");

        CBRCase cbrCase = new CBRCase();
        cbrCase.setDescription(newCase);

        caseBase.getCases().add(cbrCase);

        connector.storeCases(List.of(cbrCase));
    }
    @Override
    public CBRCaseBase preCycle() throws ExecutionException {
        caseBase.init(connector);
        return caseBase;
    }

    @Override
    public void cycle(CBRQuery query) throws ExecutionException {
        Collection<RetrievalResult> eval = NNScoringMethod.evaluateSimilarity(caseBase.getCases(), query, retrievalConfig);
        eval = SelectCases.selectTopKRR(eval, 5);
    }

    @Override
    public void postCycle() throws ExecutionException {}

    public List<SimilarVerdict> getSimilarCases(CaseDescription queryCase) throws ExecutionException {
        CBRQuery query = new CBRQuery();
        query.setDescription(queryCase);
        Collection<RetrievalResult> eval = NNScoringMethod.evaluateSimilarity(caseBase.getCases(), query, retrievalConfig);
        eval = SelectCases.selectTopKRR(eval, 5);

        List<SimilarVerdict> results = new ArrayList<>();
        for (RetrievalResult r : eval) {
            SimilarVerdict sv = new SimilarVerdict((CaseDescription) r.get_case().getDescription());
            sv.setSimilarity(r.getEval());
            results.add(sv);
        }
        return results;
    }

    public List<SimilarVerdict> predictVerdict(CaseDescription queryCase) throws ExecutionException {
        CBRQuery query = new CBRQuery();
        query.setDescription(queryCase);
        Collection<RetrievalResult> eval = NNScoringMethod.evaluateSimilarity(caseBase.getCases(), query, predictConfig);
        eval = SelectCases.selectTopKRR(eval, 5);

        List<SimilarVerdict> results = new ArrayList<>();
        for (RetrievalResult r : eval) {
            SimilarVerdict sv = new SimilarVerdict((CaseDescription) r.get_case().getDescription());
            sv.setSimilarity(r.getEval());
            results.add(sv);
        }
        return results;
    }
}
