package com.example.sweater.service;

import com.example.sweater.domain.Message;
import com.example.sweater.repos.MessageRepo;
import com.example.sweater.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;


@Service
public class MessageSevice implements MessageDetailsService {
    @Autowired
    private MessageRepo messageRepo;


    //-поиск работает только по полному соответствию, потом переделать
    @Override
    public Iterable<Message> showMessages(String filterPrice, String filterName) {
        Iterable<Message> messages = messageRepo.findAll();
        if (filterPrice != null && !filterPrice.isEmpty()) {
            messages = messageRepo.findByTag(filterPrice);
        } else if (filterName != null && !filterName.isEmpty()) {
            messages = messageRepo.findByMessagename(filterName);
        }else{

            messages = messageRepo.findAll();
        }
        return messages;
    }

    @Override
    public void deleteMessage(Long id) {
        messageRepo.deleteById(id);
    }
}