package com.srpost.cm.bo.base.faq.ctg;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 내부단 FAQ분류 관리 서비스 구현체
 *
 * @author  finkle
 * @date    2014-11-20
 * @since   2.0
 */
@Service
public class FaqCtgServiceImpl extends EgovAbstractServiceImpl implements IFaqCtgService {

    @Resource
    FaqCtgDao dao;
    
    @Override
    public List<FaqCtgBean> list(FaqCtgBean bean) {
        
        return dao.list(bean);
    }

    @Override
    public FaqCtgBean view(FaqCtgBean bean) {
        
        return dao.view(bean);
    }

    @Override
    public Object insertAction(FaqCtgBean bean) {
        
        return dao.insertAction(bean);
    }

    @Override
    public int updateAction(FaqCtgBean bean) {
        
        return dao.updateAction(bean);
    }

    @Override
    public int deleteAction(FaqCtgBean bean) {
        
        return dao.deleteAction(bean);
    }
    
    @Override
    public List<FaqCtgBean> listAll() {
        
        return dao.listAll();
    }
}
