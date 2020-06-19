package com.mobilecourse.backend.controllers;

import com.alibaba.fastjson.JSONObject;
import com.mobilecourse.backend.utils.ResultModel;
import com.mobilecourse.backend.utils.TokenUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.Date;
import java.util.UUID;

@Controller
public class CommonController {

    // session半个小时无交互就会过期
    private static int MAX_TIME = 1800;

    public String getUuid(){
        return UUID.randomUUID().toString();
    }

    public Timestamp getCurrentTime(){
        return new Timestamp(new Date().getTime());
    }

    /**
     * 运行结果正确，返回数据
     * @param data
     * @return
     */
    ResponseEntity<ResultModel> wrapperOKResp(Object data){
        return ResponseEntity.ok(ResultModel.ok(data));
    }

    /**
     * 1. 请求出错，如出现用户名无法找到
     * 2. 数据库操作出错，这类error
     *      2.1 进行select时，肯定不会出现数据库错误
     *      2.2 进行insert update时的错误
     * 返回值应当包括问题描述以及code
     * @return
     */
    ResponseEntity<ResultModel> wrapperErrorResp(int code,String msg){
        return ResponseEntity.ok(new ResultModel(code, msg));
    }


    // 添加一个code，方便客户端根据code来判断服务器处理状态并解析对应的msg
    String wrapperMsg(int code, String msg) {
        JSONObject wrapperMsg = new JSONObject();
        wrapperMsg.put("code", code);
        wrapperMsg.put("msg", msg);
        return wrapperMsg.toJSONString();
    }

    // 添加信息到session之中，此部分用途很广泛，比如可以通过session获取到对应的用户名或者用户ID，避免繁冗操作
    public void putInfoToSession(HttpServletRequest request, String keyName, Object info)
    {
        HttpSession session = request.getSession();
        //设置session过期时间，单位为秒(s)
        session.setMaxInactiveInterval(MAX_TIME);
        //将信息存入session
        session.setAttribute(keyName, info);
    }

    public void removeInfoFromSession(HttpServletRequest request, String keyName)
    {
        HttpSession session = request.getSession();
        // 删除session里面存储的信息，一般在登出的时候使用
        session.removeAttribute(keyName);
    }

    public boolean checkRequest(HttpServletRequest request, String compare){
        String token = (String)request.getSession().getAttribute("token");
        String username = (String) TokenUtils.parseJWT(token).get("username");
        if(username.equals(compare)) return true;
        return false;
    }
}
