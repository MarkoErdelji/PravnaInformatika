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

    private NNConfig createNNConfig(boolean includeJudgment) {
        NNConfig config = new NNConfig();
        config.setDescriptionSimFunction(new Average());

        config.addMapping(new Attribute("isMovableProperty", CaseDescription.class), new Equal());
        config.addMapping(new Attribute("isTaken", CaseDescription.class), new Equal());
        config.addMapping(new Attribute("intentToAppropriate", CaseDescription.class), new Equal());
        config.addMapping(new Attribute("breakingAndEntering", CaseDescription.class), new Equal());
        config.addMapping(new Attribute("useOfForceOrThreat", CaseDescription.class), new Equal());
        config.addMapping(new Attribute("caughtInTheAct", CaseDescription.class), new Equal());
        config.addMapping(new Attribute("causedSevereInjury", CaseDescription.class), new Equal());
        config.addMapping(new Attribute("deathCaused", CaseDescription.class), new Equal());

        config.addMapping(new Attribute("valueOfStolenItems", CaseDescription.class), new NullAwareInterval(10000.0));

        config.addMapping(new Attribute("accusationTypes", CaseDescription.class), new AccusationSimilarity());
        config.setWeight(new Attribute("accusationTypes", CaseDescription.class), 1.2);

        if (includeJudgment) {
            TabularSimilarity judgmentSim = new TabularSimilarity(
                    Arrays.stream(VerdictType.values()).map(Enum::name).toList()
            );
            for (String v1 : judgmentSim.getCategories()) {
                for (String v2 : judgmentSim.getCategories()) {
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
                    } else if ((v1.equals("ACQUITTAL") && v2.equals("DISMISSAL")) ||
                            (v1.equals("DISMISSAL") && v2.equals("ACQUITTAL"))) {
                        sim = 0.8;
                    } else {
                        sim = 0.3;
                    }
                    judgmentSim.setSimilarity(v1, v2, sim);
                }
            }
            config.addMapping(new Attribute("judgment", CaseDescription.class), judgmentSim);
            config.addMapping(new Attribute("prisonPenalty", CaseDescription.class), new NullAwareInterval(10.0));
            config.addMapping(new Attribute("monetaryPenalty", CaseDescription.class), new NullAwareInterval(10000.0));
        }

        return config;
    }

    public void addAndPersistCase(CaseDescription newCase) throws ExecutionException {
        if (caseBase == null) throw new ExecutionException("CBR not initialized");

        CBRCase cbrCase = new CBRCase();
        cbrCase.setDescription(newCase);

        caseBase.getCases().add(cbrCase);
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