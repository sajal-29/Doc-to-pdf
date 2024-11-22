package com.DocxToPdf.doc_to_pdf_converter.model;

import org.springframework.core.io.Resource;

public class ConversionResult {

    @SuppressWarnings("FieldMayBeFinal")
    private boolean completed;
    @SuppressWarnings("FieldMayBeFinal")
    private String fileName;
    @SuppressWarnings("FieldMayBeFinal")
    private Resource fileResource;

    public ConversionResult(boolean completed, String fileName, Resource fileResource) {
        this.completed = completed;
        this.fileName = fileName;
        this.fileResource = fileResource;
    }

    // Getters
    public boolean isCompleted() {
        return completed;
    }

    public String getFileName() {
        return fileName;
    }

    public Resource getFileResource() {
        return fileResource;
    }
}
