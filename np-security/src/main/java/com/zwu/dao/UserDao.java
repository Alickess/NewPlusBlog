package com.zwu.dao;



import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.zwu.blog.entity.User;

public interface UserDao extends BaseMapper<User> {
    public User findByUsername(String username);
}
