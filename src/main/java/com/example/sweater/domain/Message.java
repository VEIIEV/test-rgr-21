package com.example.sweater.domain;

import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.xml.crypto.Data;
import java.io.File;

@Entity
public class Message {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Long id;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User author;
    //вряд ли будет меняться
    @NotBlank(message = "message is empty")
    @Length(max=255, message = "too long(255char)")
    private String messagename;
    @Length(max=2048, message = "too long(2048char)")
    private String text;
    @Length(max=255, message = "too long(255char)")
    private String tag;
    @Length(max=255, message = "too long(255char)")
    private String currentPrice;
    private String filename;




    public Message() {
    }

    public Message(String text, String tag, User user) {
        this.text = text;
        this.tag = tag;
        this.author=user;
    }

    public String getAuthorname(){
        return author.getUsername();
    }
    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getMessagename() { return messagename; }
    public void setMessagename(String messagename) { this.messagename = messagename; }
    public String getText() {
        return text;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public String getCurrentPrice() {
        return currentPrice;
    }

    public void setCurrentPrice(String currentPrice) {
        this.currentPrice = currentPrice;
    }
    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

}
