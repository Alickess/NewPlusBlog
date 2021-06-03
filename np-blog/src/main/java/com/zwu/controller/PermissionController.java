package com.zwu.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zwu.blog.annotation.MyLog;
import com.zwu.blog.entity.Permission;
import com.zwu.blog.entity.RelationRoleAndPermission;
import com.zwu.blog.entity.Role;
import com.zwu.blog.entity.User;
import com.zwu.common.result.Result;
import com.zwu.service.PermissionService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@Api(tags = "权限接口")
@RestController
@RequestMapping("/permission")
public class PermissionController {
    @Resource
    private PermissionService permissionService;

    @MyLog(value="查看权限列表")
    @ApiOperation(value = "查看权限列表")
    @GetMapping("/list")
    @PreAuthorize("hasAuthority('p2')")
    public Result list(@RequestParam(defaultValue = "1") Integer currentPage,@RequestParam(defaultValue = "10") Integer pageSize,@RequestParam(defaultValue = "") String searchObj){
        Page page = new Page(currentPage, pageSize);
        IPage pageData = permissionService.page(page, Wrappers.<Permission>lambdaQuery().like(Permission::getCode,searchObj).orderByAsc(Permission::getId));
        return Result.success(pageData);
    }

    //根据权限id来查找相应的权限
    @MyLog(value="根据权限id查看具体权限")
    @ApiOperation(value = "根据权限id查看具体权限")
    @GetMapping("/{id}")
    @PreAuthorize("hasAuthority('p2')")
    public Result detail(@PathVariable("id") Long id){
        Permission permission = permissionService.getById(id);
        return Result.success(permission);
    }

    @MyLog(value="新增权限")
    @ApiOperation(value = "新增权限")
    @PostMapping("/save")
    @PreAuthorize("hasAuthority('p2')")
    public Result save(@RequestBody Permission permission){
        permissionService.save(permission);
        return Result.success();
    }

    @MyLog(value="更新权限")
    @ApiOperation(value = "更新权限")
    @PutMapping("/update")
    @PreAuthorize("hasAuthority('p2')")
    public Result update(@RequestBody Permission permission){
        permissionService.updateById(permission);
        return Result.success();
    }

    @MyLog(value="删除权限")
    @ApiOperation(value = "删除权限")
    @DeleteMapping("/singleDelete")
    @PreAuthorize("hasAuthority('p2')")
    public Result singleDelete(Long id){
        permissionService.singleDelete(id);
        return Result.success();
    }

    @MyLog(value="批量删除博客")
    @ApiOperation(value = "批量删除博客")
    @DeleteMapping("/batchDelete")
    @PreAuthorize("hasAuthority('p2')")
    public Result batchDelete(@RequestBody List<Long> idList){
        permissionService.batchDelete(idList);
        return Result.success();
    }
}
