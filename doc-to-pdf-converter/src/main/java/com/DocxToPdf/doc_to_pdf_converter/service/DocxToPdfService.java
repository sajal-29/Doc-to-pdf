package com.DocxToPdf.doc_to_pdf_converter.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.springframework.stereotype.Service;

import com.lowagie.text.DocumentException;
import com.lowagie.text.Font;
import com.lowagie.text.pdf.BaseFont;

import fr.opensagres.poi.xwpf.converter.pdf.PdfConverter;
import fr.opensagres.poi.xwpf.converter.pdf.PdfOptions;

@Service
public class DocxToPdfService {

    public void convertDocxToPdf(File file, String outputPath) throws Exception {
        try (
                InputStream inputStream = new FileInputStream(file); OutputStream outputStream = new FileOutputStream(new File(outputPath)); XWPFDocument document = new XWPFDocument(inputStream) // Create document from the InputStream
                ) {
            // Configure PDF options referenced from StackOverflow
            PdfOptions options = PdfOptions.create();
            options.fontProvider((familyName, encoding, size, style, color) -> {
                try {
                    BaseFont baseFont = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1250, BaseFont.EMBEDDED);
                    return new Font(baseFont, size, style, color);
                } catch (DocumentException | IOException e) {
                    return new Font(Font.HELVETICA, size, style, color);
                }
            });

            // Convert DOCX to PDF
            PdfConverter.getInstance().convert(document, outputStream, options);
        } catch (Exception e) {
            throw new Exception("Failed to convert DOCX to PDF: " + e.getMessage(), e);
        }
    }
}
