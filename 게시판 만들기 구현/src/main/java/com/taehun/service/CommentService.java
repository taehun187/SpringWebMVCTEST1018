package com.taehun.service;

import com.taehun.entity.Comment;
import java.util.List;

public interface CommentService {
    // 댓글 저장 메서드
    void saveComment(Long postId, Comment comment);

    // 게시글 ID로 해당하는 댓글 조회
    List<Comment> findCommentsByPostId(Long postId);

    // 댓글 ID로 조회
    Comment findById(Long commentId);

    // 댓글 업데이트
    void updateComment(Comment comment);

    // 댓글 삭제
    void deleteComment(Long commentId);
}
