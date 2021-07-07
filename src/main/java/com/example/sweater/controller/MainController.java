package com.example.sweater.controller;

import com.example.sweater.domain.Message;
import com.example.sweater.domain.User;
import com.example.sweater.repos.MessageRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collector;
import java.util.stream.Collectors;

//запросы контролера работают только с репозиториями, не с сущностями
@Controller
public class MainController {
    @Autowired
    private MessageRepo messageRepo;
    //получаем переменную
    //спринг выдергивает значение из контекста(тут их проперти файла)
    @Value("${upload.path}")
    private String uploadpath;

    @GetMapping("/")
    public String greeting(Map<String, Object> model) {
        return "greeting";
    }

    @GetMapping("/main")
    public String main(
            @RequestParam(required = false, defaultValue = "") String filter,
            Model model) {
        Iterable<Message> messages = messageRepo.findAll();
        if (filter != null && !filter.isEmpty()) {
            messages = messageRepo.findByTag(filter);
        } else {
            messages = messageRepo.findAll();
        }

        model.addAttribute("messages", messages);
        model.addAttribute("filter", messages);

        return "main";
    }

    @PostMapping("/main")
    public String add(
            //@RequestParam String text, убрал после введеняи валидации
            //@RequestParam String tag,
            @AuthenticationPrincipal User user,
            @Valid Message message, //запускает валидацию
            BindingResult bindingResult, //список аргументов и сообщений ошибок валидации
            Model model, // обязательно должен идти перед арг модел, если изменить порядок все ошибки не будут обрабатываться ЕБАЛАААА
            @RequestParam("file") MultipartFile file
    ) throws IOException {
        message.setAuthor(user);

        if(bindingResult.hasErrors()){
            Map<String,String>errorsMap= ControllerUtils.getErrors(bindingResult);//определил метод в controllerutils
            model.addAttribute("map",errorsMap);
            model.addAttribute("message", message);
        }else {
            //загружаю файл
            saveFile(message, file);
            model.addAttribute("message", null); //не уверен что в этом есть смысл
            messageRepo.save(message);
        }

        Iterable<Message> messages = messageRepo.findAll();

        model.addAttribute("messages", messages);

        return "main";
    }



    //потом  вынести в новый отдельный контролер

    @GetMapping("/user-messages/{user}")
    public String userMessages(
            @AuthenticationPrincipal User currentUser,
            //(name="user" должно быть равно {user} если переменная отличается по названию
            @PathVariable User user, //принимаем перменную {user} и суваем её суды
            Model model,
            @RequestParam(required = false) Message message){//
        Set<Message> messages =user.getMessages();
        model.addAttribute("messages", messages);//все месежи юзера
        model.addAttribute("message", message);//то из-за кого мы пришли
        model.addAttribute("isCurrentUser",currentUser.equals(user)); //сломано
        //починил, нужно было на оверайдить методы в сущности


        return "userMessages";
    }
 //возможно получиться получить починить смену пороля
 //реализовать аналог в юзер контролере
    @PostMapping ("user-messages/{user}")
        public String updateMessage(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            @RequestParam("id") Message message,
            @RequestParam("text") String text,
            @RequestParam("tag") String tag,
            @RequestParam("file") MultipartFile file) throws IOException {
        if(message.getAuthor().equals(currentUser)) {
            if(!StringUtils.isEmpty(text)){
                message.setText(text);
            }
            if(!StringUtils.isEmpty(tag)){
                message.setTag(tag);
            }
            saveFile(message, file);
            messageRepo.save(message);
        }

        return "redirect:/user-messages/"+user.getId();
    }





    /*@PostMapping("filter")
    public String filter(@RequestParam String filter, Map<String, Object> model) {
        Iterable<Message> messages;

        if (filter != null && !filter.isEmpty()) {
            messages = messageRepo.findByTag(filter);
        } else {
            messages = messageRepo.findAll();
        }

        model.put("messages", messages);

        return "main";
    }
     */
    private void saveFile(Message message, MultipartFile file) throws IOException {
        if (file != null) {
            File uploadDir = new File(uploadpath);
            if (!uploadDir.exists() && !file.getOriginalFilename().isEmpty()) {
                uploadDir.mkdir();
            }
            String uuidFile = UUID.randomUUID().toString();
            String ResultFilename = uuidFile + "." + file.getOriginalFilename();
            file.transferTo(new File(uploadpath + "/" + ResultFilename));
            message.setFilename(ResultFilename);
            //загружаю файл

            //что бы отображатсья файл на сайте, нужно изменить конфиг файл
        }
    }
}
