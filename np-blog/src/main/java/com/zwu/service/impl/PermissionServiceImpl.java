package com.zwu.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zwu.blog.entity.Permission;
import com.zwu.blog.entity.RelationRoleAndPermission;
import com.zwu.blog.entity.RelationUserAndRole;
import com.zwu.dao.PermissionMapper;
import com.zwu.dao.RelationRoleAndPermissionMapper;
import com.zwu.service.PermissionService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class PermissionServiceImpl extends ServiceImpl<PermissionMapper, Permission>  implements PermissionService {
    @Resource
    private PermissionMapper permissionMapper;

    @Resource
    private RelationRoleAndPermissionMapper relationRoleAndPermissionMapper;

    @Override
    public void singleDelete(Long id) {
        permissionMapper.deleteById(id);
        relationRoleAndPermissionMapper.delete(Wrappers.<RelationRoleAndPermission>lambdaQuery().eq(RelationRoleAndPermission::getPermissionId,id));

    }

    @Override
    public void batchDelete(List<Long> idList) {
        for (Long id:idList) {
            permissionMapper.deleteById(id);
            relationRoleAndPermissionMapper.delete(Wrappers.<RelationRoleAndPermission>lambdaQuery().eq(RelationRoleAndPermission::getPermissionId,id));
        }

    }
}
