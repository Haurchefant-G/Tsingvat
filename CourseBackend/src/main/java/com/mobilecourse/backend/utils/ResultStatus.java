package com.mobilecourse.backend.utils;

import org.springframework.http.HttpStatus;

public enum ResultStatus {
    SUCCESS(20,"success"),
    LOGIN_SUCCESS(20, "登录成功"),
    LOGIN_FAIL(21,"登录失败"),
    RESGISTER_FAIL(22,"登录失败"),
    RESGISTER_SUCCESS(23,"登录失败");

    private int code;
    private String msg;
    ResultStatus(int code, String msg){
        this.code = code;
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
