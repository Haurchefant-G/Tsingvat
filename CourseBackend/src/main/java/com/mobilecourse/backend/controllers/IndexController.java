package com.mobilecourse.backend.controllers;

import com.mobilecourse.backend.dao.AccountDao;
import com.mobilecourse.backend.entity.Account;
import com.mobilecourse.backend.utils.ResultModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@EnableAutoConfiguration
public class IndexController extends CommonController {
    @Autowired
    AccountDao accountDao;

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
}
