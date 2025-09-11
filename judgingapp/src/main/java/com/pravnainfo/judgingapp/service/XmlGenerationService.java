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
                "- caseId: " + safeString(verdict.getCaseId()) + "\n" +
                "- court: " + safeString(verdict.getCourt()) + "\n" +
                "- verdictNumber: " + safeString(verdict.getVerdictNumber()) + "\n" +
                "- date: " + safeString(verdict.getDate()) + "\n" +
                "- judgeName: " + safeString(verdict.getJudgeName()) + "\n" +
                "- clerkName: " + safeString(verdict.getClerkName()) + "\n" +
                "- prosecutor: " + safeString(verdict.getProsecutor()) + "\n" +
                "- defendantName: " + safeString(verdict.getDefendantName()) + "\n" +
                "- criminalOffense: " + safeString(verdict.getCriminalOffense()) + "\n" +
                "- appliedProvisions: " + safeString(verdict.getAppliedProvisions()) + "\n" +
                "- verdictType: " + safeEnum(verdict.getVerdictType()) + "\n" +
                "- awareOfIllegality: " + safeBoolean(verdict.getAwareOfIllegality(), true) + "\n" +
                "- mainVictimRelationship: " + safeEnum(verdict.getMainVictimRelationship()) + "\n" +
                "- violenceNature: " + safeEnum(verdict.getViolenceNature()) + "\n" +
                "- injuryTypes: " + safeEnum(verdict.getInjuryTypes()) + "\n" +
                "- protectionMeasureViolation: " + safeBoolean(verdict.getProtectionMeasureViolation(), false) + "\n" +
                "- eventLocation: " + safeString(verdict.getEventLocation()) + "\n" +
                "- eventDate: " + safeString(verdict.getEventDate()) + "\n" +
                "- defendantStatus: " + safeString(verdict.getDefendantStatus()) + "\n" +
                "- victims: " + safeString(verdict.getVictims()) + "\n" +
                "- mainVictimAge: " + safeInteger(verdict.getMainVictimAge(), 0) + "\n" +
                "- alcoholOrDrugs: " + safeBoolean(verdict.getAlcoholOrDrugs(), false) + "\n" +
                "- childrenPresent: " + safeBoolean(verdict.getChildrenPresent(), false) + "\n" +
                "- penalty: " + safeString(verdict.getPenalty()) + "\n" +
                "- procedureCosts: " + safeString(verdict.getProcedureCosts()) + "\n" +
                "- useOfWeapon: " + safeBoolean(verdict.getUseOfWeapon(), false) + "\n" +
                "- numberOfVictims: " + safeInteger(verdict.getNumberOfVictims(), 0) + "\n" +
                "- xmlFileName: " + safeString(verdict.getXmlFileName()) + "\n\n" +
                "Output only the generated XML.";

        ChatCompletionCreateParams params = ChatCompletionCreateParams.builder()
                .model("gpt-5")
                .addSystemMessage(prompt)
                .temperature(1.0)
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

    private String safeString(Object value) {
        return value != null ? value.toString() : "";
    }

    private String safeEnum(Enum<?> value) {
        return value != null ? value.name() : "";
    }

    private String safeBoolean(Boolean value, boolean defaultValue) {
        return value != null ? value.toString() : String.valueOf(defaultValue);
    }

    private String safeInteger(Integer value, int defaultValue) {
        return value != null ? value.toString() : String.valueOf(defaultValue);
    }
}