package com.pravnainfo.judgingapp.controller;

import com.pravnainfo.judgingapp.entity.Verdict;
import com.pravnainfo.judgingapp.repository.IVerdictRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;

@RestController
@RequestMapping("/api/verdicts")
public class VerdictXmlController {

    @Autowired
    private IVerdictRepository verdictRepository;

    @GetMapping(value = "/{id}/xml", produces = MediaType.APPLICATION_XML_VALUE)
    public ResponseEntity<String> getVerdictXml(@PathVariable Long id) {
        Verdict verdict = verdictRepository.getReferenceById(id);

        if (verdict.getXmlFileName() == null || verdict.getXmlFileName().isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        // Use filesystem path instead of ClassPathResource
        File xmlFile = new File("./xml/", verdict.getXmlFileName());
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
