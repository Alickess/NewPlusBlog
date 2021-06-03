package com.zwu.blog.vo;

import com.zwu.blog.entity.Permission;
import com.zwu.blog.entity.Role;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
@Data
public class RoleVO extends Role {
    private List<Permission> permissionList;
}
