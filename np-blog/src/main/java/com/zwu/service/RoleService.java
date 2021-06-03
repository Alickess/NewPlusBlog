package com.zwu.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.zwu.blog.entity.Role;
import com.zwu.blog.vo.RoleVO;
import com.zwu.blog.vo.UserVO;

import java.util.List;

public interface RoleService extends IService<Role> {
    public IPage<RoleVO> findAll(Integer currentPage, Integer pageSize);

    public RoleVO findById(Long id);

    public void singleDelete(Long id);

    public RoleVO singleUpdate(RoleVO roleVO);

    public RoleVO singleSave(RoleVO roleVO);
}
