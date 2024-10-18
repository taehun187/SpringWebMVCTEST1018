package com.taehun.service.impl;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.taehun.dao.CommentDao;
import com.taehun.entity.Comment;
import com.taehun.entity.Post;
import com.taehun.service.CommentService;

@Service
@Transactional
public class CommentServiceImpl implements CommentService {

    @Inject
    private CommentDao commentDao;

    // 댓글 저장 메서드 구현
    @Override
    public void saveComment(Long postId, Comment comment) {
        Post post = commentDao.findPostById(postId); // Post 객체를 직접 조회
        if (post != null) {
            comment.setPost(post);   // 댓글에 게시글 설정
            commentDao.save(comment); // Comment 저장
        }
    }

    // 게시글 ID로 댓글들을 조회하는 메서드 구현
    @Override
    public List<Comment> findCommentsByPostId(Long postId) {
        Post post = commentDao.findPostById(postId);
        return commentDao.findAllCommentsByPost(post); // Post에 해당하는 댓글 목록 조회
    }

    // 댓글 ID로 조회
    @Override
    public Comment findById(Long commentId) {
        return commentDao.findById(commentId);
    }

    // 댓글 업데이트
    @Override
    public void updateComment(Comment comment) {
        commentDao.update(comment);
    }

    // 댓글 삭제
    @Override
    public void deleteComment(Long commentId) {
        Comment comment = commentDao.findById(commentId);
        if (comment != null) {
            commentDao.delete(comment);
        }
    }
}
