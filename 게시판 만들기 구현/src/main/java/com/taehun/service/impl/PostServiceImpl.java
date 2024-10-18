package com.taehun.service.impl;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.taehun.dao.PostDao;
import com.taehun.dto.PostDTO;
import com.taehun.entity.Post;
import com.taehun.entity.User;
import com.taehun.service.PostService;
import com.taehun.service.UserService;

@Service
@Transactional
public class PostServiceImpl implements PostService {

    @Autowired
    private PostDao postDao;

    @Autowired
    private UserService userService;

    @Override
    public List<PostDTO> searchPostsByUsername(String username, int page, int pageSize) {
        List<Post> posts = postDao.searchPostsByUsername(username, page, pageSize);
        return posts.stream()
                .map(post -> new PostDTO(post.getId(), post.getTitle(), post.getText(), post.getUser().getUsername()))
                .collect(Collectors.toList());
    }

    @Override
    public long countPostsByUsername(String username) {
        return postDao.countPostsByUsername(username);
    }

    @Override
    public List<PostDTO> findPostsByPage(int page, int pageSize) {
        List<Post> posts = postDao.findPostsByPage((page - 1) * pageSize, pageSize);
        return posts.stream()
                .map(post -> new PostDTO(post.getId(), post.getTitle(), post.getText(), post.getUser().getUsername()))
                .collect(Collectors.toList());
    }

    @Override
    public long countPosts() {
        return postDao.countPosts();
    }

    @Override
    public void post(PostDTO postDTO) {
        Post post = new Post();
        post.setTitle(postDTO.getTitle());
        post.setText(postDTO.getContent());

        User user = userService.findByUsername(postDTO.getUsername());
        if (user == null) {
            user = new User(postDTO.getUsername(), postDTO.getEmail());
            userService.save(user);
        }
        post.setUser(user);
        postDao.save(post);
    }

    @Override
    public PostDTO findById(Long id) {
        Post post = postDao.findById(id);
        if (post != null) {
            return new PostDTO(post.getId(), post.getTitle(), post.getText(), post.getUser().getUsername());
        }
        return null;
    }

    @Override
    public void update(PostDTO postDTO) {
        Post post = postDao.findById(postDTO.getId());
        if (post != null) {
            post.setTitle(postDTO.getTitle());
            post.setText(postDTO.getContent());
            postDao.update(post);
        }
    }

    @Override
    public void delete(Long postId) {
        Post post = postDao.findById(postId);
        if (post != null) {
            postDao.delete(post);
        }
    }
    @Override
    public Post findPostById(Long postId) {
        return postDao.findById(postId); // PostDao의 findById 메서드를 호출
    }
}
