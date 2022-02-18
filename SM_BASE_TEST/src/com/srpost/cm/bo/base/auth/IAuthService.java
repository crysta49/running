package com.srpost.cm.bo.base.auth;

import java.util.List;
import java.util.Map;

/**
 * 내부단 권한 서비스 인터페이스
 *
 * @author  finkle
 * @date    2014-11-06
 * @since   3.0
 */
public interface IAuthService {

    List<AuthBean> list();
    
    AuthBean view(AuthBean bean);

    int insertAction(AuthBean bean);

    int updateAction(AuthBean bean);

    int deleteAction(AuthBean bean);

    List<Map<String, Object>> listAuthItemAll(AuthBean bean);
    
    int crudAction(Integer authCd, String[] updates);
    
    List<AuthAssignBean> listAuthAssign(String mgrId);
    
    int updateAuthAssignAction(String mgrId, String[] authCds);
    
    List<AuthAssignLogBean> listAuthAssignLog(String mgrId);
    
    
    List<AuthBean> listAuthByLogin(String mgrId);
    
    List<AuthItemBean> listAuthItemByLogin(String mgrId);
}
