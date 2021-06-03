package com.zwu.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zwu.blog.entity.RelationUserAndRole;
import com.zwu.dao.RelationUserAndRoleMapper;
import com.zwu.service.RelationUserAndRoleService;
import org.springframework.stereotype.Service;

@Service
public class RelationUserAndRoleServiceImpl extends ServiceImpl<RelationUserAndRoleMapper, RelationUserAndRole> implements RelationUserAndRoleService {
}
