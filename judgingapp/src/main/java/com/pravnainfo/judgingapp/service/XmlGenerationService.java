package com.pravnainfo.judgingapp.service;

import com.openai.client.OpenAIClient;
import com.openai.client.okhttp.OpenAIOkHttpClient;
import com.openai.models.chat.completions.ChatCompletion;
import com.openai.models.chat.completions.ChatCompletionCreateParams;
import com.pravnainfo.judgingapp.entity.Verdict;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class XmlGenerationService {

    @Value("${openai.api.key}")
    private String openAiApiKey;

    public String generateAkomaNtosoXml(Verdict verdict, List<String> examples) {
        OpenAIClient client = OpenAIOkHttpClient.builder()
                .apiKey(openAiApiKey)
                .build();

        String prompt = "You are an expert in generating Akoma Ntoso XML for legal verdicts based on given examples.\n\n" +
                "Examples:\n" + String.join("\n\n", examples) + "\n\n" +
                "Now, generate an Akoma Ntoso XML for the following Verdict parameters:\n" +
                "- caseId: " + verdict.getCaseId() + "\n" +
                "- court: " + verdict.getCourt() + "\n" +
                "- date: " + verdict.getDate() + "\n" +
                "- judgeName: " + verdict.getJudgeName() + "\n" +
                "- prosecutor: " + verdict.getProsecutor() + "\n" +
                "- defendantName: " + verdict.getDefendantName() + "\n" +
                "- criminalOffense: " + verdict.getCriminalOffense() + "\n" +
                "- appliedProvisions: " + verdict.getAppliedProvisions() + "\n" +
                "- verdict: " + verdict.getVerdict() + "\n" +
                "- numDefendants: " + verdict.getNumDefendants() + "\n" +
                "- previouslyConvicted: " + verdict.getPreviouslyConvicted() + "\n" +
                "- awareOfIllegality: " + verdict.getAwareOfIllegality() + "\n" +
                "- victimRelationship: " + verdict.getVictimRelationship() + "\n" +
                "- violenceNature: " + verdict.getViolenceNature() + "\n" +
                "- injuryTypes: " + verdict.getInjuryTypes() + "\n" +
                "- executionMeans: " + verdict.getExecutionMeans() + "\n" +
                "- protectionMeasureViolation: " + verdict.getProtectionMeasureViolation() + "\n" +
                "- eventLocation: " + verdict.getEventLocation() + "\n" +
                "- eventDate: " + verdict.getEventDate() + "\n" +
                "- defendantStatus: " + verdict.getDefendantStatus() + "\n" +
                "- victims: " + verdict.getVictims() + "\n" +
                "- defendantAge: " + verdict.getDefendantAge() + "\n" +
                "- victimAge: " + verdict.getVictimAge() + "\n" +
                "- previousIncidents: " + verdict.getPreviousIncidents() + "\n" +
                "- alcoholOrDrugs: " + verdict.getAlcoholOrDrugs() + "\n" +
                "- childrenPresent: " + verdict.getChildrenPresent() + "\n" +
                "- penalty: " + verdict.getPenalty() + "\n" +
                "- procedureCosts: " + verdict.getProcedureCosts() + "\n" +
                "- useOfWeapon: " + verdict.getUseOfWeapon() + "\n" +
                "- numberOfVictims: " + verdict.getNumberOfVictims() + "\n\n" +
                "Output only the generated XML.";

        ChatCompletionCreateParams params = ChatCompletionCreateParams.builder()
                .model("gpt-4o-mini")
                .addSystemMessage(prompt)
                .temperature(0.0)
                .build();

        ChatCompletion response = client.chat().completions().create(params);

        String result = response.choices().get(0).message().content().orElse("");

        if (result.startsWith("```xml")) {
            result = result.replaceFirst("^```xml\\s*", "");
        }
        if (result.endsWith("```")) {
            result = result.replaceFirst("```$", "");
        }

        return result;
    }
}