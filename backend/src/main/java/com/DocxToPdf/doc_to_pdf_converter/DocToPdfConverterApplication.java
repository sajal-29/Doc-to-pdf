package com.DocxToPdf.doc_to_pdf_converter;

import com.DocxToPdf.doc_to_pdf_converter.storage.StorageProperties;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.amqp.rabbit.annotation.EnableRabbit;
import org.springframework.scheduling.annotation.EnableAsync;

@SpringBootApplication
@EnableConfigurationProperties(StorageProperties.class)
@EnableRabbit // Enable RabbitMQ messaging
@EnableAsync // Enable asynchronous processing
public class DocToPdfConverterApplication {
    public static void main(String[] args) {
        SpringApplication.run(DocToPdfConverterApplication.class, args);
    }
}