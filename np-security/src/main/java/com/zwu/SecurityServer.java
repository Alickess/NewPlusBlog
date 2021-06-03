package com.zwu;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
@MapperScan("com.zwu.dao")
public class SecurityServer {
    public static void main(String[] args){
        SpringApplication.run(SecurityServer.class,args);
    }
}
