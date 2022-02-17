package com.srpost.cm.bo.base.login.log;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.srpost.salmon.bean.BasePagerBean;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 내부단 로그인 로그 서비스 구현체
 *
 * @author  finkle
 * @date    2014-09-26
 * @since   2.0
 */
@Service
public class LoginLogServiceImpl extends EgovAbstractServiceImpl implements ILoginLogService {

    @Resource
    LoginLogDao dao;

    @Override
    public BasePagerBean list(LoginLogBean bean) {

        return dao.list(bean);
    }
    
    @Override
    public List<Map<String, Object>> listExcel(LoginLogBean bean) {
        
        return dao.listExcel(bean);
    }

    @Override
    public int loginAction(LoginLogBean bean) {

        return dao.loginAction(bean);
    }
    
    @Override
    public int logoutAction(LoginLogBean bean) {

        return dao.logoutAction(bean);
    }
}
