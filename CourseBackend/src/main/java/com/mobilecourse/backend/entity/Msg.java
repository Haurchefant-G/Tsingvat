package com.mobilecourse.backend.entity;

import java.sql.Timestamp;

public class Msg {
    private String uuid;
    private String sender;
    private String receiver;
    private String content;
    private Timestamp created;
    private int type;
    private boolean sent;

    public Msg(String uuid, String sender, String receiver, String content, Timestamp created, int type, boolean sent) {
        this.uuid = uuid;
        this.sender = sender;
        this.receiver = receiver;
        this.content = content;
        this.created = created;
        this.type = type;
        this.sent = sent;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public Timestamp getCreated() {
        return created;
    }

    public void setCreated(Timestamp created) {
        this.created = created;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public boolean isSent() {
        return sent;
    }

    public void setSent(boolean sent) {
        this.sent = sent;
    }
}
