package com.srpost.cm.bo.base.domain;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 내부단 도메인 서비스 구현체
 *
 * @author  finkle
 * @date    2014-11-07
 * @since   2.0
 */
@Service
public class DomainServiceImpl extends EgovAbstractServiceImpl implements IDomainService {

    @Resource
    DomainDao dao;
    
    @Override
    public List<DomainBean> list() {
        
        return dao.list();
    }

    @Override
    public DomainBean view(DomainBean bean) {
        
        return dao.view(bean);
    }

    @Override
    public int insertAction(DomainBean bean) {
        
        return dao.insertAction(bean);
    }

    @Override
    public int updateAction(DomainBean bean) {
        
        return dao.updateAction(bean);
    }

    @Override
    public int deleteAction(DomainBean bean) {
        
        return dao.deleteAction(bean);
    }
}
