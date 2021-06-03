package com.zwu;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.Map;

@FeignClient("securityServer")
public interface SecurityFeignClient {

    @PostMapping(value = "/oauth/token",headers = {"Content-Type: multipart/form-data"})
    public Object token(@RequestBody Map map);

    @PostMapping(value = "/oauth/check_token",headers = {"Content-Type: multipart/form-data"})
    public Object check_token(@RequestBody Map map);
}
