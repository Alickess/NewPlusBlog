package com.zwu.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.zwu.blog.annotation.MyLog;
import com.zwu.blog.vo.RoleVO;
import com.zwu.common.result.Result;
import com.zwu.service.RoleService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@Api(tags = "角色接口")
@RestController
@RequestMapping("/role")
public class RoleController {
    @Resource
    private RoleService roleService;

    //新接口
    //查找所有角色
    @MyLog(value="查看角色列表")
    @ApiOperation(value = "查看角色列表")
    @GetMapping("/findAll")
    @PreAuthorize("hasAuthority('p2')")
    public Result findAll(@RequestParam(defaultValue = "1") Integer currentPage,@RequestParam(defaultValue = "100") Integer pageSize){
        IPage<RoleVO> all = roleService.findAll(currentPage, pageSize);
        return Result.success(all);
    }

    //根据角色id查找具体详情
    @MyLog(value="根据角色id查看具体角色")
    @ApiOperation(value = "根据角色id查看具体角色")
    @GetMapping("/findById")
    @PreAuthorize("hasAuthority('p2')")
    public Result findById(@RequestParam Long id) {
        RoleVO roleVO = roleService.findById(id);
        Assert.notNull(roleVO, "该角色不存在或已被删除");
        return Result.success(roleVO);
    }

    @MyLog(value="新增角色")
    @ApiOperation(value = "新增角色")
    @PostMapping("/singleSave")
    @PreAuthorize("hasAuthority('p2')")
    public Result singleSave(@RequestBody RoleVO roleVO){
        RoleVO roleVO1 = roleService.singleSave(roleVO);
        return Result.success(roleVO1);
    }

    @MyLog(value="更新用户")
    @ApiOperation(value = "更新用户")
    @PutMapping("/singleUpdate")
    @PreAuthorize("hasAuthority('p2')")
    public Result singleUpdate(@RequestBody RoleVO roleVO) {
        RoleVO roleVO1 = roleService.singleUpdate(roleVO);
        return Result.success(roleVO1);
    }

    @MyLog(value="单个删除用户")
    @ApiOperation(value = "单个删除用户")
    @DeleteMapping("/singleDelete")
    @PreAuthorize("hasAuthority('p2')")
    public Result singleDelete(Long id) {
        roleService.singleDelete(id);
        return Result.success();
    }

}
