package com.mobilecourse.backend.dao;

import com.mobilecourse.backend.entity.Post;
import javafx.geometry.Pos;

import java.util.List;

public interface PostDao {
    int test();

    // TODO 是否应该只取出一部分，或者在返回的数据中只给出一部分
    List<Post> getPosts(String username);

    void createPost(Post post);
}
