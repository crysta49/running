package com.srpost.cm.bo.base.user;

import java.util.List;
import java.util.Map;

import com.srpost.salmon.bean.BasePagerBean;

/**
 * 고객 정보 서비스 인터페이스
 *
 * @author  finkle
 * @date    2014-11-24
 * @since   2.0
 */
public interface IUserService {

    BasePagerBean list(UserBean bean);
    
    List<Map<String, Object>> listExcel(UserBean bean);
    
    UserBean view(UserBean bean);
    
    UserBean view(UserBean bean, int purporse);
    
    String insertAction(UserBean bean);

    int updateAction(UserBean bean);

    int deleteAction(UserBean bean);
    
    int userKeyCnt(String userKey);
    
    List<UserLogBean> listLog(String userKey);
}
