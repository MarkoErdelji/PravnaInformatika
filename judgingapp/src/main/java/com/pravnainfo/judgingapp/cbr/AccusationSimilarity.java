package com.pravnainfo.judgingapp.cbr;

import com.pravnainfo.judgingapp.entity.AccusationType;
import es.ucm.fdi.gaia.jcolibri.exception.NoApplicableSimilarityFunctionException;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.NNretrieval.similarity.LocalSimilarityFunction;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class AccusationSimilarity implements LocalSimilarityFunction {

    private TabularSimilarity tabular;

    public AccusationSimilarity() {
        List<String> categories = Arrays.stream(AccusationType.values()).map(Enum::name).toList();
        tabular = new TabularSimilarity(categories);
        for (String a1 : tabular.getCategories()) {
            for (String a2 : tabular.getCategories()) {
                double sim;
                AccusationType t1 = AccusationType.valueOf(a1);
                AccusationType t2 = AccusationType.valueOf(a2);
                if (a1.equals(a2)) {
                    sim = 1.0;
                } else if (t1.getArticle().equals(t2.getArticle())) {
                    sim = 0.9;
                } else if ((t1.getArticle().equals("239") && t2.getArticle().equals("240")) ||
                        (t1.getArticle().equals("240") && t2.getArticle().equals("239"))) {
                    sim = 0.7;
                } else if ((t1.getArticle().equals("240") && t2.getArticle().equals("241")) ||
                        (t1.getArticle().equals("241") && t2.getArticle().equals("240"))) {
                    sim = 0.6;
                } else if ((t1.getArticle().equals("239") && t2.getArticle().equals("241")) ||
                        (t1.getArticle().equals("241") && t2.getArticle().equals("239"))) {
                    sim = 0.5;
                } else {
                    sim = 0.2;
                }
                tabular.setSimilarity(a1, a2, sim);
            }
        }
    }

    @Override
    public double compute(Object o1, Object o2) throws NoApplicableSimilarityFunctionException {
        if (!(o1 instanceof List<?> && o2 instanceof List<?>)) {
            throw new NoApplicableSimilarityFunctionException("Expected List<AccusationType>");
        }
        List<AccusationType> l1 = (List<AccusationType>) o1;
        List<AccusationType> l2 = (List<AccusationType>) o2;
        List<String> s1 = l1.stream().map(Enum::name).collect(Collectors.toList());
        List<String> s2 = l2.stream().map(Enum::name).collect(Collectors.toList());
        return tabular.compute(s1, s2);
    }

    @Override
    public boolean isApplicable(Object o1, Object o2) {
        return o1 instanceof List<?> && o2 instanceof List<?> &&
                ((List<?>) o1).stream().allMatch(e -> e instanceof AccusationType) &&
                ((List<?>) o2).stream().allMatch(e -> e instanceof AccusationType);
    }
}