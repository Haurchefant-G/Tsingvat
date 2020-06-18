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

    /**
    * 上述login和register使用的是post,以下为get，这样就不会有出现二义性
    **/

    @RequestMapping(value = "/{username}",method = {RequestMethod.GET})
    public ResponseEntity<ResultModel> getUser(@PathVariable("username") String username){
        List<Account> accounts = accountDao.getUser(username);
        if(accounts == null || accounts.size() == 0)
            return wrapperErrorResp(ResultModel.ACCOUNT_NOT_FOUND,"can't find user: "+username);
        return wrapperOKResp(accounts.get(0));
    }

    @RequestMapping(value = "/{username}/followers", method = {RequestMethod.GET})
    public ResponseEntity<ResultModel> getFollower(@PathVariable("username") String username) {
        List<Account> accounts = accountDao.getFollowers(username);
        return wrapperOKResp(accounts);
    }

    @RequestMapping(value = "/{username}/followings", method = {RequestMethod.GET})
    public ResponseEntity<ResultModel> getFollowings(@PathVariable("username") String username) {
        List<Account> accounts = accountDao.getFollowings(username);
        return wrapperOKResp(accounts);
    }
    // TODO 用户修改用户名、密码、之类的。
}
