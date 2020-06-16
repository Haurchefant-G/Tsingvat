package com.mobilecourse.backend.controllers;

import com.mobilecourse.backend.dao.PostDao;
import com.mobilecourse.backend.entity.Post;
import com.mobilecourse.backend.entity.Reply;
import com.mobilecourse.backend.utils.ResultModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@RestController
@EnableAutoConfiguration
//设置此参数可以给这个类的所有接口都加上前缀
@RequestMapping("/post")
public class PostController extends CommonController {
    @Autowired
    private PostDao postDao;

    // 获取当前用户的所有post
    @RequestMapping(value="/user", method = {RequestMethod.GET})
    public ResponseEntity<ResultModel> getPosts(@RequestParam String username){
        List<Post> posts =  postDao.getPosts(username);
        return ResponseEntity.ok(ResultModel.ok(posts));
    }

    // 创建post
    @RequestMapping(value="/create", method = {RequestMethod.POST})
    public ResponseEntity<ResultModel> createPost(@RequestBody Post post){
        Timestamp time = new Timestamp(new Date().getTime());
        String uuid = UUID.randomUUID().toString();
        post.setCreated(time);
        post.setUuid(uuid);
        postDao.createPost(post);
        return ResponseEntity.ok(ResultModel.ok());
    }

    @RequestMapping(value = "/replies", method = {RequestMethod.GET})
    public ResponseEntity<ResultModel> getReplies(@RequestParam String postUuid){
        List<Reply> replies = postDao.getReplies(postUuid);
        return ResponseEntity.ok(ResultModel.ok(replies));
    }

    @RequestMapping(value = "/create_reply", method = {RequestMethod.POST})
    public ResponseEntity<ResultModel> createReply(@RequestBody Reply reply){
        postDao.createReply(reply);
        return ResponseEntity.ok(ResultModel.ok());
    }

}
