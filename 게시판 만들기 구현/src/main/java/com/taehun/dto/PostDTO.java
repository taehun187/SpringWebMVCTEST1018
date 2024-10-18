package com.taehun.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PostDTO {
    private Long id;       // 게시글 ID
    private String title;   // 게시글 제목
    private String content; // 게시글 내용
    private String username; // 작성자 이름
    private String email;   // 이메일 필드 (선택 사항)
    private Long userId;    // 작성자 User ID
    private String web;
    
    // 필요한 생성자 추가
    public PostDTO(Long id, String title, String content, String username) {
        this.id = id;
        this.title = title;
        this.content = content; 
        this.username = username;
    }
}
