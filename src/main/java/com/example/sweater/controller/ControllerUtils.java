package com.example.sweater.controller;

import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import java.util.Map;
import java.util.stream.Collector;
import java.util.stream.Collectors;

public class ControllerUtils {
    //public не заработал
    //создаем сообщение об ошибки
    static Map<String,String> getErrors(BindingResult bindingResult) {
        Collector<FieldError,?, Map<String,String>> collector= Collectors.toMap(
                fieldError -> fieldError.getField() + "ERROR",
                FieldError::getDefaultMessage
        );
        return bindingResult.getFieldErrors().stream().collect(collector);
    }
}
