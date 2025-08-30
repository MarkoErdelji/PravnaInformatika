package com.pravnainfo.judgingapp.cbr;

import es.ucm.fdi.gaia.jcolibri.exception.NoApplicableSimilarityFunctionException;
import es.ucm.fdi.gaia.jcolibri.method.retrieve.NNretrieval.similarity.local.Interval;

public class NullAwareInterval extends Interval {
    public NullAwareInterval(double interval) {
        super(interval);
    }

    @Override
    public double compute(Object o1, Object o2) throws NoApplicableSimilarityFunctionException {
        if (o1 == null && o2 == null) {
            return 1.0;
        }
        if (o1 == null || o2 == null) {
            return 0.0;
        }
        return super.compute(o1, o2);
    }
}