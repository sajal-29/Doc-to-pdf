package com.DocxToPdf.doc_to_pdf_converter.uploadFile;

import java.io.*;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import fr.opensagres.poi.xwpf.converter.pdf.PdfConverter;
import fr.opensagres.poi.xwpf.converter.pdf.PdfOptions;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import com.lowagie.text.Font;
import com.lowagie.text.pdf.BaseFont;

@Service
public class DocxToPdfService {

    public void convertDocxToPdf(MultipartFile file, String outputPath) throws Exception {
        try (InputStream inputStream = file.getInputStream();
             OutputStream outputStream = new FileOutputStream(new File(outputPath))) {

            // Load DOCX document
            XWPFDocument document = new XWPFDocument(inputStream);

            // Configure PDF options
            PdfOptions options = PdfOptions.create();

            // Set up fonts to support multiple languages
            options.fontProvider((familyName, encoding, size, style, color) -> {
                try {
                    BaseFont baseFont = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1250, BaseFont.EMBEDDED);
                    return new Font(baseFont, size, style, color);
                } catch (Exception e) {
                    // If there's an error, return a default font
                    return new Font(Font.HELVETICA, size, style, color);
                }
            });

            // Convert DOCX to PDF with images
            PdfConverter.getInstance().convert(document, outputStream, options);

            // Close the document
            document.close();
        } catch (Exception e) {
            throw new Exception("Failed to convert DOCX to PDF: " + e.getMessage(), e);
        }
    }

    // Optional: Add method to validate input file is actually a DOCX
    private boolean isValidDocx(MultipartFile file) {
        String contentType = file.getContentType();
        return contentType != null && (
                contentType.equals("application/vnd.openxmlformats-officedocument.wordprocessingml.document") ||
                        contentType.equals("application/docx")
        );
    }
}