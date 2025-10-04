package com.pravnainfo.judgingapp.cbr;

import com.pravnainfo.judgingapp.dto.CaseDescription;
import com.pravnainfo.judgingapp.entity.*;
import com.pravnainfo.judgingapp.repository.IVerdictRepository;
import es.ucm.fdi.gaia.jcolibri.cbrcore.CBRCase;
import es.ucm.fdi.gaia.jcolibri.cbrcore.CaseBaseFilter;
import es.ucm.fdi.gaia.jcolibri.cbrcore.Connector;
import es.ucm.fdi.gaia.jcolibri.exception.InitializingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.net.URL;
import java.util.*;

@Component
public class DatabaseConnector implements Connector {

    @Autowired
    private IVerdictRepository verdictRepository;

    @Override
    public void initFromXMLfile(URL file) throws InitializingException {}

    @Override
    public Collection<CBRCase> retrieveAllCases() {
        List<Verdict> verdicts = verdictRepository.findAll();
        verdicts.forEach(verdict -> System.out.print(verdict.getCaseId() + " "));
        LinkedList<CBRCase> cases = new LinkedList<>();
        for (Verdict v : verdicts) {
            CBRCase cbrCase = new CBRCase();
            cbrCase.setDescription(new CaseDescription(v));
            cases.add(cbrCase);
        }
        return cases;
    }

    @Override
    public Collection<CBRCase> retrieveSomeCases(CaseBaseFilter filter) {
        return new LinkedList<>();
    }

    @Override
    public void storeCases(Collection<CBRCase> cases) {

    }

    @Override
    public void deleteCases(Collection<CBRCase> cases) {}

    @Override
    public void close() {}
}