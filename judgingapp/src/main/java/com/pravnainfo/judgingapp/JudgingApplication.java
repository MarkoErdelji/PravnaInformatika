package com.pravnainfo.judgingapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EntityScan(basePackages = "com.pravnainfo.judgingapp.entity")
@EnableJpaRepositories(basePackages = "com.pravnainfo.judgingapp.repository")
public class JudgingApplication {

	public static void main(String[] args) {
		SpringApplication.run(JudgingApplication.class, args);
	}

}
