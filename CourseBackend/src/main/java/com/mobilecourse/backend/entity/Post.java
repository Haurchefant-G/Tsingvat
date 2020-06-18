package com.mobilecourse.backend.entity;

import java.sql.Timestamp;
import java.util.UUID;

public class Post {
    // 暂时先做没有图片的
    private String uuid;
    private String username;
    private Timestamp created;
    private String content;


    public void setUsername(String username) {
        this.username = username;
    }

    public String getUsername() {
        return username;
    }

    public Timestamp getCreated() {
        return created;
    }

    public String getContent() {
        return content;
    }

    public String getUuid() {
        return uuid;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setCreated(Timestamp created) {
        this.created = created;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }
}
