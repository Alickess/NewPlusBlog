package com.zwu.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.zwu.blog.entity.Permission;

import java.util.List;

public interface PermissionService extends IService<Permission> {

    public void singleDelete(Long id);

    public void batchDelete(List<Long> idList);
}
