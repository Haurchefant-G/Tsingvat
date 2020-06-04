package com.mobilecourse.backend.controllers;

import com.mobilecourse.backend.dao.PostDao;
import com.mobilecourse.backend.entity.Post;
import com.mobilecourse.backend.utils.ResultModel;
import javafx.geometry.Pos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@EnableAutoConfiguration
//设置此参数可以给这个类的所有接口都加上前缀
@RequestMapping("/post")
public class PostController extends CommonController {
    @Autowired
    private PostDao postDao;

    @RequestMapping(value="/user", method = {RequestMethod.GET})
    public ResponseEntity<ResultModel> getPosts(@RequestParam String username){
        List<Post> posts =  postDao.getPosts(username);
        Post post = posts.get(0);
        ResultModel resultModel = ResultModel.ok(post);
        return new ResponseEntity<>(resultModel, HttpStatus.OK);
    }
}
