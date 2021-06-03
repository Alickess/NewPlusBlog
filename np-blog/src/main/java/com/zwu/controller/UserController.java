package com.zwu.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.zwu.blog.annotation.MyLog;
import com.zwu.blog.entity.User;
import com.zwu.blog.vo.UserVO;
import com.zwu.common.result.Result;
import com.zwu.service.UserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.List;


@Api(tags = "用户接口")
@RestController
@RequestMapping("/user")
public class UserController {
    @Resource
    private UserService userService;

    @MyLog(value = "查看用户列表")
    @ApiOperation(value = "查看用户列表")
    @GetMapping("/findAll")
    @PreAuthorize("hasAuthority('p2')")
    public Result findAll(@RequestParam(defaultValue = "1") Integer currentPage, @RequestParam(defaultValue = "5") Integer pageSize, @RequestParam(defaultValue = "") String searchObj1, @RequestParam(defaultValue = "") String searchObj2) {
        IPage<UserVO> all = userService.findAll(currentPage, pageSize, searchObj1, searchObj2);
        return Result.success(all);
    }

    @MyLog(value = "根据用户id查看具体用户")
    @ApiOperation(value = "根据用户id查看具体用户")
    @GetMapping("/findById")
    @PreAuthorize("hasAuthority('p2')")
    public Result findById(@RequestParam Long id) {
        UserVO userVO = userService.findById(id);
        Assert.notNull(userVO, "该用户不存在或已被删除");
        return Result.success(userVO);
    }


    @ApiOperation(value = "根据用户账号查看是否存在账号")
    @GetMapping("/findByUsername")
    public Result findByUsername(@RequestParam String username) {
        int count = userService.count(Wrappers.<User>lambdaQuery().eq(User::getUsername, username));
        return Result.success(count);
    }

    @MyLog(value = "新增用户")
    @ApiOperation(value = "新增用户")
    @PostMapping("/singleSave")
    @PreAuthorize("hasAuthority('p2')")
    public Result singleSave(@RequestBody UserVO userVO) {
        UserVO userVO1 = userService.singleSave(userVO);
        return Result.success(userVO1);
    }

    @MyLog(value = "更新用户")
    @ApiOperation(value = "更新用户")
    @PutMapping("/singleUpdate")
    @PreAuthorize("hasAnyAuthority('p2','p3')")
    public Result singleUpdate(@RequestBody UserVO userVO) {
        UserVO userVO1 = userService.singleUpdate(userVO);
        return Result.success(userVO1);
    }

    @MyLog(value = "单个删除用户")
    @ApiOperation(value = "单个删除用户")
    @DeleteMapping("/singleDelete")
    @PreAuthorize("hasAuthority('p2')")
    public Result singleDelete(Long id) {
        userService.singleDelete(id);
        return Result.success();
    }

    @MyLog(value = "批量删除用户")
    @ApiOperation(value = "批量删除用户")
    @DeleteMapping("/batchDelete")
    @PreAuthorize("hasAuthority('p2')")
    public Result batchDelete(@RequestBody List<Long> idList) {
        userService.batchDelete(idList);
        return Result.success();
    }

    //导出数据字典接口
    @ApiOperation(value = "导出用户数据Excel")
    @GetMapping("/exportUser")
    @PreAuthorize("hasAuthority('p2')")
    public void exportUser(HttpServletResponse response) {
        userService.exportUser(response);
    }

    //导入数据字典
    @ApiOperation(value = "导入用户数据Excel")
    @PostMapping("/importUser")
    @PreAuthorize("hasAuthority('p2')")
    public Result importUser(MultipartFile file) {
        userService.importUser(file);
        return Result.success();
    }
}
