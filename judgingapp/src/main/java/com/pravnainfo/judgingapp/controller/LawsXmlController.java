package com.pravnainfo.judgingapp.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;

@RestController
@RequestMapping("/api/laws")
public class LawsXmlController {

    @GetMapping(value = "/zkp", produces = MediaType.APPLICATION_XML_VALUE)
    public ResponseEntity<String> getZkpXml() {
        File xmlFile = new File("./laws/zakon_o_krivicnom_postupku.xml");
        if (!xmlFile.exists()) {
            return ResponseEntity.notFound().build();
        }

        try {
            String xmlContent = new String(Files.readAllBytes(xmlFile.toPath()), StandardCharsets.UTF_8);
            return ResponseEntity.ok(xmlContent);
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error reading XML file");
        }
    }

    @GetMapping(value = "/krivicni", produces = MediaType.APPLICATION_XML_VALUE)
    public ResponseEntity<String> getKrivicniXml() {
        File xmlFile = new File("./laws/krivicni_zakonik.xml");
        if (!xmlFile.exists()) {
            return ResponseEntity.notFound().build();
        }

        try {
            String xmlContent = new String(Files.readAllBytes(xmlFile.toPath()), StandardCharsets.UTF_8);
            return ResponseEntity.ok(xmlContent);
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error reading XML file");
        }
    }
}