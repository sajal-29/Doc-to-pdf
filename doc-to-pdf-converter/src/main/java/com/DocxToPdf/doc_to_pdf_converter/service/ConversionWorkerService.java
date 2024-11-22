package com.DocxToPdf.doc_to_pdf_converter.service;

import java.io.File;

import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Service;

import com.DocxToPdf.doc_to_pdf_converter.model.ConversionJob;
import com.DocxToPdf.doc_to_pdf_converter.model.JobStatus;

@Service
public class ConversionWorkerService {

    private final FileStorageService fileStorageService;
    private final JobStatusService jobStatusService;
    private final DocxToPdfService docxToPdfService;

    public ConversionWorkerService(FileStorageService fileStorageService,
            JobStatusService jobStatusService,
            DocxToPdfService docxToPdfService) {
        this.fileStorageService = fileStorageService;
        this.jobStatusService = jobStatusService;
        this.docxToPdfService = docxToPdfService;
    }

    @RabbitListener(queues = "${queue.conversion.name}")
    public void processConversion(ConversionJob job) {
        try {
            jobStatusService.updateStatus(job.getJobId(), JobStatus.PROCESSING);

            File inputFile = fileStorageService.retrieve(job.getFilePath());
            File outputFile = File.createTempFile("converted_", ".pdf");

            docxToPdfService.convertDocxToPdf(inputFile, outputFile.getAbsolutePath());

            String resultPath = fileStorageService.store(outputFile);
            jobStatusService.updateStatus(job.getJobId(), JobStatus.COMPLETED, resultPath);

            // Cleanup
            inputFile.delete();
            outputFile.delete();
        } catch (Exception e) {
            System.out.println("Failed to process conversion job: " + e.getMessage());
            jobStatusService.updateStatus(job.getJobId(), JobStatus.FAILED, e.getMessage());
        }
    }
}
