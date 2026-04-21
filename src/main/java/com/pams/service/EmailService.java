package com.pams.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendEmail(String to, String subject, String body) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("pams-notifications@example.com");
            message.setTo(to);
            message.setSubject(subject);
            message.setText(body);
            mailSender.send(message);
        } catch (Exception e) {
            System.err.println("Error sending email: " + e.getMessage());
            // We log the error but don't crash the app for a failed notification
        }
    }

    public void sendComplaintConfirmation(String to, String assetName, Long complaintId) {
        String subject = "Complaint Registered - PAMS";
        String body = "Dear Citizen,\n\nYour complaint for '" + assetName + "' has been successfully registered.\n" +
                      "Complaint ID: #" + complaintId + "\n\nYou can track the status on your dashboard.\n\nRegards,\nPAMS Team";
        sendEmail(to, subject, body);
    }

    public void sendPasswordResetLink(String to, String token) {
        String subject = "Password Reset Request - PAMS";
        String body = "Dear User,\n\nYou requested a password reset. Use the link below to set a new password:\n" +
                      "http://localhost:8082/reset-password?token=" + token + "\n\n" +
                      "If you did not request this, please ignore this email.\n\nRegards,\nPAMS Team";
        sendEmail(to, subject, body);
    }
}
