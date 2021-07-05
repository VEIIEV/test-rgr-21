package com.example.sweater.domain;

import org.springframework.security.core.GrantedAuthority;

public enum Role implements GrantedAuthority {
    USER, ADMIN;

    @Override
    // делается для работы c userdetails что бы типы соответствовали
    public String getAuthority() {
        return name();
    }
}
