package com.srpost.cm.bo.base.auth;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 내부단 권한 서비스 구현체
 *
 * @author  finkle
 * @date    2014-11-06
 * @since   3.0
 */
@Service
public class AuthServiceImpl extends EgovAbstractServiceImpl implements IAuthService {

    @Resource
    AuthDao dao;
    
    @Override
    public List<AuthBean> list() {
        
        return dao.list();
    }

    @Override
    public AuthBean view(AuthBean bean) {
        
        return dao.view(bean);
    }

    @Override
    public int insertAction(AuthBean bean) {
        
        return dao.insertAction(bean);
    }

    @Override
    public int updateAction(AuthBean bean) {
        
        return dao.updateAction(bean);
    }

    @Override
    public int deleteAction(AuthBean bean) {
        
        return dao.deleteAction(bean);
    }
    
    @Override
    public List<Map<String, Object>> listAuthItemAll(AuthBean bean) {
        
        return dao.listAuthItemAll(bean);
    }
    
    @Override
    public int crudAction(Integer authCd, String[] updates) {
        
        return dao.crudAction(authCd, updates);
    }
    
    @Override
    public List<AuthAssignBean> listAuthAssign(String mgrId) {
        
        return dao.listAuthAssign(mgrId);
    }
    
    @Override
    public int updateAuthAssignAction(String mgrId, String[] authCds) {
        
        return dao.updateAuthAssignAction(mgrId, authCds);
    }
    
    @Override
    public List<AuthAssignLogBean> listAuthAssignLog(String mgrId) {
        
        return dao.listAuthAssignLog(mgrId);
    }

    
    @Override
    public List<AuthBean> listAuthByLogin(String mgrId) {
        
        return dao.listAuthByLogin(mgrId);
    }

    @Override
    public List<AuthItemBean> listAuthItemByLogin(String mgrId) {
        
        return dao.listAuthItemByLogin(mgrId);
    }
}
