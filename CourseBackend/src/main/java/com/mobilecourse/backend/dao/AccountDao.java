package com.mobilecourse.backend.dao;

import com.mobilecourse.backend.entity.Account;

import java.util.List;

public interface AccountDao {
    // 作为测试
    int test();

    List<Account> login(String username, String pwd);

    void register(Account account);

    List<Account> getFollowers(String username);

    List<Account> getFollowings(String username);

}
