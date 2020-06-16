package com.mobilecourse.backend.dao;

import com.mobilecourse.backend.entity.Errand;

import java.util.List;

public interface ErrandDao {
    // 获取自己发布的跑腿信息
    List<Errand> getErrands(String uuid);

    // 获取自己接单的跑腿信息
    List<Errand> getTakeErrands(String taker);

    // taker接单
    void updateTaker(String taker);
}
