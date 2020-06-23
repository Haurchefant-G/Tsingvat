package com.mobilecourse.backend.utils;

public class ResultModel {

    public static int SUCCESS = 10;

    public static int TOKEN_WRONG = 11;

    // 每个dao对应一个范围内的error_code
    public static int ACCOUNT_NOT_FOUND = 21;
    public static int ACCOUNT_ALREADY_EXISTS = 22;
    public static int LOGIN_FAIL = 23;
    public static int REGISTER_FAIL = 24;


    public static int ERRAND_TAKE_FAIL = 41;

    public static int REPLY_NOT_FOUND = 16;

    public static int QUERY_FAIL = 51;

    /**
     * 返回码
     */
    private int code;
    /**
     * 返回结果描述
     */
    private String message;
    /**
     * 返回数据
     */
    private Object data;

    public ResultModel(int code, String message) {
        this.code = code;
        this.message = message;
        this.data = null;
    }

    public ResultModel(int code, String message, Object data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }


    public static ResultModel ok(Object data) {
        return new ResultModel(ResultModel.SUCCESS, "success", data);
    }

    public static ResultModel ok() {
        return new ResultModel(SUCCESS, "success");
    }

    public int getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    public Object getData() {
        return data;
    }

}
