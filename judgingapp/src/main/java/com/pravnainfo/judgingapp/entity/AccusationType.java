package com.pravnainfo.judgingapp.entity;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public enum AccusationType {
    ARTICLE_239_NONE("239", ""),
    ARTICLE_239_ST_1("239", "1"),
    ARTICLE_239_ST_2("239", "2"),
    ARTICLE_240_NONE("240", ""),
    ARTICLE_240_ST_1("240", "1"),
    ARTICLE_240_ST_2("240", "2"),
    ARTICLE_240_ST_3("240", "3"),
    ARTICLE_241_NONE("241", ""),
    ARTICLE_241_ST_1("241", "1"),
    ARTICLE_241_ST_2("241", "2"),
    ARTICLE_241_ST_3("241", "3"),
    ARTICLE_241_ST_4("241", "4"),
    ARTICLE_241_ST_5("241", "5"),
    ARTICLE_241_ST_6("241", "6"),
    ARTICLE_241_ST_7("241", "7"),
    OTHER("Other", "");

    private final String article;
    private final String stav;

    AccusationType(String article, String stav) {
        this.article = article;
        this.stav = stav;
    }

    public String getArticle() {
        return article;
    }

    public String getStav() {
        return stav;
    }

    public static AccusationType parse(String accusation) {
        if (accusation == null || accusation.trim().isEmpty()) {
            return OTHER;
        }

        String trimmed = accusation.trim().toLowerCase()
                .replace("čl.", "")
                .replace("cl.", "")
                .replace("tač.", "tač")
                .replace("tč.", "tač")
                .replace("tačka", "tač")
                .replace("stav ", "st. ")
                .replace("u vezi", "");

        // Pattern to match article and optional stav (e.g., "239 st. 1" or "240")
        Pattern pattern = Pattern.compile("(\\d+)\\s*(st\\.\\s*(\\d+))?\\s*(tač\\s*(\\d+))?\\s*");
        Matcher matcher = pattern.matcher(trimmed);

        if (!matcher.find()) {
            return OTHER;
        }

        String article = matcher.group(1);
        String stav = matcher.group(3) != null ? matcher.group(3) : "";
        String tač = matcher.group(5) != null ? matcher.group(5) : "";

        // Handle "tač" as equivalent to "st." for specific cases (e.g., 240 st. 1 tač 1)
        if (!tač.isEmpty()) {
            stav = tač;
        }

        return switch (article) {
            case "239" -> switch (stav) {
                case "1" -> ARTICLE_239_ST_1;
                case "2" -> ARTICLE_239_ST_2;
                default -> ARTICLE_239_NONE;
            };
            case "240" -> switch (stav) {
                case "1" -> ARTICLE_240_ST_1;
                case "2" -> ARTICLE_240_ST_2;
                case "3" -> ARTICLE_240_ST_3;
                default -> ARTICLE_240_NONE;
            };
            case "241" -> switch (stav) {
                case "1" -> ARTICLE_241_ST_1;
                case "2" -> ARTICLE_241_ST_2;
                case "3" -> ARTICLE_241_ST_3;
                case "4" -> ARTICLE_241_ST_4;
                case "5" -> ARTICLE_241_ST_5;
                case "6" -> ARTICLE_241_ST_6;
                case "7" -> ARTICLE_241_ST_7;
                default -> ARTICLE_241_NONE;
            };
            default -> OTHER;
        };
    }
}