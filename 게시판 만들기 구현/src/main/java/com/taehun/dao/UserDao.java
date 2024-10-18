package com.taehun.dao;

import com.taehun.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;

@Repository
public class UserDao {

    @PersistenceContext
    private EntityManager entityManager;

    public User findByUsername(String username) {
        String query = "from User where username = :username";
        try {
            return entityManager.createQuery(query, User.class)
                                .setParameter("username", username)
                                .getSingleResult();
        } catch (Exception e) {
            return null;  // User가 없을 경우 null 반환
        }
    }

    public void save(User user) {
        entityManager.persist(user);
    }
}
