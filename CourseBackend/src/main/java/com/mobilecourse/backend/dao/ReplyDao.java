package com.mobilecourse.backend.dao;

import com.mobilecourse.backend.entity.Reply;

import java.util.List;

public interface ReplyDao {
    // 根据指定的Post/Errand/Deal/Reply的uuid获取他的所有回复
    List<Reply> getReplies(String parent);

    List<Reply> getReply(String uuid);

    // 发布评论
    void createReply(Reply reply);
}
