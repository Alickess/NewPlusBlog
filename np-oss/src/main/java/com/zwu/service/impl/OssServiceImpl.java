package com.zwu.service.impl;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.zwu.service.OssService;

import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.io.InputStream;
import java.util.UUID;

@Service
public class OssServiceImpl implements OssService {
    //读取配置文件内容
    @Value("${aliyun.oss.file.endpoint}")
    private String endpoint;

    @Value("${aliyun.oss.file.keyId}")
    private String keyId;

    @Value("${aliyun.oss.file.keySecret}")
    private String keySecret;

    @Value("${aliyun.oss.file.bucketName}")
    private String bucketName;

    @Override
    public String uploadAvatar(MultipartFile file) {
        try {
            OSS ossClient = new OSSClientBuilder().build(endpoint, keyId, keySecret);


            InputStream inputStream = file.getInputStream();

            //获取文件名称
            String fileName=file.getOriginalFilename();
            //在文件名称里边添加一个随机唯一的值
            String uuid= UUID.randomUUID().toString().replaceAll("-","");
            fileName=uuid+fileName;
            //文件按日期分类存到oss
            //获取当前的日期
            String datePath=new DateTime().toString("yyyy/MMM/dd");
            fileName="用户头像"+"/"+datePath+"/"+fileName;

            ossClient.putObject(bucketName,fileName, inputStream);

            ossClient.shutdown();
            //返回路径
            String url="https://"+bucketName+"."+endpoint+"/"+fileName;
            System.out.println(url);
            return url;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public String uploadBlogImage(MultipartFile file) {
        try {
            OSS ossClient = new OSSClientBuilder().build(endpoint, keyId, keySecret);

            InputStream inputStream = file.getInputStream();

            //获取文件名称
            String fileName=file.getOriginalFilename();
            //在文件名称里边添加一个随机唯一的值
            String uuid= UUID.randomUUID().toString().replaceAll("-","");
            fileName=uuid+fileName;
            //文件按日期分类存到oss
            //获取当前的日期
            String datePath=new DateTime().toString("yyyy/MMM/dd");
            fileName="博客图片"+"/"+datePath+"/"+fileName;

            ossClient.putObject(bucketName,fileName, inputStream);

            ossClient.shutdown();
            //返回路径
            String url="https://"+bucketName+"."+endpoint+"/"+fileName;
            System.out.println(url);
            return url;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
}
