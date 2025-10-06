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

        String defendantNamesStr = verdict.getDefendantNames() != null
                ? String.join(", ", verdict.getDefendantNames())
                : "";
        String accusationsStr = verdict.getAccusations() != null
                ? String.join("; ", verdict.getAccusations())
                : "";

        String prompt = buildCreativePrompt(verdict, examples, defendantNamesStr, accusationsStr);

        ChatCompletionCreateParams params = ChatCompletionCreateParams.builder()
                .model("gpt-4o")
                .addSystemMessage(prompt)
                .temperature(0.4)
                .build();

        ChatCompletion response = client.chat().completions().create(params);

        String result = response.choices().get(0).message().content().orElse("");

        return cleanXmlResponse(result);
    }

    private String buildCreativePrompt(Verdict verdict, List<String> examples,
                                       String defendantNamesStr, String accusationsStr) {
        return """
            You are an expert legal document drafter specializing in Akoma Ntoso XML for Montenegrin court verdicts. Your task is to generate a precise, legally compliant XML document that is engaging, natural, and varied in its narrative style, using Montenegrin legal terminology, while strictly adhering to the provided case data.

            CRITICAL CONSTRAINTS:
            1. USE ONLY THE PROVIDED DATA - DO NOT INVENT ANY INFORMATION.
            2. Never infer or add details (e.g., relationships between fields like valueOfStolenItems and punishment amount).
            3. Use provided field values exactly as given (e.g., appliedProvisions, monetaryPenalty, prisonPenalty).
            4. If monetaryPenalty or prisonPenalty are provided, use them as the exact punishment amounts in the judgment. If not provided, estimate penalties within the legal range of the accusation (e.g., čl. 239 st. 1: fine or up to 3 years; čl. 240 st. 1: 1–7 years; čl. 241 st. 4: 2–10 years).
            5. Boolean flags (isMovableProperty, isTaken, etc.) describe factual circumstances only.

            STYLE GUIDELINES:
            - Craft natural, varied, and contextually rich narrative text using formal Montenegrin legal language.
            - Ensure the narrative reflects the case's context (e.g., theft, aggravated theft, robbery) and aligns with the shortDescription.
            - Use varied sentence structures to describe the act, avoiding repetitive phrasing, while keeping the tone authoritative and precise.
            - Include all relevant legal references (appliedProvisions, accusations) in the appropriate XML elements.
            - Format dates as DD.MM.YYYY for Montenegrin conventions.

            STRUCTURE RULES:
            - Generate valid Akoma Ntoso XML compliant with the schema.
            
            EXAMPLES OF VALID STRUCTURE:
            %s

            CASE DATA (USE ONLY THIS):
            - caseId: %s
            - court: %s
            - caseNumber: %s
            - verdictDate: %s
            - judge: %s
            - clerk: %s
            - prosecutor: %s
            - defendantNames: %s
            - victim: %s
            - shortDescription: %s
            - judgment: %s
            - appliedProvisions: %s
            - accusations: %s
            - factualCircumstances: [isMovableProperty: %s, isTaken: %s, intentToAppropriate: %s, valueOfStolenItems: %s, breakingAndEntering: %s, useOfForceOrThreat: %s, caughtInTheAct: %s, causedSevereInjury: %s, deathCaused: %s]
            - monetaryPenalty: %s
            - prisonPenalty: %s
            - xmlFileName: %s

            OUTPUT: Generate only the Akoma Ntoso XML without explanations or additional text.
            """.formatted(
                String.join("\n\n", examples),
                safeString(verdict.getCaseId()),
                safeString(verdict.getCourt()),
                safeString(verdict.getCaseNumber()),
                safeString(verdict.getVerdictDate()),
                safeString(verdict.getJudge()),
                safeString(verdict.getClerk()),
                safeString(verdict.getProsecutor()),
                safeString(defendantNamesStr),
                safeString(verdict.getVictim()),
                safeString(verdict.getShortDescription()),
                safeString(verdict.getJudgment()),
                safeString(verdict.getAppliedProvisions()),
                safeString(accusationsStr),
                safeBoolean(verdict.getIsMovableProperty(), false),
                safeBoolean(verdict.getIsTaken(), false),
                safeBoolean(verdict.getIntentToAppropriate(), false),
                safeDouble(verdict.getValueOfStolenItems(), 0.0),
                safeBoolean(verdict.getBreakingAndEntering(), false),
                safeBoolean(verdict.getUseOfForceOrThreat(), false),
                safeBoolean(verdict.getCaughtInTheAct(), false),
                safeBoolean(verdict.getCausedSevereInjury(), false),
                safeBoolean(verdict.getDeathCaused(), false),
                safeDouble(verdict.getMonetaryPenalty()),
                safeDouble(verdict.getPrisonPenalty()),
                safeString(verdict.getXmlFileName())
        );
    }

    private String cleanXmlResponse(String result) {
        if (result == null || result.trim().isEmpty()) {
            throw new IllegalStateException("AI returned empty response");
        }

        result = result.replaceFirst("^```xml\\s*", "");
        result = result.replaceFirst("```$", "");

        if (!result.trim().startsWith("<") || !result.contains("akomaNtoso")) {
            throw new IllegalStateException("AI returned invalid XML format");
        }

        return result.trim();
    }

    private String safeString(Object value) {
        return value != null ? value.toString() : "";
    }

    private String safeBoolean(Boolean value, boolean defaultValue) {
        return value != null ? String.valueOf(value) : String.valueOf(defaultValue);
    }

    private String safeDouble(Double value, double defaultValue) {
        return value != null ? String.valueOf(value) : String.valueOf(defaultValue);
    }

    private String safeDouble(Double value) {
        return value != null ? String.valueOf(value) : "";
    }
}