package com.srpost.cm.bo.base.mgr;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.srpost.salmon.bean.BasePagerBean;
import com.srpost.salmon.spi.crypto.SalmonCrypto;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 내부단 직원관리 서비스 구현체
 *
 * @author  finkle
 * @date    2014-11-05
 * @since   2.0
 */
@Service
public class MgrServiceImpl extends EgovAbstractServiceImpl implements IMgrService {

    @Resource
    MgrDao dao;
    @Resource
    SalmonCrypto salmonCtypto;
    
    @Override
    public BasePagerBean list(MgrBean bean) {
        
        return dao.list(bean);
    }
    
    @Override
    public List<Map<String, Object>> listExcel(MgrBean bean) {
        
        return dao.listExcel(bean);
    }

    @Override
    public MgrBean view(MgrBean bean) {
        
        return view(bean.getMgrId());
    }
    
    @Override
    public MgrBean view(String mgrId) {
        
        return dao.view(mgrId);
    }

    @Override
    public Object insertAction(MgrBean bean) {
        
        MgrUtil.encrypt(bean, salmonCtypto);
        
        return dao.insertAction(bean);
    }

    @Override
    public int updateAction(MgrBean bean) {
        
        MgrUtil.encrypt(bean, salmonCtypto);
        
        return dao.updateAction(bean);
    }

    @Override
    public int deleteAction(MgrBean bean) {
        
        return dao.deleteAction(bean);
    }
    
    @Override
    public int updateLoginAction(MgrBean bean) {
        
        return dao.updateLoginAction(bean);
    }
    
    @Override
    public int photoDeleteAction(MgrBean bean) {
        
        return dao.photoDeleteAction(bean);
    }
    
    @Override
    public int updateThemeAction(MgrBean bean) {
        
        return dao.updateThemeAction(bean);
    }
    
    @Override
    public List<MgrBean> listAll(MgrBean bean) {
        
        return dao.listAll(bean);
    }
}
