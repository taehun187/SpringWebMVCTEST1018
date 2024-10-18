package com.taehun.dao;

import java.util.List;

import com.taehun.entity.FileEntity;
import com.taehun.entity.Post;

public interface FileDao {
    void save(FileEntity file);
    FileEntity findById(Long id);
    List<FileEntity> findAllByPost(Post post);
}