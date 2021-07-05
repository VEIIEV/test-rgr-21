package com.example.sweater.controller;

import com.example.sweater.domain.Role;
import com.example.sweater.domain.User;
import com.example.sweater.repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Controller
//накладывает путь всем методам класс
@RequestMapping("/user")
@PreAuthorize("hasAuthority('ADMIN')") //проверка на роль, если их нет контроллеры дадут ошибку 403(нет доступа)
//для работы необходимо в вебсекконфиге добавить анотацию унглметсек
public class UserController {
    @Autowired
    private UserRepo userRepo;

    @GetMapping
    public String userList(Model model){
        model.addAttribute("users", userRepo.findAll());
        return "userList";
    }
    //добавляет к известному пути  идентификатор {user}, в который
//будет класться @PathVariable User user ( пользователь из бд)
    @GetMapping("{user}")
    public String userEditForm(Model model,@PathVariable User user){
        model.addAttribute("user",user);
        model.addAttribute("roles", Role.values())  ;
        return "userEdit";
    }

    @PostMapping
    public String userSave(
            @RequestParam("userId") User user,
            @RequestParam String username,
            @RequestParam Map<String, String> form)
    {
        user.setUsername(username);
        Set<String> roles= Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());

        user.getRoles().clear();
        for (String key :form.keySet()){
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }
        userRepo.save(user);

        return "redirect:/user";

    }


}
