package com.mobilecourse.backend.entity;

import java.sql.Timestamp;

public class Deal extends Post {
    // 交易最晚接受时间
    private Timestamp ddl;
    private double price;
    private String taker;
    private Timestamp takeTime;

    public Timestamp getTakeTime() {
        return takeTime;
    }

    public void setTakeTime(Timestamp takeTime) {
        this.takeTime = takeTime;
    }

    public String getTaker() {
        return taker;
    }

    public void setTaker(String taker) {
        this.taker = taker;
    }

    public Timestamp getDdl() {
        return ddl;
    }

    public void setDdl(Timestamp ddl) {
        this.ddl = ddl;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
