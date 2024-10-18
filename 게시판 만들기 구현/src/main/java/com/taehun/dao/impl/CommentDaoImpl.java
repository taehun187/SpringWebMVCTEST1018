package com.taehun.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import com.taehun.dao.CommentDao;
import com.taehun.entity.Comment;
import com.taehun.entity.Post;

@Repository
public class CommentDaoImpl implements CommentDao {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public void save(Comment entity) {
        entityManager.persist(entity);
    }

    @Override
    public void update(Comment entity) {
        entityManager.merge(entity);
    }

    @Override
    public void delete(Comment entity) {
        entityManager.remove(entityManager.contains(entity) ? entity : entityManager.merge(entity));
    }

    @Override
    public Comment findById(Long id) {
        return entityManager.find(Comment.class, id);
    }

    @Override
    public List<Comment> findAllCommentsByPost(Post post) {
        String query = "SELECT c FROM Comment c WHERE c.post = :post";
        return entityManager.createQuery(query, Comment.class)
                .setParameter("post", post)
                .getResultList();
    }

    @Override
    public List<Comment> findAll() {
        return entityManager.createQuery("from Comment", Comment.class).getResultList();  // 모든 댓글 조회
    }

    @Override
    public Post findPostById(Long postId) {
        return entityManager.find(Post.class, postId);  // Post 조회
    }
}
