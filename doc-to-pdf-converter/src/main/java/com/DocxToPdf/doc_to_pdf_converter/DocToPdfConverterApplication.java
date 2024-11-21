package com.DocxToPdf.doc_to_pdf_converter;

import com.DocxToPdf.doc_to_pdf_converter.storage.StorageProperties;
import com.DocxToPdf.doc_to_pdf_converter.storage.StorageService;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
@EnableConfigurationProperties(StorageProperties.class)
public class DocToPdfConverterApplication {

	public static void main(String[] args) {
		SpringApplication.run(DocToPdfConverterApplication.class, args);
	}


}
