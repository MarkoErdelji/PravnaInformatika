package com.pravnainfo.judgingapp.service;

import com.openai.client.OpenAIClient;
import com.openai.client.okhttp.OpenAIOkHttpClient;
import com.openai.models.chat.completions.ChatCompletion;
import com.openai.models.chat.completions.ChatCompletionCreateParams;
import com.pravnainfo.judgingapp.entity.Verdict;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

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

        String prompt = buildSmartPrompt(verdict, examples, defendantNamesStr, accusationsStr);

        ChatCompletionCreateParams params = ChatCompletionCreateParams.builder()
                .model("gpt-4o")
                .addSystemMessage(prompt)
                .temperature(0.7)
                .build();

        ChatCompletion response = client.chat().completions().create(params);

        String result = response.choices().get(0).message().content().orElse("");

        return cleanXmlResponse(result);
    }

    private String buildSmartPrompt(Verdict verdict, List<String> examples,
                                    String defendantNamesStr, String accusationsStr) {
        return """
            You are a legal XML specialist that generates strictly factual Akoma Ntoso XML for legal verdicts.

            CRITICAL CONSTRAINTS:
            1. USE ONLY THE PROVIDED DATA - DO NOT INVENT ANY INFORMATION
            2. Never add things unless explicitly provided
            3. Do not infer relationships between fields (e.g., valueOfStolenItems ≠ punishment amount)
            4. Stick strictly to the provided field meanings
            5. You have to estimate the punishment amount yourself
            
            FIELD USAGE GUIDE:
            - appliedProvisions: Use exactly as provided for legal references
            - Boolean flags (isMovableProperty, isTaken, etc.): Use for factual circumstances only

            STRUCTURE RULES:
            - Include only elements that have actual data
            - Maintain Akoma Ntoso schema compliance
            = Format sentences to make sense in line with an actual judgement, be creative here.
            
            Examples of valid structure:
            """ + String.join("\n\n", examples) + """

            Now generate Akoma Ntoso XML for this exact case:

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
            - factualCircumstances: [isMovableProperty: %s, isTaken: %s, intentToAppropriate: %s, valueOfStolenItems: %s, isCulturalOrNaturalGood: %s, breakingAndEntering: %s, particularlyDangerousOrBrazen: %s, exploitingHelplessness: %s, duringDisaster: %s, numberOfPerpetrators: %s, isArmed: %s, useOfForceOrThreat: %s, caughtInTheAct: %s, causedSevereInjury: %s, deathCaused: %s, attemptedCrime: %s]
            - xmlFileName: %s

            REMEMBER: Only include what's explicitly provided. No invented data.
            Output only the valid Akoma Ntoso XML without explanations.
            """.formatted(
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
                safeBoolean(verdict.getIsCulturalOrNaturalGood(), false),
                safeBoolean(verdict.getBreakingAndEntering(), false),
                safeBoolean(verdict.getParticularlyDangerousOrBrazen(), false),
                safeBoolean(verdict.getExploitingHelplessness(), false),
                safeBoolean(verdict.getDuringDisaster(), false),
                safeInteger(verdict.getNumberOfPerpetrators(), 1),
                safeBoolean(verdict.getIsArmed(), false),
                safeBoolean(verdict.getUseOfForceOrThreat(), false),
                safeBoolean(verdict.getCaughtInTheAct(), false),
                safeBoolean(verdict.getCausedSevereInjury(), false),
                safeBoolean(verdict.getDeathCaused(), false),
                safeBoolean(verdict.getAttemptedCrime(), false),
                safeString(verdict.getXmlFileName())
        );
    }

    private String cleanXmlResponse(String result) {
        if (result == null || result.trim().isEmpty()) {
            throw new IllegalStateException("AI returned empty response");
        }

        // Remove code blocks if present
        result = result.replaceFirst("^```xml\\s*", "");
        result = result.replaceFirst("```$", "");

        // Basic validation
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

    private String safeInteger(Integer value, int defaultValue) {
        return value != null ? String.valueOf(value) : String.valueOf(defaultValue);
    }

    private String safeDouble(Double value, double defaultValue) {
        return value != null ? String.valueOf(value) : String.valueOf(defaultValue);
    }
}