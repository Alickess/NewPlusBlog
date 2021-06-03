package com.zwu.blog.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;


import java.io.Serializable;


@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@ApiModel(description = "博客设置")
@TableName("blog")
public class Blog extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "用户id")
    @TableField("user_id")
    private Long userId;

    @ApiModelProperty(value = "博客标题")
    @TableField("title")
    private String title;

    @ApiModelProperty(value = "博客描述")
    @TableField("description")
    private String description;

    @ApiModelProperty(value = "博客内容")
    @TableField("content")
    private String content;

    @ApiModelProperty(value = "博客状态(1:开启，0:关闭)")
    @TableField("status")
    private Integer status;


}
