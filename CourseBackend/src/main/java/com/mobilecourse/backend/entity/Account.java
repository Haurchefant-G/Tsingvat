package com.mobilecourse.backend.entity;

public class Account {
    // username和email的关系应该是username@(mail(s)?.)?tsinghua.edu.cn
    private String username;
    private String email;
    private Long phone;
    private String password;
    private String nickname;
    private String signature;
    private String avatar;// 头像的url
    //private Post posts;


    public String getEmail() {
        return email;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public Long getPhone() {
        return phone;
    }

    public String getSignature() {
        return signature;
    }

    public String getNickname() {
        return nickname;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public void setPhone(Long phone) {
        this.phone = phone;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
}
