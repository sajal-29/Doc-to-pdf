//package com.DocxToPdf.doc_to_pdf_converter.uploadFile;
//import org.springframework.http.HttpHeaders;
//import org.springframework.http.MediaType;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//import org.springframework.web.multipart.MultipartFile;
//import java.io.*;
//import java.nio.file.Files;
//import java.time.LocalDateTime;
//import java.time.format.DateTimeFormatter;
//
//@RestController
//@RequestMapping("/api/document")
//public class DocumentController {
//
//    private final DocxToPdfService converter;
//
//    public DocumentController(DocxToPdfService converter) {
//        this.converter = converter;
//    }
//
//    @PostMapping("/convert")
//    public ResponseEntity<byte[]> convertDocxToPdf(@RequestParam("file") MultipartFile file) {
//        try {
//            // Generate a unique filename for the PDF
//            String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss"));
//            String originalFilename = file.getOriginalFilename();
//            String pdfFilename = originalFilename.replaceAll(".docx$", "") + "_" + timestamp + ".pdf";
//
//            // Create a temporary file for the PDF
//            File tempFile = File.createTempFile("temp_", ".pdf");
//            String outputPath = tempFile.getAbsolutePath();
//
//            // Convert the document
//            converter.convertDocxToPdf(file, outputPath);
//
//            // Read the PDF file into a byte array
//            byte[] contents = Files.readAllBytes(tempFile.toPath());
//
//            // Delete the temporary file
//            tempFile.delete();
//
//            // Set up the response headers
//            HttpHeaders headers = new HttpHeaders();
//            headers.setContentType(MediaType.APPLICATION_PDF);
//            headers.setContentDispositionFormData("attachment", pdfFilename);
//            headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");
//
//            return ResponseEntity.ok()
//                    .headers(headers)
//                    .body(contents);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            return ResponseEntity.internalServerError().build();
//        }
//    }
//}
