package com.example.sweater.service;

import com.example.sweater.domain.Message;

public interface MessageDetailsService {

    void deleteMessage(Long id);

    Iterable<Message> showMessages(String filterPrice, String filterName);
}
