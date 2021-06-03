package com.zwu.controller;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zwu.blog.annotation.MyLog;
import com.zwu.blog.entity.SystemLog;
import com.zwu.common.result.Result;
import com.zwu.service.SystemLogService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@Api(tags = "系统日志接口")
@RestController
@RequestMapping("/systemLog")
public class SystemLogController {
    @Resource
    private SystemLogService systemLogService;

    @MyLog(value="查看日志列表")
    @ApiOperation(value = "查看日志列表")
    @GetMapping("/list")
    @PreAuthorize("hasAuthority('p1')")
    public Result list(@RequestParam(defaultValue = "1") Integer currentPage,@RequestParam(defaultValue = "10") Integer pageSize, @RequestParam(defaultValue = " ") String searchObj) {
        Page page = new Page(currentPage, pageSize);
        IPage pageData = systemLogService.page(page, Wrappers.<SystemLog>lambdaQuery().like(StringUtils.isNotBlank(searchObj), SystemLog::getUsername, searchObj).orderByDesc(SystemLog::getCreateTime));
        return Result.success(pageData);
    }
}
