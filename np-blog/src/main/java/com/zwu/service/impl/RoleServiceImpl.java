package com.zwu.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zwu.blog.entity.Permission;
import com.zwu.blog.entity.RelationRoleAndPermission;
import com.zwu.blog.entity.RelationUserAndRole;
import com.zwu.blog.entity.Role;
import com.zwu.blog.vo.RoleVO;
import com.zwu.blog.vo.UserVO;
import com.zwu.dao.RelationRoleAndPermissionMapper;
import com.zwu.dao.RelationUserAndRoleMapper;
import com.zwu.dao.RoleMapper;
import com.zwu.service.RoleService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Comparator;
import java.util.List;

@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {
    @Resource
    private RoleMapper roleMapper;

    @Resource
    private RelationUserAndRoleMapper relationUserAndRoleMapper;

    @Resource
    private RelationRoleAndPermissionMapper relationRoleAndPermissionMapper;

    @Override
    public IPage<RoleVO> findAll(Integer currentPage, Integer pageSize) {
        Page<UserVO> page = new Page<>(currentPage, pageSize);
        return roleMapper.findAll(page);
    }

    @Override
    public RoleVO findById(Long id) {
        return roleMapper.findById(id);
    }

    @Override
    public void singleDelete(Long id) {
        roleMapper.deleteById(id);
        relationRoleAndPermissionMapper.delete(Wrappers.<RelationRoleAndPermission>lambdaQuery()
                .eq(RelationRoleAndPermission::getRoleId,id));
        //删除角色时，默认给他用户角色
        relationUserAndRoleMapper.update(null, Wrappers.<RelationUserAndRole>lambdaUpdate()
                        .eq(RelationUserAndRole::getRoleId,id)
                        .set(RelationUserAndRole::getRoleId,4));
    }

    @Override
    public RoleVO singleUpdate(RoleVO roleVO) {
        //得到没修改前和修改后的permissionList
        List<Permission> oldPermissionList = roleMapper.findById(roleVO.getId()).getPermissionList();
        List<Permission> newPermissionList = roleVO.getPermissionList();
        //如果不同
//      if(!oldPermissionList.equals(newPermissionList)){
        if(!oldPermissionList.containsAll(newPermissionList)){
            //先删除旧的
            relationRoleAndPermissionMapper.delete(Wrappers.<RelationRoleAndPermission>lambdaQuery()
                    .eq(RelationRoleAndPermission::getRoleId,roleVO.getId()));
            for (Permission permission:newPermissionList) {
                //添加新的
                RelationRoleAndPermission relationRoleAndPermission = new RelationRoleAndPermission();
                relationRoleAndPermission.setRoleId(roleVO.getId());
                relationRoleAndPermission.setPermissionId(permission.getId());
                relationRoleAndPermissionMapper.insert(relationRoleAndPermission);
            }
        }
        //更新信息
        roleMapper.updateById(roleVO);
        return roleMapper.findById(roleVO.getId());
    }

    @Override
    public RoleVO singleSave(RoleVO roleVO) {
        roleMapper.insert(roleVO);
        return roleVO;
    }
}
