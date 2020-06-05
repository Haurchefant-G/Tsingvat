package com.mobilecourse.backend.controllers;

import com.mobilecourse.backend.dao.AccountDao;
import com.mobilecourse.backend.entity.Account;
import com.mobilecourse.backend.utils.ResultModel;
import com.mobilecourse.backend.utils.ResultStatus;
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
    private AccountDao accountDao;

    @RequestMapping(value = "/login", method = { RequestMethod.POST })
    public ResponseEntity<ResultModel> login(@RequestBody Account account) {
        List<Account> login = null;
        if(account.getUsername() != null && account.getPassword() != null)
            login = accountDao.login(account.getUsername(), account.getPassword()); // 前端应保证传来的都不为null
        if(login == null || login.size() == 0)
            return new ResponseEntity(ResultModel.error(ResultStatus.LOGIN_FAIL),HttpStatus.NOT_FOUND);
        Account data = login.get(0);
        data.setPassword(null);// 将密码处理为空
        return ResponseEntity.ok(ResultModel.ok(data));
    }

    @RequestMapping(value = "/register", method = { RequestMethod.POST })
    public ResponseEntity<ResultModel> register(@RequestBody Account account) {
        // 如果对应参数没有传的话，则会默认为null
        // TODO 发送邮箱验证码验证
        if(account.getUsername()==null || account.getPassword() == null)
            return new ResponseEntity<>(ResultModel.error(ResultStatus.RESGISTER_FAIL), HttpStatus.BAD_REQUEST);
        accountDao.register(account);
        return ResponseEntity.ok(ResultModel.ok(account));
    }

    @RequestMapping(value = "/followers", method = {RequestMethod.GET})
    public ResponseEntity<ResultModel> getFollower(@RequestParam String username) {
        List<Account> accounts = accountDao.getFollowers(username);
        return ResponseEntity.ok(ResultModel.ok(accounts));
    }

    @RequestMapping(value = "/followings", method = {RequestMethod.GET})
    public ResponseEntity<ResultModel> getFollowings(@RequestParam String username) {
        List<Account> accounts = accountDao.getFollowings(username);
        return ResponseEntity.ok(ResultModel.ok(accounts));
    }
    // TODO 用户修改用户名、密码、之类的。
}
