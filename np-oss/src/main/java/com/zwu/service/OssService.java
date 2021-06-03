package com.zwu.service;

import org.springframework.web.multipart.MultipartFile;

public interface OssService {
    String uploadAvatar(MultipartFile file);
    String uploadBlogImage(MultipartFile file);
}
