package com.mobilecourse.backend.utils;

public class ResultModel {
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
        this.data = "";
    }

    public ResultModel(int code, String message, Object data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }

    public ResultModel(ResultStatus status) {
        this.code = status.getCode();
        this.message = status.getMsg();
        this.data = "";
    }

    public ResultModel(ResultStatus status, Object data) {
        this.code = status.getCode();
        this.message = status.getMsg();
        this.data = data;
    }

    public static ResultModel ok(Object data) {
        return new ResultModel(ResultStatus.SUCCESS, data);
    }

    public static ResultModel ok() {
        return new ResultModel(ResultStatus.SUCCESS);
    }

    public static ResultModel error(ResultStatus error) {
        return new ResultModel(error);
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
