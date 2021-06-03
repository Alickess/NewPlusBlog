package com.zwu.controller;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zwu.blog.annotation.MyLog;
import com.zwu.blog.entity.Blog;
import com.zwu.common.result.Result;
import com.zwu.common.result.ResultCodeEnum;
import com.zwu.service.BlogService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Api(tags = "博客接口接口")
@RestController
@RequestMapping("/blog")
public class BlogController {
    @Resource
    private BlogService blogService;


    //博客列表
    @ApiOperation(value = "博客列表")
    @GetMapping("/list")
    public Result list(@RequestParam(defaultValue = "1") Integer currentPage,@RequestParam(defaultValue = "10") Integer pageSize,@RequestParam(defaultValue = "") String searchObj){
        Page page = new Page(currentPage, pageSize);
        IPage pageData = blogService.page(page, Wrappers.<Blog>lambdaQuery().like(StringUtils.isNotBlank(searchObj), Blog::getTitle, searchObj).orderByDesc(Blog::getCreateTime));
        return Result.success(pageData);
    }

    //我的博客列表
    @MyLog(value="查看我的博客")
    @ApiOperation(value = "查看我的博客")
    @GetMapping("/myList")
    @PreAuthorize("hasAuthority('p3')")
    public Result myList(@RequestParam(defaultValue = "1") Integer currentPage,@RequestParam(defaultValue = "7") Integer pageSize,@RequestParam(defaultValue = "") String searchObj,@RequestParam Long userId){
        Page page = new Page(currentPage, pageSize);
        IPage pageData = blogService.page(page, Wrappers.<Blog>lambdaQuery().eq(Blog::getUserId,userId).like(StringUtils.isNotBlank(searchObj), Blog::getTitle, searchObj).orderByDesc(Blog::getId));
        return Result.success(pageData);
    }

    //查看具体信息
    @GetMapping("/{id}")
    @ApiOperation(value = "根据博客id查看具体博客")
    public Result detail(@PathVariable(name = "id") Long id) {
        Blog blog = blogService.getById(id);
        Assert.notNull(blog, "该博客不存在或已被删除");
        return Result.success(blog);
    }

    //修改
    @MyLog(value="修改博客内容")
    @ApiOperation(value = "修改博客内容")
    @PreAuthorize("hasAuthority('p3')")
    @PostMapping("/update")
    public Result update(@RequestBody Blog blog){
        blogService.updateById(blog);
        return Result.success(null);
    }

    //新增
    @MyLog(value="新增博客")
    @ApiOperation(value = "新增博客")
    @PreAuthorize("hasAuthority('p3')")
    @PostMapping("/save")
    public Result save(@RequestBody Blog blog){
        Map userMap = JSON.parseObject((String) SecurityContextHolder.getContext().getAuthentication().getPrincipal());
        blog.setUserId(Long.valueOf((Integer) userMap.get("id")));
        blogService.save(blog);
        return Result.success(null);
    }

    @MyLog(value="删除博客")
    @ApiOperation(value = "删除博客")
    @DeleteMapping("/deleteById")
    @PreAuthorize("hasAuthority('p3')")
    public Result deleteById(@RequestBody  Blog blog){
        blogService.removeById(blog.getId());
        return Result.success();
    }

    @MyLog(value="批量删除博客")
    @ApiOperation(value = "批量删除博客")
    @DeleteMapping("/deleteByIds")
    @PreAuthorize("hasAuthority('p3')")
    public Result deleteByIds(@RequestBody List<Long> idList){
        blogService.removeByIds(idList);
        return Result.success();
    }
}
