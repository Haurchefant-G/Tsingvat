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

    public enum ResultStatus {
        SUCCESS(20,"success"),
        LOGIN_SUCCESS(20, "登录成功"),
        LOGIN_FAIL(21,"登录失败");

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
}
