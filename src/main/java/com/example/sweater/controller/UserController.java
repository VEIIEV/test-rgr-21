package com.example.sweater.controller;

import com.example.sweater.domain.Role;
import com.example.sweater.domain.User;
import com.example.sweater.repos.UserRepo;
import com.example.sweater.service.UserSevice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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
public class UserController {
    @Autowired
    private UserSevice userSevice;


    @PreAuthorize("hasAuthority('ADMIN')") //проверка на роль, если их нет контроллеры дадут ошибку 403(нет доступа)
//для работы необходимо в вебсекконфиге добавить анотацию унглметсек
    @GetMapping
    public String userList(Model model){
        model.addAttribute("users", userSevice.findAll());
        return "userList";
    }


    //добавляет к известному пути  идентификатор {user}, в который
//будет класться @PathVariable User user ( пользователь из бд)
    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("{user}")
    public String userEditForm(Model model,@PathVariable User user){
        model.addAttribute("user",user);
        model.addAttribute("roles", Role.values())  ;
        return "userEdit";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping
    public String userSave(
            @RequestParam("userId") User user,
            @RequestParam String username,
            @RequestParam Map<String, String> form)
    {
        userSevice.saveUser(user, username, form);
        return "redirect:/user";
    }
     //если что-то сломается вернуть на просто user
    @GetMapping("profile")
    public String getProfile(Model model,@AuthenticationPrincipal User currentUser){
        model.addAttribute("username", currentUser.getUsername());
        model.addAttribute("email",currentUser.getEmail());
        return "profile";
    }

    @GetMapping("editProfile")
    public String getEditProfile(Model model,@AuthenticationPrincipal User user){
        model.addAttribute("username", user.getUsername());
        model.addAttribute("email",user.getEmail());
        return "editProfile";
    }


    @PostMapping("editProfile")
    public String updateProfile(Model model,
                             @AuthenticationPrincipal User user,
                             @RequestParam String password,
                             @RequestParam String email,
                             @RequestParam("oldPassword") String oldPassword ){
        if(!userSevice.updateProfile(user, password, oldPassword, email)) {
            model.addAttribute("passwordError","wrong password");
            return "editProfile";
        }
        model.addAttribute("passwordError","Edit complite");
        return "redirect:/user/editProfile";
    }
}
