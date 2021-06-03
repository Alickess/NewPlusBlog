package com.zwu.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zwu.blog.entity.User;
import com.zwu.blog.vo.UserVO;
import org.apache.ibatis.annotations.Param;


public interface UserMapper extends BaseMapper<User> {
    public IPage<UserVO> findAll(Page page,@Param("searchObj1") String searchObj1,@Param("searchObj2") String searchObj2);

    public UserVO findById(Long id);

}
