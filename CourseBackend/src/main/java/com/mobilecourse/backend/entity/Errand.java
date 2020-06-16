package com.mobilecourse.backend.entity;

import java.sql.Timestamp;

// 跑腿任务
public class Errand extends Post {
    // 起始地址和结束地址
    private String from;
    private String to;

    // 记录taker的username
    private String taker;

    private Timestamp ddl;
}
