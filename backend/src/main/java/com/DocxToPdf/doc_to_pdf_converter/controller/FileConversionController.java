package com.DocxToPdf.doc_to_pdf_converter.controller;

import com.DocxToPdf.doc_to_pdf_converter.model.JobResponse;
import com.DocxToPdf.doc_to_pdf_converter.model.JobStatus;
import com.DocxToPdf.doc_to_pdf_converter.model.ConversionResult;
import com.DocxToPdf.doc_to_pdf_converter.service.FileUploadService;
import com.DocxToPdf.doc_to_pdf_converter.service.JobStatusService;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/v1/convert")
@CrossOrigin
public class FileConversionController {
    private final FileUploadService fileUploadService;
    private final JobStatusService jobStatusService;

    public FileConversionController(FileUploadService fileUploadService, JobStatusService jobStatusService) {
        this.fileUploadService = fileUploadService;
        this.jobStatusService = jobStatusService;
    }

    @PostMapping("/docx-to-pdf")
    public ResponseEntity<JobResponse> submitConversion(@RequestParam("file") MultipartFile file) {
        try {
            String jobId = fileUploadService.initiateConversion(file);
            return ResponseEntity.accepted()
                    .body(new JobResponse(jobId, "Conversion job submitted successfully"));
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(new JobResponse(null, "Error submitting conversion: " + e.getMessage()));
        }
    }

    @GetMapping("/status/{jobId}")
    public ResponseEntity<JobStatus> getJobStatus(@PathVariable String jobId) {
        return ResponseEntity.ok(jobStatusService.getStatus(jobId));
    }

    @GetMapping("/download/{jobId}")
    public ResponseEntity<Resource> downloadFile(@PathVariable String jobId) {
        try {
            ConversionResult result = jobStatusService.getResult(jobId);
            if (result.isCompleted()) {
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_DISPOSITION,
                                "attachment; filename=\"" + result.getFileName() + "\"")
                        .contentType(MediaType.APPLICATION_PDF)
                        .body(result.getFileResource());
            }
            return ResponseEntity.status(404).build();
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }
}
