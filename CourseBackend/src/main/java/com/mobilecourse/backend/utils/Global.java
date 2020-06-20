package com.mobilecourse.backend.utils;

import org.springframework.boot.system.ApplicationHome;

public class Global {
    // Windows:
//    public static String BASE_FILE_PATH = "C:/code/android/file";
    public static final String BASE_FILE_PATH = new ApplicationHome(Global.class).getSource().getParentFile().getParent();
    // Linux 发布
//    public static String BASE_FILE_PATH = "/root/backend";

    public static String ACCOUNT_DIR = "/account";

    public static String POST_DIR = "/post";

    public static int LIMIT_NUM = 10;

}
