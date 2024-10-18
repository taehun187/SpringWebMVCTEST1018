package com.taehun.service;

import com.taehun.dto.PostDTO;
import com.taehun.entity.Post;

import java.util.List;

public interface PostService {
    List<PostDTO> searchPostsByUsername(String username, int page, int pageSize);
    long countPostsByUsername(String username);
    List<PostDTO> findPostsByPage(int page, int pageSize);
    long countPosts();
    void post(PostDTO postDTO);
    PostDTO findById(Long id);  // 변경된 부분
    void update(PostDTO postDTO);
    void delete(Long postId);
    Post findPostById(Long postId);
}
