package com.taehun.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.taehun.dao.PostDao;
import com.taehun.entity.Post;

import java.util.List;

@Repository
@Transactional
public class PostDaoImpl implements PostDao {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public void save(Post entity) {
        entityManager.persist(entity);
    }

    @Override
    public void update(Post entity) {
        entityManager.merge(entity);
    }

    @Override
    public void delete(Post entity) {
        entityManager.remove(entityManager.contains(entity) ? entity : entityManager.merge(entity));
    }

    @Override
    public Post findById(Long id) {
        return entityManager.find(Post.class, id);
    }

    @Override
    public List<Post> findAll() {
        return entityManager.createQuery("from Post", Post.class).getResultList();
    }

    @Override
    public List<Post> findPostsByPage(int offset, int pageSize) {
        return entityManager.createQuery("from Post", Post.class)
                .setFirstResult(offset)
                .setMaxResults(pageSize)
                .getResultList();
    }

    @Override
    public long countPosts() {
        return entityManager.createQuery("select count(p) from Post p", Long.class).getSingleResult();
    }

    @Override
    public List<Post> searchPostsByUsername(String username, int page, int pageSize) {
        String query = "from Post p where p.user.username like :username";
        return entityManager.createQuery(query, Post.class)
                .setParameter("username", "%" + username + "%")
                .setFirstResult((page - 1) * pageSize)
                .setMaxResults(pageSize)
                .getResultList();
    }

    @Override
    public long countPostsByUsername(String username) {
        String query = "select count(p) from Post p where p.user.username like :username";
        return entityManager.createQuery(query, Long.class)
                .setParameter("username", "%" + username + "%")
                .getSingleResult();
    }

    @Override
    public List<Post> findAllWithComments() {
        return entityManager.createQuery(
                "select p from Post p join fetch p.comments", Post.class)
                .getResultList();
    }
}
