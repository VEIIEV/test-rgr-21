package com.example.sweater.domain;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import java.util.Collection;
import java.util.Set;
import java.util.UUID;

//имплементируем userdetails  который хранит базовую инфу о пользователе
@Entity
@Table(name="usr")
public class User implements UserDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @NotBlank(message = "password is empty")
    private String password;



    @Transient //игнорирует поле при создание ячейки в бд
    private String password2; // transient игнорирования полей во время сериализации объектов
    @NotBlank(message = "username is empty")
    private String username;
    private boolean active;
    @Email(message = "enter correct email")
    @NotBlank(message = "email is empty")
    private String email;
    private String activationCode;



    @ElementCollection(targetClass = Role.class, fetch=FetchType.EAGER)
    @CollectionTable(name="user_role", joinColumns = @JoinColumn(name="user_id"))
    @Enumerated(EnumType.STRING)
    private Set<Role> roles;

    public String getPassword2() { return password2; }

    public void setPassword2(String password2) { this.password2 = password2; }

    public boolean isAdmin(){
        return roles.contains(Role.ADMIN);
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    public String getEmail() { return email; }

    public void setEmail(String email) { this.email = email; }

    public String getActivationCode() { return activationCode; }

    public void setActivationCode(String activationCode) { this.activationCode = activationCode; }


    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return isActive();
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return getRoles();
    }

    public void Username() {
    }
}