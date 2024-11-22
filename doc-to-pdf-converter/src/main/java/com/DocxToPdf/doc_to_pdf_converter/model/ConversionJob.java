package com.DocxToPdf.doc_to_pdf_converter.model;

import java.io.Serializable;

public class ConversionJob implements Serializable {
    private String jobId;
    private String filePath;
    private String originalFileName;

    public ConversionJob() {
    }

    public ConversionJob(String jobId, String filePath, String originalFileName) {
        this.jobId = jobId;
        this.filePath = filePath;
        this.originalFileName = originalFileName;
    }

    // Getters and setters
    public String getJobId() {
        return jobId;
    }

    public void setJobId(String jobId) {
        this.jobId = jobId;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getOriginalFileName() {
        return originalFileName;
    }

    public void setOriginalFileName(String originalFileName) {
        this.originalFileName = originalFileName;
    }
}