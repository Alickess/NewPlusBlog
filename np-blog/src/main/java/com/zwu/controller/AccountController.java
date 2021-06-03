package com.zwu.controller;


import cn.hutool.http.HttpUtil;
import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.zwu.blog.entity.RelationUserAndRole;
import com.zwu.blog.entity.User;
import com.zwu.common.result.Result;
import com.zwu.common.utils.BCryptPasswordEncoderUtils;
import com.zwu.service.RelationUserAndRoleService;
import com.zwu.service.UserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Api(tags = "登陆接口")
@RestController
@RequestMapping("/account")
public class AccountController {

    @Resource
    private UserService userService;

    @Resource
    private RelationUserAndRoleService relationUserAndRoleService;

    @ApiOperation(value = "登陆")
    @PostMapping("/login")
    public Result login(@RequestBody User user) {
        //根据前端发送过来的账号和密码去申请token
        Map<String,Object> map = new HashMap<>();
        map.put("client_id","c1");
        map.put("client_secret","secret");
        map.put("username",user.getUsername());
        map.put("password",user.getPassword());
        map.put("grant_type","password");


        //申请token
        String tokenData = HttpUtil.post("http://localhost:9527/oauth/token", map);
        Map tokenMap = JSON.parseObject(tokenData);
        Object token = tokenMap.get("access_token");
        String tokenStr = (String) token;

        //通过token得到用户信息
        Map<String,Object> map2 = new HashMap<>();
        map2.put("token",tokenStr);
        String userData = HttpUtil.post("http://localhost:9527/oauth/check_token", map2);
        Map userMap = JSON.parseObject(userData);
        Object userInfo = userMap.get("user_name");
        String userInfoStr = (String) userInfo;
        Map userInfoMap = JSON.parseObject(userInfoStr);
        userInfoMap.put("password","");

        Object scope = userMap.get("scope");
        List scopeList = (List) scope;

        Object authorities = userMap.get("authorities");
        List authoritiesList = (List) authorities;

        //封装成一个map发送到前端
        Map<String,Object> map3 = new HashMap<>();

        //将token和用户信息放在map集合中，发送到前端
        map3.put("token",tokenStr);
        map3.put("userInfo",userInfoMap);
        map3.put("scope",scopeList);
        map3.put("authorities",authoritiesList);


//        System.out.println("这个是用JSON类的parseObject来解析JSON字符串!!!");
//        for (Object obj : userInfoMap.keySet()){
//            System.out.println("key为："+obj+"值为："+userInfoMap.get(obj));
//        }
        return Result.success(map3);
    }

    @ApiOperation(value = "注册")
    @PostMapping("/register")
    public Result register(@RequestBody User user) {
        //密码加密
        String password = BCryptPasswordEncoderUtils.encodePassword(user.getPassword());
        user.setPassword(password);
        //保存用户
        userService.save(user);
        User one = userService.getOne(Wrappers.<User>lambdaQuery().eq(User::getUsername, user.getUsername()));
        //用户角色创建
        RelationUserAndRole relationUserAndRole = new RelationUserAndRole();
        relationUserAndRole.setUserId(one.getId());
        relationUserAndRole.setRoleId(2L);
        relationUserAndRoleService.save(relationUserAndRole);
        return Result.success();
    }


}
