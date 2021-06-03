package com.zwu.controller;


import com.zwu.common.result.Result;
import com.zwu.service.OssService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;

@RestController
@RequestMapping("/oss")
public class OssController {
    @Autowired
    private OssService ossService;

    @PostMapping("/uploadAvatar")
    public Result uploadAvatar(MultipartFile file,MultipartHttpServletRequest mutiRequest) {
        System.out.println(mutiRequest.getFile("image"));
        //返回上传到oss的路径
        String url = ossService.uploadAvatar(file);
        return Result.success(url);
    }

    @PostMapping("/uploadBlogImage")
    public Result uploadBlogImage(MultipartHttpServletRequest mutiRequest) {
        System.out.println(mutiRequest.getFile("image"));
        //返回上传到oss的路径
        String url = ossService.uploadBlogImage(mutiRequest.getFile("image"));
        return Result.success(url);
    }

}
