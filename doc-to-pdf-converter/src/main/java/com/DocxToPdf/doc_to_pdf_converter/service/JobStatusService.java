package com.DocxToPdf.doc_to_pdf_converter.service;

import com.DocxToPdf.doc_to_pdf_converter.model.ConversionResult;
import com.DocxToPdf.doc_to_pdf_converter.model.JobStatus;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class JobStatusService {
    private final Map<String, JobStatus> jobStatuses = new ConcurrentHashMap<>();
    private final Map<String, String> resultPaths = new ConcurrentHashMap<>();
    private final FileStorageService fileStorageService;

    public JobStatusService(FileStorageService fileStorageService) {
        this.fileStorageService = fileStorageService;
    }

    public void updateStatus(String jobId, JobStatus status) {
        jobStatuses.put(jobId, status);
    }

    public void updateStatus(String jobId, JobStatus status, String resultPath) {
        jobStatuses.put(jobId, status);
        if (resultPath != null) {
            resultPaths.put(jobId, resultPath);
        }
    }

    public JobStatus getStatus(String jobId) {
        return jobStatuses.getOrDefault(jobId, JobStatus.NOT_FOUND);
    }

    public ConversionResult getResult(String jobId) throws Exception {
        JobStatus status = getStatus(jobId);
        String resultPath = resultPaths.get(jobId);

        if (status == JobStatus.COMPLETED && resultPath != null) {
            Resource fileResource = new FileSystemResource(fileStorageService.retrieve(resultPath));
            return new ConversionResult(true, resultPath, fileResource);
        }

        return new ConversionResult(false, null, null);
    }
}