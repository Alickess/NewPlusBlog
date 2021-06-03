package com.zwu.dao;


import com.zwu.blog.entity.Permission;
import java.util.List;


public interface PermissionDao{
    public List<Permission> findByUserId(Long userId);
}
