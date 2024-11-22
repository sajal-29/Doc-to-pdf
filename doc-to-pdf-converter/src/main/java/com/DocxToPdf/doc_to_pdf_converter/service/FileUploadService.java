package com.DocxToPdf.doc_to_pdf_converter.service;

import com.DocxToPdf.doc_to_pdf_converter.model.ConversionJob;
import com.DocxToPdf.doc_to_pdf_converter.model.JobStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.util.UUID;

@Service
public class FileUploadService {
    private final MessageQueueService messageQueueService;
    private final FileStorageService fileStorageService;
    private final JobStatusService jobStatusService;

    public FileUploadService(MessageQueueService messageQueueService,
                           FileStorageService fileStorageService,
                           JobStatusService jobStatusService) {
        this.messageQueueService = messageQueueService;
        this.fileStorageService = fileStorageService;
        this.jobStatusService = jobStatusService;
    }

    public String initiateConversion(MultipartFile file) throws Exception {
        String jobId = UUID.randomUUID().toString();
        String filePath = fileStorageService.store(file);
        ConversionJob job = new ConversionJob(jobId, filePath, file.getOriginalFilename());
        jobStatusService.updateStatus(jobId, JobStatus.PENDING);
        messageQueueService.sendConversionJob(job);
        return jobId;
    }
}

