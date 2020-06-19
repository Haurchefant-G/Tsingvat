package com.mobilecourse.backend.controllers;

import com.mobilecourse.backend.dao.AccountDao;
import com.mobilecourse.backend.entity.Account;
import com.mobilecourse.backend.utils.ResultModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@EnableAutoConfiguration
//设置此参数可以给这个类的所有接口都加上前缀
@RequestMapping("/account")
public class AccountController extends CommonController {

    @Autowired
    private AccountDao accountDao;

    @RequestMapping(value = "/login", method = { RequestMethod.POST })
    public ResponseEntity<ResultModel> login(@RequestBody Account account) {
        List<Account> login = null;
        System.out.print("login");
        if(account.getUsername() != null && account.getPassword() != null)
            login = accountDao.login(account.getUsername(), account.getPassword()); // 前端应保证传来的都不为null
        else{
            return wrapperErrorResp(ResultModel.LOGIN_FAIL, "username or password can't be null!");
        }
        if(login == null || login.size() == 0) {
            return wrapperErrorResp(ResultModel.LOGIN_FAIL, "can't find "+ account.getUsername() +" or password wrong!");
        }
        Account data = login.get(0);
        data.setPassword(null);// 将密码处理为空
        //System.out.print("login");
        return wrapperOKResp(data);
    }

    @RequestMapping(value = "/register", method = { RequestMethod.POST })
    public ResponseEntity<ResultModel> register(@RequestBody Account account) {
        // 如果对应参数没有传的话，则会默认为null
        // TODO 发送邮箱验证码验证
        if(account.getUsername()==null || account.getPassword() == null || account.getEmail() == null)
            return wrapperErrorResp(ResultModel.REGISTER_FAIL, "username or password or email can't be null!");
        try {
            List<Account> accounts = accountDao.getUser(account.getUsername());
            if(accounts!= null && accounts.size() >= 1){
                return wrapperErrorResp(ResultModel.ACCOUNT_ALREADY_EXISTS, account.getUsername() + " already exists.");
            }
            accountDao.register(account);
        } catch (Exception e){
            return wrapperErrorResp(ResultModel.REGISTER_FAIL, e.getMessage());
        }
        return wrapperOKResp(account);
    }
    // TODO 用户修改用户名、密码、之类的。
}
