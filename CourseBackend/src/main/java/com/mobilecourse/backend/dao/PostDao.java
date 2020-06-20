package com.mobilecourse.backend.dao;

import com.mobilecourse.backend.entity.Post;
import com.mobilecourse.backend.entity.Reply;

import java.sql.Timestamp;
import java.util.List;

public interface PostDao {
    List<Post> test();

    List<Post> getIndexPosts(Timestamp time, int num);

    // TODO 是否应该只取出一部分，或者在返回的数据中只给出一部分
    List<Post> getPosts(String username);

    List<Post> getPost(String uuid);

    void createPost(Post post);

    void modifyPost(Post post);

    void deletePost(String uuid);
}
