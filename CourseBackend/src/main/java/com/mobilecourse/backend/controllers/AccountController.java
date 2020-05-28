package com.mobilecourse.backend.controllers;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.mobilecourse.backend.dao.AccountDao;
import com.mobilecourse.backend.dao.TestDao;
import com.mobilecourse.backend.model.Account;
import com.mobilecourse.backend.model.Test;
import com.mobilecourse.backend.WebSocketServer;
import org.apache.tomcat.jni.Time;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

@RestController
@EnableAutoConfiguration
//设置此参数可以给这个类的所有接口都加上前缀
@RequestMapping("/account")
public class AccountController extends CommonController {

    @Autowired
    private AccountDao accountMapper;

    // 普通请求，不指定method意味着接受所有类型的请求
    @RequestMapping(value = "/hello")
    public String hello() {
        int cnt = accountMapper.testCnt();
        return wrapperMsg(200, "当前数据库中共有：" + cnt + "条数据！");
    }


    @RequestMapping(value = "/login", method = { RequestMethod.POST })
    public String login(@RequestBody Account account) {
        int login = 0;
        if(account.username != null && account.password != null) {
            // 前端应保证传来的都不为null
            login = accountMapper.login(account.username, account.password);
        }
        if(login == 0){
            return wrapperMsg(HttpsCode.LOGIN_FAILED, "Error:id or password is wrong");
        } else if(login == 1){
            return wrapperMsg(HttpsCode.LOGIN_SUCCEED, "Successfully login");
        }
        return wrapperMsg(200, "");
    }

    @RequestMapping(value = "/register", method = { RequestMethod.POST })
    public String register(@RequestBody Account account) {
        // 如果对应参数没有传的话，则会默认为null
        String username = account.username;
        try {
            accountMapper.insert(account);
            return  wrapperMsg(HttpsCode.REGISTER_SUCCEED, "regsiter succeed");
        }catch (Exception e){
            return wrapperMsg(HttpsCode.REGISTER_SUCCEED, "Error:"+e.getMessage());
        }
    }

    private String generateId(String email){
        // 生成唯一id
        return "2";
    }
}
