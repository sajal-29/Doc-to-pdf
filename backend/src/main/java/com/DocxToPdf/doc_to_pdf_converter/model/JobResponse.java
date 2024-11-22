package com.DocxToPdf.doc_to_pdf_converter.model;

public class JobResponse {
    private String jobId;
    private String message;

    public JobResponse(String jobId, String message) {
        this.jobId = jobId;
        this.message = message;
    }

    // Getters and setters
    public String getJobId() {
        return jobId;
    }

    public void setJobId(String jobId) {
        this.jobId = jobId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}