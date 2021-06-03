package com.zwu.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zwu.blog.entity.Role;
import com.zwu.blog.vo.RoleVO;
import com.zwu.blog.vo.UserVO;


public interface RoleMapper extends BaseMapper<Role> {
    public IPage<RoleVO> findAll(Page page);

    public RoleVO findById(Long id);
}
