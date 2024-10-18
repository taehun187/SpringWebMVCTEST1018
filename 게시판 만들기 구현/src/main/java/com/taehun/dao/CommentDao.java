package com.taehun.dao;

import com.taehun.entity.Comment;
import com.taehun.entity.Post;
import java.util.List;

public interface CommentDao {

    void save(Comment entity);  // 댓글 저장
    void update(Comment entity); // 댓글 업데이트
    void delete(Comment entity); // 댓글 삭제
    Comment findById(Long id);   // ID로 댓글 조회
    List<Comment> findAll();     // 모든 댓글 조회

    // 특정 Post에 해당하는 모든 댓글을 찾는 메서드
    List<Comment> findAllCommentsByPost(Post post);
    
    // Post 객체를 조회하는 메서드 추가
    Post findPostById(Long postId);
}
