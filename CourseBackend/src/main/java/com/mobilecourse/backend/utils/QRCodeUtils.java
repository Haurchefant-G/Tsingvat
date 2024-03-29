package com.mobilecourse.backend.utils;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.nio.file.Path;
import java.util.HashMap;

import javax.imageio.ImageIO;

import org.springframework.stereotype.Component;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.BinaryBitmap;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.Result;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.common.HybridBinarizer;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

@Component
public class QRCodeUtils {

    public static void createUser(String username){
        createQRCode(username);
        createAvatar(username);
    }

    public static void createAvatar(String username){
        String defaultAvatarPath = Global.BASE_FILE_PATH+Global.DEFAULT_AVATAR;
        String dirPath=Global.BASE_FILE_PATH + Global.ACCOUNT_DIR + "/" + username;
        File file = new File(dirPath);
        if(!file.exists() && !file.isDirectory()){
            file.mkdir();
        }
        String destPath = dirPath + "/avatar.png";
        try {
            copyFileUsingFileChannels(new File(defaultAvatarPath), new File(destPath));
        }catch (Exception e){
            e.printStackTrace();
        }
    }


    private static void copyFileUsingFileChannels(File source, File dest) throws IOException {
        FileChannel inputChannel = null;
        FileChannel outputChannel = null;
        try {
            inputChannel = new FileInputStream(source).getChannel();
            outputChannel = new FileOutputStream(dest).getChannel();
            outputChannel.transferFrom(inputChannel, 0, inputChannel.size());
        } finally {
            inputChannel.close();
            outputChannel.close();
        }
    }


    public static void createQRCode(String username){
        String filePath=Global.BASE_FILE_PATH + Global.ACCOUNT_DIR + "/" + username;
        File file = new File(filePath);
        if(!file.exists() && !file.isDirectory()){
            file.mkdir();
        }
        createQRCode(filePath + "/qrcode.png", username);
    }


    private static void createQRCode(String filePath, String content) {
        //图片的宽度
        int width=300;
        //图片的高度
        int height=300;
        //图片的格式
        String format="png";
//        String content="风间影月";     //内容

        /**
         * 定义二维码的参数
         */
        HashMap hints=new HashMap();
        //指定字符编码为“utf-8”
        hints.put(EncodeHintType.CHARACTER_SET,"utf-8");
        //指定二维码的纠错等级为中级
        hints.put(EncodeHintType.ERROR_CORRECTION,ErrorCorrectionLevel.M);
        //设置图片的边距
        hints.put(EncodeHintType.MARGIN, 2);

        /**
         * 生成二维码
         */
        try {
            BitMatrix bitMatrix=new MultiFormatWriter().encode(content, BarcodeFormat.QR_CODE, width, height,hints);
            Path file=new File(filePath).toPath();
            MatrixToImageWriter.writeToPath(bitMatrix, format, file);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String getContentFromQRCode(String filePath) {
        MultiFormatReader formatReader=new MultiFormatReader();
        File file=new File(filePath);
        BufferedImage image;
        try {
            image = ImageIO.read(file);
            BinaryBitmap binaryBitmap=new BinaryBitmap(new HybridBinarizer
                    (new BufferedImageLuminanceSource(image)));
            HashMap hints=new HashMap();
            //指定字符编码为“utf-8”
            hints.put(EncodeHintType.CHARACTER_SET,"utf-8");
            Result result=formatReader.decode(binaryBitmap,hints);
            return result.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void main(String[] args){
        String filePath = Global.BASE_FILE_PATH + "/qrcode/" + "qrcode.png";
        createQRCode(filePath, "zxj");
        String content = getContentFromQRCode(filePath);
    }
}

