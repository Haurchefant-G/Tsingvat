package com.mobilecourse.backend.entity;

import java.sql.Timestamp;

// 跑腿任务
public class Errand extends Post {
    // 起始地址和结束地址
    private String fromAddr;
    private String toAddr;

    // 记录taker的username
    private String taker;

    private Timestamp ddl;

    private double bonus;

    public String getToAddr() {
        return toAddr;
    }

    public void setToAddr(String toAddr) {
        this.toAddr = toAddr;
    }

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
    }
}
