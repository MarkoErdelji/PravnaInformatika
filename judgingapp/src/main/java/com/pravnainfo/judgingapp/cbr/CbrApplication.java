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

        config.addMapping(new Attribute("awareOfIllegality", CaseDescription.class), new Equal());
        config.addMapping(new Attribute("protectionMeasureViolation", CaseDescription.class), new Equal());
        config.addMapping(new Attribute("alcoholOrDrugs", CaseDescription.class), new Equal());
        config.addMapping(new Attribute("childrenPresent", CaseDescription.class), new Equal());
        config.addMapping(new Attribute("useOfWeapon", CaseDescription.class), new Equal());

        config.addMapping(new Attribute("numberOfVictims", CaseDescription.class), new NullAwareInterval(5));
        config.addMapping(new Attribute("mainVictimAge", CaseDescription.class), new NullAwareInterval(100));

        // --- Injury similarity ---
        TabularSimilarity injurySim = new TabularSimilarity(
                Arrays.stream(InjuryTypes.values()).map(Enum::name).toList()
        );
        for (String i1 : injurySim.getCategories()) {
            for (String i2 : injurySim.getCategories()) {
                double sim;
                if (i1.equals(i2)) {
                    sim = 1.0;
                } else if ((i1.equals("MINOR") && i2.equals("SERIOUS")) || (i1.equals("SERIOUS") && i2.equals("MINOR"))) {
                    sim = 0.6; // minor vs serious
                } else if ((i1.equals("SERIOUS") && i2.equals("DEATH")) || (i1.equals("DEATH") && i2.equals("SERIOUS"))) {
                    sim = 0.7; // serious vs death
                } else {
                    sim = 0.2;
                }
                injurySim.setSimilarity(i1, i2, sim);
            }
        }
        config.addMapping(new Attribute("injuryTypes", CaseDescription.class), injurySim);

        // --- Victim relationship similarity ---
        TabularSimilarity relationSim = new TabularSimilarity(
                Arrays.stream(VictimRelationship.values()).map(Enum::name).toList()
        );
        for (String r1 : relationSim.getCategories()) {
            for (String r2 : relationSim.getCategories()) {
                double sim = r1.equals(r2) ? 1.0 : 0.2;
                if ((r1.equals("PARENT") && r2.equals("CHILD")) || (r1.equals("CHILD") && r2.equals("PARENT"))) sim = 0.7;
                if ((r1.equals("SPOUSE") && r2.equals("CHILD")) || (r1.equals("CHILD") && r2.equals("SPOUSE"))) sim = 0.5;
                relationSim.setSimilarity(r1, r2, sim);
            }
        }
        config.addMapping(new Attribute("mainVictimRelationship", CaseDescription.class), relationSim);

        // --- Violence similarity ---
        TabularSimilarity violenceSim = new TabularSimilarity(
                Arrays.stream(ViolenceNature.values()).map(Enum::name).toList()
        );
        for (String v1 : violenceSim.getCategories()) {
            for (String v2 : violenceSim.getCategories()) {
                double sim;
                if (v1.equals(v2)) {
                    sim = 1.0;
                } else if ((v1.equals("PHYSICAL") && v2.equals("PSYCHOLOGICAL")) ||
                        (v1.equals("PSYCHOLOGICAL") && v2.equals("PHYSICAL"))) {
                    sim = 0.5;
                } else {
                    sim = 0.0; // NONE vs others
                }
                violenceSim.setSimilarity(v1, v2, sim);
            }
        }
        config.addMapping(new Attribute("violenceNature", CaseDescription.class), violenceSim);

        // --- Verdict similarity (only for retrieval config) ---
        if (includeVerdict) {
            TabularSimilarity verdictSim = new TabularSimilarity(
                    Arrays.stream(VerdictType.values()).map(Enum::name).toList()
            );
            for (String v1 : verdictSim.getCategories()) {
                for (String v2 : verdictSim.getCategories()) {
                    double sim;
                    if (v1.equals(v2)) {
                        sim = 1.0;
                    } else if ((v1.equals("PRISON") && v2.equals("SUSPENDED")) ||
                            (v1.equals("SUSPENDED") && v2.equals("PRISON"))) {
                        sim = 0.6;
                    } else if ((v1.equals("PRISON") && v2.equals("FINE_AND_PRISON")) ||
                            (v1.equals("FINE_AND_PRISON") && v2.equals("PRISON"))) {
                        sim = 0.7;
                    } else if ((v1.equals("FINE") && v2.equals("FINE_AND_PRISON")) ||
                            (v1.equals("FINE_AND_PRISON") && v2.equals("FINE"))) {
                        sim = 0.7;
                    } else {
                        sim = 0.3;
                    }
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
