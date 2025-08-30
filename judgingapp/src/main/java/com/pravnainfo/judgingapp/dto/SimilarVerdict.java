package com.pravnainfo.judgingapp.dto;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class SimilarVerdict {
    private CaseDescription caseDescription;
    private double similarity;

    public SimilarVerdict(CaseDescription caseDescription) {
        this.caseDescription = caseDescription;
    }
}