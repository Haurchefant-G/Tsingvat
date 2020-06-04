package com.mobilecourse.backend.controllers;

import com.mobilecourse.backend.dao.AccountDao;
import com.mobilecourse.backend.entity.Account;
import com.mobilecourse.backend.utils.ResultModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@EnableAutoConfiguration
//设置此参数可以给这个类的所有接口都加上前缀
@RequestMapping("/account")
public class AccountController extends CommonController {

    @Autowired
    private AccountDao accountMapper;

    // 普通请求，不指定method意味着接受所有类型的请求
    @RequestMapping(value = "/hello")
    public ResponseEntity<ResultModel> hello() {
        int cnt = accountMapper.test();
        return new ResponseEntity<>(ResultModel.ok(cnt),HttpStatus.OK);
    }


    @RequestMapping(value = "/login", method = { RequestMethod.POST })
    public ResponseEntity<ResultModel> login(@RequestBody Account account) {
        List<Account> login = null;
        if(account.getUsername() != null && account.getPassword() != null) {
            // 前端应保证传来的都不为null
            login = accountMapper.login(account.getUsername(), account.getPassword());
        }
        if(login == null || login.size() == 0)
            return new ResponseEntity<>(ResultModel.error(ResultModel.ResultStatus.LOGIN_FAIL),HttpStatus.NOT_FOUND);
        if(login.size() == 1){
            Account data = login.get(0);
            data.setPassword(null);
            return new ResponseEntity<>(ResultModel.ok(data),HttpStatus.OK);
        } else{
            // TODO 说明出现重复主键，应当删除其中一个，但是应该不会
        }
        return new ResponseEntity<>(ResultModel.error(ResultModel.ResultStatus.LOGIN_FAIL),HttpStatus.NOT_FOUND);
    }

    @RequestMapping(value = "/register", method = { RequestMethod.POST })
    public ResponseEntity<ResultModel> register(@RequestBody Account account) {
        // 如果对应参数没有传的话，则会默认为null
        // TODO 发送邮箱验证码验证
        String username = account.getUsername();
        accountMapper.register(account);
        return new ResponseEntity<>(ResultModel.ok(),HttpStatus.OK);
    }

    // TODO 用户修改用户名、密码、之类的。
}
