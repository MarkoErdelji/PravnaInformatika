package com.pravnainfo.judgingapp.cbr;

import com.pravnainfo.judgingapp.dto.CaseDescription;
import com.pravnainfo.judgingapp.dto.SimilarVerdict;
import com.pravnainfo.judgingapp.entity.VerdictType;
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

    private final CsvConnector connector;
    private CBRCaseBase caseBase;
    private NNConfig predictConfig;
    private NNConfig retrievalConfig;

    public CbrApplication(CsvConnector connector) {
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

        // Boolean similarity
        config.addMapping(new Attribute("previouslyConvicted", CaseDescription.class), new Equal());
        config.addMapping(new Attribute("awareOfIllegality", CaseDescription.class), new Equal());
        config.addMapping(new Attribute("protectionMeasureViolation", CaseDescription.class), new Equal());
        config.addMapping(new Attribute("alcoholOrDrugs", CaseDescription.class), new Equal());
        config.addMapping(new Attribute("childrenPresent", CaseDescription.class), new Equal());
        config.addMapping(new Attribute("useOfWeapon", CaseDescription.class), new Equal());

        // Numeric similarity
        config.addMapping(new Attribute("numDefendants", CaseDescription.class), new NullAwareInterval(5));
        config.addMapping(new Attribute("numberOfVictims", CaseDescription.class), new NullAwareInterval(5));
        config.addMapping(new Attribute("defendantAge", CaseDescription.class), new NullAwareInterval(100));
        config.addMapping(new Attribute("victimAge", CaseDescription.class), new NullAwareInterval(100));

        // Categorical similarity (you can expand)
        if (includeVerdict) {
            List<String> verdicts = Arrays.asList("PRISON","SUSPENDED","ACQUITTED","DETENTION");
            TabularSimilarity verdictSim = new TabularSimilarity(verdicts);
            for(String v1 : verdicts) {
                for(String v2 : verdicts) {
                    verdictSim.setSimilarity(v1,v2, v1.equals(v2)?1.0:0.5);
                }
            }
            config.addMapping(new Attribute("verdict", CaseDescription.class), verdictSim);
        }

        return config;
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
