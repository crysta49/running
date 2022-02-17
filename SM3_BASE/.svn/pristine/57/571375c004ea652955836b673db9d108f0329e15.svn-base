package com.srpost.cm.bo.base.faq.core;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.srpost.salmon.bean.BasePagerBean;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 내부단 FAQ관리 서비스 구현체
 *
 * @author  finkle
 * @date    2014-11-20
 * @since   2.0
 */
@Service
public class FaqServiceImpl extends EgovAbstractServiceImpl implements IFaqService {
    
    @Resource
    FaqDao dao;

    
    @Override
    public BasePagerBean list(FaqBean bean) {
        
        return dao.list(bean);
    }
    
    @Override
    public List<Map<String, Object>> listExcel(FaqBean bean) {
        
        return dao.listExcel(bean);
    }

    @Override
    public FaqBean view(FaqBean bean, boolean needUpdateReadCnt) {
        
        return dao.view(bean, needUpdateReadCnt);
    }

    @Override
    public int insertAction(FaqBean bean) {
        
        return dao.insertAction(bean);
    }

    @Override
    public int updateAction(FaqBean bean) {
        
        return dao.updateAction(bean);
    }

    @Override
    public int deleteAction(FaqBean bean) {
        
        return dao.deleteAction(bean);
    }
    
    @Override
    public int aprvAction(FaqBean bean) {
        
        return dao.aprvAction(bean);
    }
    
    @Override
    public int scoreAction(FaqBean bean) {
        
        return dao.scoreAction(bean);
    }
    
    @Override
    public List<FaqBean> listForDashboard(FaqBean bean) {
        
        return dao.listForDashboard(bean);
    }
}
