package com.example.sweater.service;

import com.example.sweater.domain.Role;
import com.example.sweater.domain.User;
import com.example.sweater.repos.UserRepo;
import freemarker.template.utility.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Collections;
import java.util.UUID;

@Service
public class UserSevice implements UserDetailsService {
    @Autowired
    private UserRepo userRepo;

    @Autowired
    private MailSender emailSender;
    
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepo.findByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException(username);
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
        userRepo.save(user);//сохраняем пользователя
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
        return true;
    }
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
}
