package com.zwu.blog.vo;

import com.zwu.blog.entity.User;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
@Data
public class UserVO extends User {
    private Long roleId;
    private String roleName;
    private String description;
}
