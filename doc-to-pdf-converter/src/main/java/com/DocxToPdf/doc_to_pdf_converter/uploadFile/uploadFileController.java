package com.DocxToPdf.doc_to_pdf_converter.uploadFile;

import org.apache.tomcat.util.http.fileupload.ByteArrayOutputStream;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

@RestController
@RequestMapping("/convert")
public class uploadFileController {

    private final DocxToPdfService fileService;

    public uploadFileController(DocxToPdfService fileService) {
        this.fileService = fileService;
    }

    @CrossOrigin
    @PostMapping("/docx-to-pdf")
    public ResponseEntity<?> convertDocxToPdf(@RequestParam("file") MultipartFile file) {
        try {
            // Call the service to convert DOCX to PDF

            File tempFile = File.createTempFile("converted_", ".pdf");
            fileService.convertDocxToPdf(file, tempFile.getAbsolutePath());

            // Read the generated PDF into byte array
            byte[] pdfContents = Files.readAllBytes(tempFile.toPath());

            // Clean up the temp file
            tempFile.delete();

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_PDF);
            headers.setContentDisposition(
                    org.springframework.http.ContentDisposition.builder("attachment")
                            .filename(file.getOriginalFilename().replaceAll(".docx$", ".pdf"))
                            .build());

            return ResponseEntity.ok()
                    .headers(headers)
                    .body(pdfContents);

//            return ResponseEntity.ok("File converted successfully");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error during conversion: " + e.getMessage());
        }
    }
}
