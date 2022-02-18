package com.srpost.cm.bo.base.user;

import static com.srpost.salmon.constant.StringPool.*;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.srpost.salmon.bean.BasePagerBean;
import com.srpost.salmon.spi.crypto.SalmonCrypto;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 고객 정보 서비스 구현체
 *
 * @author  finkle
 * @date    2014-11-24
 * @since   2.0
 */
@Service
public class UserServiceImpl extends EgovAbstractServiceImpl implements IUserService {

    @Resource
    UserDao dao;
    @Resource
    SalmonCrypto salmonCtypto;
    
    @Override
    public BasePagerBean list(UserBean bean) {
        
        return dao.list(bean);
    }
    
    @Override
    public List<Map<String, Object>> listExcel(UserBean bean) {
        
        return dao.listExcel(bean, salmonCtypto);
    }

    @Override
    public UserBean view(UserBean bean) {
        
        return view(bean, MINUS_ONE);
    }
    
    public UserBean view(UserBean bean, int purporse) {
        
        UserBean dataBean = dao.view(bean, purporse);
        
        if (dataBean != null)
            UserUtil.decrypt(dataBean, salmonCtypto);
        
        return dataBean;
    }

    @Override
    public String insertAction(UserBean bean) {
        
        UserUtil.encrypt(bean, salmonCtypto);
        
        return dao.insertAction(bean);
    }

    @Override
    public int updateAction(UserBean bean) {
        
        UserUtil.encrypt(bean, salmonCtypto);
        
        return dao.updateAction(bean);
    }

    @Override
    public int deleteAction(UserBean bean) {
        
        return dao.deleteAction(bean);
    }
    
    @Override
    public int userKeyCnt(String userKey) {
        
        return dao.userKeyCnt(userKey);
    }

    @Override
    public List<UserLogBean> listLog(String userKey) {
        
        return dao.listLog(userKey);
    }
}
