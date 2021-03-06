package com.zwu.service.impl;


import com.alibaba.excel.EasyExcel;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zwu.blog.ExcelVO.UserExcelVO;
import com.zwu.blog.entity.RelationUserAndRole;
import com.zwu.blog.entity.User;
import com.zwu.blog.vo.UserVO;
import com.zwu.common.utils.BCryptPasswordEncoderUtils;
import com.zwu.dao.RelationUserAndRoleMapper;
import com.zwu.dao.UserMapper;
import com.zwu.listener.UserListener;
import com.zwu.service.UserService;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Resource
    private UserMapper userMapper;

    @Resource
    private RelationUserAndRoleMapper relationUserAndRoleMapper;

    @Override
    public IPage<UserVO> findAll(Integer currentPage, Integer pageSize, String searchObj1, String searchObj2) {
        Page<UserVO> page = new Page<>(currentPage, pageSize);
        return userMapper.findAll(page, searchObj1, searchObj2);
    }

    @Override
    public UserVO findById(Long id) {
        return userMapper.findById(id);
    }

    @Override
    public void singleDelete(Long id) {
        userMapper.deleteById(id);
        relationUserAndRoleMapper.delete(Wrappers.<RelationUserAndRole>lambdaQuery().eq(RelationUserAndRole::getUserId, id));
    }

    @Override
    public void batchDelete(List<Long> idList) {
        for (Long id : idList) {
            userMapper.deleteById(id);
            relationUserAndRoleMapper.delete(Wrappers.<RelationUserAndRole>lambdaQuery().eq(RelationUserAndRole::getUserId, id));
        }
    }

    @Override
    public UserVO singleUpdate(UserVO userVO) {
        //??????????????????????????????
        if (!userMapper.findById(userVO.getId()).getPassword().equals(userVO.getPassword())) {
            userVO.setPassword(BCryptPasswordEncoderUtils.encodePassword(userVO.getPassword()));
        }
        //??????????????????????????????
        RelationUserAndRole relationUserAndRole = relationUserAndRoleMapper.selectOne(Wrappers.<RelationUserAndRole>lambdaQuery().eq(RelationUserAndRole::getUserId, userVO.getId()));
        //??????????????????????????????

        if (!relationUserAndRole.getRoleId().equals(userVO.getRoleId())) {
            relationUserAndRoleMapper.delete(Wrappers.<RelationUserAndRole>lambdaQuery().eq(RelationUserAndRole::getUserId, userVO.getId()));
            relationUserAndRole.setRoleId(userVO.getRoleId());
            relationUserAndRoleMapper.insert(relationUserAndRole);
        }
        //????????????
        userMapper.updateById(userVO);
        //??????????????????????????????????????????
        return userMapper.findById(userVO.getId());
    }

    @Override
    public UserVO singleSave(UserVO userVO) {
        userVO.setPassword(BCryptPasswordEncoderUtils.encodePassword(userVO.getPassword()));
        userMapper.insert(userVO);
        RelationUserAndRole relationUserAndRole = new RelationUserAndRole();
        relationUserAndRole.setUserId(userVO.getId());
        relationUserAndRole.setRoleId(userVO.getRoleId());
        relationUserAndRoleMapper.insert(relationUserAndRole);

        return userVO;
    }

    @Override
    public void exportUser(HttpServletResponse response) {
        //??????????????????
        response.setContentType("application/vnd.ms-excel");
        response.setCharacterEncoding("utf-8");
        String fileName = "user";
        response.setHeader("Content-disposition", "attachment;filename="+ fileName + ".xlsx");
        //???????????????
        List<User> userList = userMapper.selectList(null);

        //???????????????????????????
        try {
            EasyExcel.write(response.getOutputStream(), User.class).sheet("user")
                    .doWrite(userList);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //??????
    @Override
    public void importUser(MultipartFile file) {
        try {
            EasyExcel.read(file.getInputStream(), UserExcelVO.class,new UserListener(userMapper,relationUserAndRoleMapper)).sheet().doRead();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
