package com.mobilecourse.backend.entity;

import java.sql.Timestamp;

public class Deal extends Post {
    public Timestamp getDdl() {
        return ddl;
    }

    public void setDdl(Timestamp ddl) {
        this.ddl = ddl;
    }

    // 交易最晚接受时间
    private Timestamp ddl;
}
