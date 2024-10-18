package com.taehun.dao;

import java.util.List;

import com.taehun.entity.Post;

public interface PostDao extends Dao<Post> {

    List<Post> findAllWithComments();
    
    List<Post> findPostsByPage(int offset, int pageSize); // 페이징 처리된 게시글 조회

    long countPosts(); // 전체 게시글 개수 조회

    // 검색 기능 추가
    List<Post> searchPostsByUsername(String username, int page, int pageSize);

    long countPostsByUsername(String username);
}
