package com.mobilecourse.backend.controllers;

import com.mobilecourse.backend.dao.PostDao;
import com.mobilecourse.backend.entity.Post;
import com.mobilecourse.backend.utils.FastDFSClient;
import com.mobilecourse.backend.utils.FileUtils;
import com.mobilecourse.backend.utils.ResultModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@RestController
@EnableAutoConfiguration
//设置此参数可以给这个类的所有接口都加上前缀
@RequestMapping("/post")
public class PostController extends CommonController {
    @Autowired
    private PostDao postDao;

    @RequestMapping(value="/image/", method = {RequestMethod.POST})
    public ResponseEntity<ResultModel> image(
            @RequestParam("images") MultipartFile[] multipartFiles,String uuid) throws IOException {
        FileUtils.saveImage(multipartFiles, uuid);
        return wrapperOKResp(null);
    }

    // 创建post
    @RequestMapping(value="", method = {RequestMethod.POST})
    public ResponseEntity<ResultModel> createPost(@RequestBody Post post){
        Timestamp time = this.getCurrentTime();
        String uuid = this.getUuid();
        post.setCreated(time);
        post.setUuid(uuid);
        postDao.createPost(post);
        return wrapperOKResp(post);
    }

    @RequestMapping(value="", method = {RequestMethod.PUT})
    public ResponseEntity<ResultModel> modifyPost(@RequestBody Post post){
        Timestamp time = this.getCurrentTime();
        post.setCreated(time);
        postDao.modifyPost(post);
        return wrapperOKResp(post);
    }

    @RequestMapping(value="", method = {RequestMethod.DELETE})
    public ResponseEntity<ResultModel> deletePost(@RequestParam String uuid){
        postDao.deletePost(uuid);
        return wrapperOKResp(null);
    }

    // 获取当前用户的所有post
    @RequestMapping(value="/{username}", method = {RequestMethod.GET})
    public ResponseEntity<ResultModel> getPosts(@PathVariable("username") String username){
        List<Post> posts =  postDao.getPosts(username);
        return wrapperOKResp(posts);
    }

}
