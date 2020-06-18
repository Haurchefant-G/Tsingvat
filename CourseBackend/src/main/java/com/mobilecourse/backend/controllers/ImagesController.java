package com.mobilecourse.backend.controllers;


import com.mobilecourse.backend.utils.FileUtils;
import com.mobilecourse.backend.utils.ResultModel;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController
@EnableAutoConfiguration
//设置此参数可以给这个类的所有接口都加上前缀
@RequestMapping("/images")
public class ImagesController extends CommonController{
    // 保存post/errand/deal等的图片，根据uuid建立目录储存文件
    @RequestMapping(value="/{uuid}", method = {RequestMethod.POST})
    public ResponseEntity<ResultModel> uploadImages(
            @RequestParam("images") MultipartFile[] multipartFiles, @PathVariable("uuid") String uuid) throws IOException {
        FileUtils.saveFiles(multipartFiles, "/image/"+uuid);
        return wrapperOKResp(null);
    }

    @RequestMapping(value="/{uuid}", method = {RequestMethod.GET})
    public ResponseEntity<ResultModel> getImages(@PathVariable("uuid") String uuid) throws IOException {
        return wrapperOKResp(null);
    }

    // 存储用户的头像
    @RequestMapping(value="/avatar/{username}", method = {RequestMethod.POST})
    public ResponseEntity<ResultModel> uploadAvatar(
            @RequestParam("image") MultipartFile multipartFile, @PathVariable("username") String uuid) throws IOException {
        FileUtils.saveFile(multipartFile, "/avatar/"+uuid, "avatar.png");
        return wrapperOKResp(null);
    }

}
