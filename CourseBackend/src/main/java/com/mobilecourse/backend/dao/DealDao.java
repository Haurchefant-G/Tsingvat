package com.mobilecourse.backend.dao;

import com.mobilecourse.backend.entity.Deal;
import com.mobilecourse.backend.entity.Errand;

import java.util.List;

public interface DealDao {


    void createDeal(Deal deal);

    // 获取自己发布的跑腿信息
    List<Errand> getDeals(String username);

    // 获取自己接单的跑腿信息
    List<Errand> getTakeDeals(String taker);

    // taker接单,表示
    void takeDeal(Deal deal);

    void modifyDeal(Deal deal);

    void deleteDeal(String uuid);

}