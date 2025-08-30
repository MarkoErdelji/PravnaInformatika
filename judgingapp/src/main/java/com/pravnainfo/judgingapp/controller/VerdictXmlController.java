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

import java.io.IOException;
import java.nio.charset.StandardCharsets;

@RestController
@RequestMapping("/api/verdicts")
public class VerdictXmlController {

    @Autowired
    private IVerdictRepository verdictRepository;

    @GetMapping(value = "/{id}/xml", produces = MediaType.APPLICATION_XML_VALUE)
    public ResponseEntity<String> getVerdictXml(@PathVariable Long id) {
        Verdict verdict = verdictRepository.getReferenceById(id);

        try {
            // Load XML from resources
            ClassPathResource resource = new ClassPathResource("xml/" + verdict.getCaseId() + ".xml");
            if (!resource.exists()) {
                return ResponseEntity.notFound().build();
            }
            String xmlContent = new String(resource.getInputStream().readAllBytes(), StandardCharsets.UTF_8);

            // Optional: pretty print with a library like DOM or JAXB
            return ResponseEntity.ok(xmlContent);

        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error reading XML file");
        }
    }
}
