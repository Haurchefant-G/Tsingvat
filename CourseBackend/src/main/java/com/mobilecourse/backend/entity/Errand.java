package com.mobilecourse.backend.entity;

import java.sql.Timestamp;

// 跑腿任务
public class Errand extends Post {
    // 起始地址和结束地址
    private String fromAddr;
    private String toAddr;
    private String sfromAddr;
    private String stoAddr;
    private Timestamp ddlTime;
    private double bonus;
    private String phone;
    private String details;

    // 记录taker的username
    private String taker;
    private Timestamp takeTime;
    private Timestamp finishTime;

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }


    public String getSfromAddr() {
        return sfromAddr;
    }

    public void setSfromAddr(String sfromAddr) {
        this.sfromAddr = sfromAddr;
    }

    public String getStoAddr() {
        return stoAddr;
    }

    public void setStoAddr(String stoAddr) {
        this.stoAddr = stoAddr;
    }

    public Timestamp getDdlTime() {
        return ddlTime;
    }

    public void setDdlTime(Timestamp ddlTime) {
        this.ddlTime = ddlTime;
    }

    public void setTaker(String taker) {
        this.taker = taker;
    }

    public Timestamp getTakeTime() {
        return takeTime;
    }

    public Timestamp getFinishTime() {
        return finishTime;
    }

    public void setFinishTime(Timestamp finishTime) {
        this.finishTime = finishTime;
    }

    public double getBonus() {
        return bonus;
    }

    public void setBonus(double bonus) {
        this.bonus = bonus;
    }

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
        this.takeTime = takeTime;
    }
}
