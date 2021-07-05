package com.example.sweater.config;

import com.example.sweater.service.UserSevice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;

import javax.sql.DataSource;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)//повилось само, круто
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {


    @Autowired
    private UserSevice userSevice;

    @Autowired
    private DataSource dataSource;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        //это одна большая комплексная функция, жуть**( для определения уровня допуска для каждого запроса)
        http
                .authorizeRequests()
                    .antMatchers("/", "/registration","/static/**","/activate/*").permitAll()
                    .anyRequest().authenticated()
                .and()
                    .formLogin()
                    .loginPage("/login")
                    .permitAll()
                .and()
                    .logout()
                    .permitAll();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        // dataSource(dataSource). дает доступ менеджеру к бд и исктаь пользвоателей и их роли
        // .passwordEncoder() шифрует пароли
        // добавляет запрос позволяющей системе найти юсера по username
        //.usersByUsernameQuery("select username, password, active from usr where username=?");
        // порядок и набор полей определены системой если его менять что-т оможет пойти не так
        //.authoritiesByUsernameQuery(); помогает спрингу получить пользователей с их роялми

       //auth.jdbcAuthentication()
       //        .dataSource(dataSource)
       //        .passwordEncoder(NoOpPasswordEncoder.getInstance())
       //        .usersByUsernameQuery("select username, password, active from usr where username=?")
       //        .authoritiesByUsernameQuery("select u.username, ur.roles from usr u inner join user_role ur on u.id = ur.user_id where u.username=?");
        //переписываем взаимодействия на собственные описанные методы
        auth.userDetailsService(userSevice)
                .passwordEncoder(NoOpPasswordEncoder.getInstance());
    }

}


