package com.zwu.service.impl;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zwu.blog.entity.SystemLog;
import com.zwu.blog.entity.User;
import com.zwu.dao.SystemLogMapper;
import com.zwu.dao.UserMapper;
import com.zwu.service.SystemLogService;
import com.zwu.service.UserService;
import org.springframework.stereotype.Service;


@Service
public class SystemLogServiceImpl extends ServiceImpl<SystemLogMapper, SystemLog> implements SystemLogService {

}
