package com.example.sweater.service;

import com.example.sweater.domain.Role;
import com.example.sweater.domain.User;
import com.example.sweater.repos.UserRepo;
import freemarker.template.utility.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserSevice implements UserDetailsService {
    @Autowired
    private UserRepo userRepo;

    @Autowired
    private MailSender emailSender;

    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepo.findByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException("User not found");
        }
        //return new MyUserPrincipal(user);
        return user;
    }
    public boolean addUser(User user) {
        //берём пользователя из дб
        User userFromDb=userRepo.findByUsername(user.getUsername());
        // проверка на наличие в бд
        if (userFromDb!= null) {
            return false;
        }
        user.setActive(true);
        user.setRoles(Collections.singleton(Role.USER));
        //добавляем идивдуальный UUID для проверки почты
        user.setActivationCode(UUID.randomUUID().toString());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepo.save(user);//сохраняем пользователя

        sendMessage(user);
        return true;
    }

    private void sendMessage(User user) {
        if (!StringUtils.isEmpty(user.getEmail())){
            //переделать ссылку
            String message=String.format("hello, %s \n"+
                    "Please, visit next link to activate your account http://localhost:8080/activate/%s",
                    user.getUsername(),
                    user.getActivationCode()
            );
            // отправка письма
            emailSender.send(user.getEmail(),"Activation code", "ds "+message);
        }
    }

    public void sendMessageAppPrice(User user) {
        if (!StringUtils.isEmpty(user.getEmail())){
            //переделать ссылку
            String message=String.format("hello, %s \n"+
                            "Your bid is accepted",
                    user.getUsername()
            );
            // отправка письма
            emailSender.send(user.getEmail(),"New bid", "hello, "+message);
        }
    }

    //переделать полюдски
   //blic void sendMessageEndTrade(User user) {
   //  if (!StringUtils.isEmpty(user.getEmail())){
   //      //переделать ссылку
   //      String message=String.format("hello, %s \n"+
   //                      "the auction is over",
   //              user.getUsername()
   //      );
   //      // отправка письма
   //      emailSender.send(user.getEmail(),"New bid", "hello, "+message);
   //  }
   //


    //активация аккаунта
    public boolean activateUser(String code) {
        //поиск пользователя по коду
        User user=userRepo.findByActivationCode(code);
        if(user==null){
            return  false;
        }
        //занулируем код, он больше не нужен
        user.setActivationCode(null);
        //сохраняем изменения в бд
        userRepo.save(user);
        return true;
    }

    public boolean saveUser(User user,String username,
                            Map<String, String> form){
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

        return true;
    }

    public List<User> findAll() {
        return userRepo.findAll();
    }

    public boolean updateProfile(User user, String password, String oldPassword, String email) {
        String userEmail = user.getEmail();
        boolean isChenged = (email!=null && !email.equals(userEmail))||
                (userEmail!=null && !userEmail.equals(email));

        if(isChenged){
            user.setEmail(email);
            if(!StringUtils.isEmpty(email)){
                user.setActivationCode(UUID.randomUUID().toString());
                sendMessage(user);
            }
        }
        if(passwordEncoder.matches(oldPassword,user.getPassword())) {
            user.setPassword(passwordEncoder.encode(password));
            userRepo.save(user);
            return true;
        }
        return false;
    }
}
