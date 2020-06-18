package com.mobilecourse.backend.entity;

import java.sql.Timestamp;

// 跑腿任务
public class Errand extends Post {
    // 起始地址和结束地址
    private String fromAddr = null;
    private String toAddr = null;

    // 记录taker的username
    private String taker = null;
    private Timestamp takeTime = null;

    private Timestamp ddl = null;

    public String getFromAddr() {
        return fromAddr;
    }

    public void setFromAddr(String fromAddr) {
        this.fromAddr = fromAddr;
    }

    public String getTaker() {
        return taker;
    }

    public void setTakeTime(Timestamp takeTime) {
        this.takeTime = takeTime;
    }
}
