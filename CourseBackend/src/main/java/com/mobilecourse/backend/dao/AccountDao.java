package com.mobilecourse.backend.dao;

import com.mobilecourse.backend.model.Account;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AccountDao {

    // 通过id查找Account
    Account selectById(String id);

    int login(String id, String pwd);

    // 查找
    List<Account> selectAll();

    // 统计
    int testCnt();

    // 插入，可以指定类为输入的参数
    void insert(Account account);

    // 删除
    void delete(int id);

    // 更新, 可以使用param对参数进行重新命名，则mapper解析按照重新命名以后的参数名进行
    int updatePwd(@Param("username")int username, String pwd);

}
