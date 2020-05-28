package com.mobilecourse.backend.model;

public class Account {
    public String id;
    // username和email的关系应该是username@(mail(s)?.)?tsinghua.edu.cn
    public String username;
    public String email;
    public String password;
    public String nickname;
    public String signature;
    public String avatar;// 头像的url
    //private Post posts;
}
