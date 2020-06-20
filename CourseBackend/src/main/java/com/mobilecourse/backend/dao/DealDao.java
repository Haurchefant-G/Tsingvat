package com.mobilecourse.backend.dao;

import com.mobilecourse.backend.entity.Deal;
import com.mobilecourse.backend.entity.Errand;

import java.sql.Timestamp;
import java.util.List;

public interface DealDao {

    List<Deal> getIndexDeals(Timestamp time, int num);

    void createDeal(Deal deal);

    // 获取自己发布的跑腿信息
    List<Deal> getDeals(String username);

    // 获取自己接单的跑腿信息
    List<Deal> getTakeDeals(String taker);

    // taker接单,表示
    void takeDeal(Deal deal);

    void modifyDeal(Deal deal);

    void deleteDeal(String uuid);

}