package com.zwu.blog.ExcelVO;

import com.alibaba.excel.annotation.ExcelProperty;
import lombok.Data;


@Data
public class UserExcelVO {

    @ExcelProperty(value = "账号")
    private String username;

    @ExcelProperty(value = "密码")
    private String password;

    @ExcelProperty(value = "头像")
    private String avatar;

    @ExcelProperty(value = "昵称")
    private String fullName;

    @ExcelProperty(value = "手机号")
    private String mobile;

    @ExcelProperty(value = "邮箱")
    private String email;

    @ExcelProperty(value = "状态")
    private Integer status;
}
