package com.mobilecourse.backend.dao;

import com.mobilecourse.backend.entity.Errand;
import org.mockito.internal.verification.Times;

import java.sql.Timestamp;
import java.util.List;

public interface ErrandDao {
    void createErrand(Errand errand);

    // 获取自己发布的跑腿信息
    List<Errand> getErrands(String username);

    // 获取自己接单的跑腿信息
    List<Errand> getTakeErrands(String taker);

    // taker接单,应当记录更新的接单时间和接单人
    void takeErrand(Errand errand);

    void finishErrand(Errand errand);

    void modifyErrand(Errand errand);

    void deleteErrand(String uuid);
}
