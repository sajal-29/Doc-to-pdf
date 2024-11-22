package com.DocxToPdf.doc_to_pdf_converter.service;

import com.DocxToPdf.doc_to_pdf_converter.model.ConversionJob;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class MessageQueueService {
    private final RabbitTemplate rabbitTemplate;

    @Value("${queue.conversion.name}")
    private String queueName;

    public MessageQueueService(RabbitTemplate rabbitTemplate) {
        this.rabbitTemplate = rabbitTemplate;
    }

    public void sendConversionJob(ConversionJob job) {
        rabbitTemplate.convertAndSend(queueName, job);
    }
}