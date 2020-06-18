package com.mobilecourse.backend.entity;

public class Reply extends Post {

    private String parent;

    public String getParent() {
        return parent;
    }

    public void setParent(String parent) {
        this.parent = parent;
    }
}
