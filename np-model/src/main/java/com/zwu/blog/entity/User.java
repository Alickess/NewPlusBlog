package com.zwu.blog.entity;

import com.alibaba.excel.annotation.ExcelProperty;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;


import java.io.Serializable;


@Data
@ApiModel(description = "用户设置")
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("user")
public class User extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "账号")
    @TableField("username")
    private String username;

    @ApiModelProperty(value = "密码")
    @TableField("password")
    private String password;

    @ApiModelProperty(value = "头像")
    @TableField("avatar")
    private String avatar;

    @ApiModelProperty(value = "昵称")
    @TableField("fullName")
    private String fullName;

    @ApiModelProperty(value = "手机信息")
    @TableField("mobile")
    private String mobile;

    @ApiModelProperty(value = "邮箱信息")
    @TableField("email")
    private String email;

    @ApiModelProperty(value = "用户状态(1:开启，0:关闭)")
    @TableField("status")
    private Integer status;




}
