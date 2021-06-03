package com.zwu;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableFeignClients
public class BlogServer {
    public static void main(String[] args){
        SpringApplication.run(BlogServer.class,args);
    }
}
