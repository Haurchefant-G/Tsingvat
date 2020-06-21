package com.mobilecourse.backend.dao;

import com.mobilecourse.backend.entity.Msg;

import java.util.List;

public interface MsgDao {
    void addMsg(Msg msg);

    void sendMsg(String uuid);

    List<Msg> getUnsendMsg(String receiver);
}
