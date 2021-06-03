package com.zwu.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.zwu.blog.entity.User;
import com.zwu.blog.vo.UserVO;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

public interface UserService extends IService<User> {
    public IPage<UserVO> findAll(Integer currentPage, Integer pageSize,String searchObj1,String searchObj2);

    public UserVO findById(Long id);

    public void singleDelete(Long id);

    public void batchDelete(List<Long> idList);

    public UserVO singleUpdate(UserVO userVO);

    public UserVO singleSave(UserVO userVO);

    void exportUser(HttpServletResponse response);

    void importUser(MultipartFile file);
}
