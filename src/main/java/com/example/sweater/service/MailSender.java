package com.example.sweater.service;

import com.example.sweater.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailSender {
    @Autowired
    private UserRepo userRepo;
    @Autowired
    private JavaMailSender emailSender;

    //@Value("${mail.username}")
    //private String username;


    public  void send(String emailTo, String subject,String message ){
        SimpleMailMessage mailMessage=new SimpleMailMessage();
        //mailMessage.setFrom(username);
        mailMessage.setTo(emailTo);
        mailMessage.setSubject(subject);
        mailMessage.setText(message);
        //не совсем понимаю почему я вызываю функцию внутри самой функции но разберусь в другой раз
        this.emailSender.send(mailMessage);
    }
}
