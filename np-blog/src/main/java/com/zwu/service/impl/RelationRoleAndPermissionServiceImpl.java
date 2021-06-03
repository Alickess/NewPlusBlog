package com.zwu.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zwu.blog.entity.RelationRoleAndPermission;
import com.zwu.dao.RelationRoleAndPermissionMapper;
import com.zwu.service.RelationRoleAndPermissionService;
import org.springframework.stereotype.Service;

@Service
public class RelationRoleAndPermissionServiceImpl extends ServiceImpl<RelationRoleAndPermissionMapper, RelationRoleAndPermission> implements RelationRoleAndPermissionService {
}
