package com.taehun.controller;

import com.taehun.dto.PostDTO;
import com.taehun.entity.Comment;
import com.taehun.entity.Post;
import com.taehun.entity.User;
import com.taehun.service.CommentService;
import com.taehun.service.PostService;
import com.taehun.service.UserService;
import com.taehun.utils.Utilities;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/posts")
public class PostController {

    @Autowired
    private PostService postService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private UserService userService;

    private static final int PAGE_SIZE = 5;

    // 게시글 목록 및 검색 기능
    @GetMapping
    public String listPosts(@RequestParam(value = "page", defaultValue = "1") int page, 
                            @RequestParam(value = "search", required = false) String search, 
                            Model model) {
        if (search != null && !search.isEmpty()) {
            List<PostDTO> posts = postService.searchPostsByUsername(search, page, PAGE_SIZE);
            long totalPosts = postService.countPostsByUsername(search);
            int totalPages = (int) Math.ceil((double) totalPosts / PAGE_SIZE);

            model.addAttribute("posts", posts);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("search", search);
        } else {
            long totalPosts = postService.countPosts();
            int totalPages = (int) Math.ceil((double) totalPosts / PAGE_SIZE);
            List<PostDTO> posts = postService.findPostsByPage(page, PAGE_SIZE);

            model.addAttribute("posts", posts);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", totalPages);
        }

        return "post/list";
    }

    // 게시글 상세 조회
    @GetMapping("/{id}")
    public String getPostById(@PathVariable("id") Long id, Model model) {
        PostDTO post = postService.findById(id);
        if (post == null) {
            return "post/not_found";
        }

        List<Comment> comments = commentService.findCommentsByPostId(id);
        model.addAttribute("comments", comments);
        model.addAttribute("post", post);
        model.addAttribute("comment", new Comment()); // 댓글 객체 추가

        return "post/detail";
    }

    // 게시글 수정 폼 표시
    @GetMapping("/{id}/edit")
    public String showEditPostForm(@PathVariable("id") Long id, Model model) {
        PostDTO post = postService.findById(id);
        if (post == null) {
            return "post/not_found";
        }
        model.addAttribute("post", post);
        return "post/edit";
    }

    // 게시글 수정 처리
    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable("id") Long id, 
                             @Valid @ModelAttribute("post") PostDTO postDTO, 
                             BindingResult result, Model model) {
        if (result.hasErrors()) {
            return "post/edit";
        }
        postService.update(postDTO);
        model.addAttribute("post", postService.findById(id));
        return "redirect:/posts/" + id;
    }

    // 게시글 작성 폼 표시
    @GetMapping("/new")
    public String showCreatePostForm(Model model) {
        model.addAttribute("post", new PostDTO());
        return "post/new";
    }

    // 게시글 작성 처리
    @PostMapping
    public String createPost(@Valid @ModelAttribute("post") PostDTO postDTO, 
                             BindingResult result, HttpServletRequest request) {
        if (result.hasErrors()) {
            return "post/new";
        }
        String clientIp = Utilities.getClientIp(request); 
        postDTO.setUsername(clientIp); 

        postService.post(postDTO); 
        return "redirect:/posts";
    }

    // 댓글 추가 처리
    @PostMapping("/{postId}/comments")
    @Transactional
    public String addCommentToPost(@PathVariable("postId") Long postId, 
                                   @Valid @ModelAttribute("comment") Comment comment, 
                                   BindingResult result, 
                                   HttpServletRequest request, 
                                   Model model) {
        if (result.hasErrors()) {
            return "redirect:/posts/" + postId;
        }

        Post post = postService.findPostById(postId);
        if (post == null) {
            return "post/not_found";
        }

        // IP 주소 설정
        String clientIp = Utilities.getClientIp(request);
        comment.setIpAddress(clientIp);
        
        // 사용자 정보를 기반으로 User 객체 생성
        User user = new User();
        user.setUsername(comment.getName());
        user.setEmail(comment.getEmail());

        // User를 먼저 저장
        userService.save(user);

        // 저장된 User ID를 Comment에 설정
        comment.setUser(user);
        comment.setPost(post); 

        commentService.saveComment(postId, comment);

        return "redirect:/posts/" + postId;
    }

    // 게시글 삭제 처리
    @PostMapping("/{id}/delete")
    public String deletePost(@PathVariable("id") Long id) {
        postService.delete(id);
        return "redirect:/posts";
    }
    
    @PostMapping("/{postId}/comments/{commentId}/delete")
    public String deleteComment(@PathVariable("postId") Long postId, 
                                 @PathVariable("commentId") Long commentId) {
        commentService.deleteComment(commentId); // 댓글 삭제 서비스 호출
        return "redirect:/posts/" + postId; // 댓글 삭제 후 게시글 상세 페이지로 리다이렉트
    }
}
