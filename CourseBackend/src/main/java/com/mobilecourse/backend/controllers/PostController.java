package com.mobilecourse.backend.controllers;

import com.mobilecourse.backend.dao.PostDao;
import com.mobilecourse.backend.entity.Post;
import com.mobilecourse.backend.utils.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.List;

@RestController
@EnableAutoConfiguration
//设置此参数可以给这个类的所有接口都加上前缀
@RequestMapping("/post")
public class PostController extends CommonController {
    @Autowired
    private PostDao postDao;

    // 创建post
    @RequestMapping(value="/create", method = {RequestMethod.POST})
    public ResponseEntity<ResultModel> createPost(@RequestBody Post post, HttpServletRequest request){
//        if (!checkRequest(request, post.getUsername())) return wrapperErrorResp(ResultModel.TOKEN_WRONG, "未登录");
        Timestamp time = this.getCurrentTime();
        String uuid = this.getUuid();
        post.setCreated(time);
        post.setUuid(uuid);
        postDao.createPost(post);
        return wrapperOKResp(post);
    }

    @RequestMapping(value="/modify", method = {RequestMethod.PUT})
    public ResponseEntity<ResultModel> modifyPost(@RequestBody Post post, HttpServletRequest request){
        Timestamp time = this.getCurrentTime();
        post.setCreated(time);
        postDao.modifyPost(post);
        return wrapperOKResp(post);
    }

    @RequestMapping(value="/delete", method = {RequestMethod.DELETE})
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

    @RequestMapping(value="", method={RequestMethod.GET})
    public ResponseEntity<ResultModel> getIndexPosts(@RequestParam(required = false) Timestamp time, @RequestParam(required = false) String num){
        if(time == null) time = this.getCurrentTime();
        int limit = 0;
        if(num == null) limit = Global.LIMIT_NUM;
        else limit = Integer.parseInt(num);
        List<Post> posts = postDao.getIndexPosts(time, limit);
        return wrapperOKResp(posts);
    }
}
