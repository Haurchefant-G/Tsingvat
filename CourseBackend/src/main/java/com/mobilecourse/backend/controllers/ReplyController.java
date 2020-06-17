package com.mobilecourse.backend.controllers;

import com.mobilecourse.backend.dao.ReplyDao;
import com.mobilecourse.backend.entity.Reply;
import com.mobilecourse.backend.utils.ResultModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@EnableAutoConfiguration
//设置此参数可以给这个类的所有接口都加上前缀
@RequestMapping("/reply")
public class ReplyController extends CommonController {

    @Autowired
    ReplyDao replyDao;

    @RequestMapping(value = "/{parent}", method = {RequestMethod.GET})
    public ResponseEntity<ResultModel> getReplies(@PathVariable("parent") String parent){
        List<Reply> replies = replyDao.getReplies(parent);
        return wrapperOKResp(replies);
    }

    @RequestMapping(value = "", method = {RequestMethod.GET})
    public ResponseEntity<ResultModel> getReply(@RequestParam String uuid){
        List<Reply> replies = replyDao.getReply(uuid);
        if(replies==null ||  replies.size() == 0)
            return wrapperErrorResp(ResultModel.REPLY_NOT_FOUND, "no such reply");
        return wrapperOKResp(replies);
    }

    @RequestMapping(value = "", method = {RequestMethod.POST})
    public ResponseEntity<ResultModel> createReply(@RequestBody Reply reply){
        reply.setCreated(this.getCurrentTime());
        reply.setUuid(this.getUuid());
        replyDao.createReply(reply);
        return wrapperOKResp(reply);
    }
}
