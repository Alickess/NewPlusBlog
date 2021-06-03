package com.zwu.listener;

import cn.hutool.core.bean.BeanUtil;
import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.event.AnalysisEventListener;
import com.zwu.blog.ExcelVO.UserExcelVO;
import com.zwu.blog.entity.RelationUserAndRole;
import com.zwu.blog.entity.User;
import com.zwu.common.utils.BCryptPasswordEncoderUtils;
import com.zwu.dao.RelationUserAndRoleMapper;
import com.zwu.dao.UserMapper;

public class UserListener extends AnalysisEventListener<UserExcelVO> {

    private UserMapper userMapper;

    private RelationUserAndRoleMapper relationUserAndRoleMapper;

    public UserListener(UserMapper userMapper,RelationUserAndRoleMapper relationUserAndRoleMapper){
        this.userMapper=userMapper;
        this.relationUserAndRoleMapper = relationUserAndRoleMapper;
    }

    @Override
    public void invoke(UserExcelVO userExcelVO, AnalysisContext analysisContext) {
        User user = new User();
        BeanUtil.copyProperties(userExcelVO,user);
        user.setPassword(BCryptPasswordEncoderUtils.encodePassword(user.getPassword()));
        userMapper.insert(user);
        RelationUserAndRole relationUserAndRole = new RelationUserAndRole();
        relationUserAndRole.setUserId(user.getId());
        //导入时默认给他用户角色
        relationUserAndRole.setRoleId(4L);
        relationUserAndRoleMapper.insert(relationUserAndRole);

    }

    @Override
    public void doAfterAllAnalysed(AnalysisContext analysisContext) {

    }
}
