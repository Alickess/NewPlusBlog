package com.zwu.service;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.zwu.blog.entity.Permission;
import com.zwu.dao.PermissionDao;
import com.zwu.dao.UserDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Administrator
 * @version 1.0
 **/
@Service
public class SpringDataUserDetailsService implements UserDetailsService {

    @Autowired
    UserDao userDao;

    @Autowired
    PermissionDao permissionDao;

    //根据 账号查询用户信息
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        //根据账号查询用户信息
        com.zwu.blog.entity.User user = userDao.selectOne(Wrappers.<com.zwu.blog.entity.User>lambdaQuery().eq(com.zwu.blog.entity.User::getUsername, username));
        if(user == null){
            //如果用户查不到，返回null，由provider来抛出异常
            return null;
        }
        //根据用户的id查询用户的权限
        List<Permission> permissionList = permissionDao.findByUserId(user.getId());
        List<String> permissionsCode = new ArrayList<>();
        permissionList.forEach(c -> permissionsCode.add(c.getCode()));
        //将permissions转成数组
        String[] permissionArray = new String[permissionsCode.size()];
        permissionsCode.toArray(permissionArray);
        //将userDto转成json
        String principal = JSON.toJSONString(user);
        UserDetails userDetails = User.withUsername(principal).password(user.getPassword()).authorities(permissionArray).build();
        return userDetails;
    }
}
