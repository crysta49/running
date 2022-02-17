package com.srpost.cm.bo.base.dept;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 내부단 부서관리 서비스 구현체
 *
 * @author  finkle
 * @date    2014-10-27
 * @since   2.0
 */
@Service
public class DeptServiceImpl extends EgovAbstractServiceImpl implements IDeptService {

    @Resource
    DeptDao dao;
    
    @Override
    public List<DeptBean> list(DeptBean bean) {
        
        return dao.list(bean);
    }

    @Override
    public DeptBean view(DeptBean bean) {
        
        return dao.view(bean);
    }

    @Override
    public Object insertAction(DeptBean bean) {
        
        return dao.insertAction(bean);
    }

    @Override
    public int updateAction(DeptBean bean) {
        
        return dao.updateAction(bean);
    }

    @Override
    public int deleteAction(DeptBean bean) {
        
        return dao.deleteAction(bean);
    }

    @Override
    public String listAllJSON() {
        
        return dao.listAllJSON();
    }
    
    @Override
    public List<DeptBean> listAll() {
        
        return dao.listAll();
    }
}
