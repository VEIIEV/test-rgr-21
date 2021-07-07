package com.example.sweater.controller;


import com.example.sweater.domain.User;
import com.example.sweater.repos.UserRepo;
import com.example.sweater.service.UserSevice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;
import java.util.Collections;
import java.util.Map;

@Controller
public class RegistrationController {
    //вынес логику в узерсевис, больше не нужно
    @Autowired
    private UserRepo userRepo;

    @Autowired
    private UserSevice userSevice;

    @GetMapping("/registration")
    public String registration(){
        return "registration";
    }

    @PostMapping("/registration")
    public String addUser(@Valid User user, BindingResult bindingResult, Model model){
        if(user.getPassword()!=null && !user.getPassword().equals(user.getPassword2())){
            model.addAttribute("passwordError","password isnt equals");
        }
        if(bindingResult.hasErrors()){
            //спринговая валидация почему-то не заработала, позже попробовать исправить
            Map<String,String> errors= ControllerUtils.getErrors(bindingResult);
            model.addAttribute("map",errors);
            if(StringUtils.isEmpty(user.getPassword())){
                model.addAttribute("passwordEmpty", "password Empty");
            }
            if(StringUtils.isEmpty(user.getUsername())){
                model.addAttribute("usernameEmpty", "username Empty");
            }
            if(StringUtils.isEmpty(user.getPassword2())){
                model.addAttribute("password2Empty", "password2 Empty");
            }
            if(StringUtils.isEmpty(user.getEmail())){
                model.addAttribute("emailEmpty", "email Empty");
            }
            return "registration";
        }
        if (!userSevice.addUser(user))
        {
            model.addAttribute("usernameError", "User exixts!");
            return "registration";
        }
        return "redirect:/login";
    }

    @GetMapping("/activate/{code}")
    public String activate(Model model, @PathVariable String code) {
        boolean isActivated = userSevice.activateUser(code);
        if (isActivated) {
            model.addAttribute("message", "User successfully activated");
        } else {
            model.addAttribute("message", "Activation code is not found!");
        }
        return "login";
    }

}
