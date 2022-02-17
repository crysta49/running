package com.srpost.cm.bo.base.code;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 내부단 코드관리 서비스 구현체
 *
 * @author  finkle
 * @date    2014-10-27
 * @since   2.0
 */
@Service
public class CodeServiceImpl extends EgovAbstractServiceImpl implements ICodeService {

    @Resource
    CodeDao dao;
    
    @Override
    public List<CodeBean> list(CodeBean bean) {
        
        return dao.list(bean);
    }

    @Override
    public CodeBean view(CodeBean bean) {
        
        return dao.view(bean);
    }

    @Override
    public int insertAction(CodeBean bean) {
        
        return dao.insertAction(bean);
    }

    @Override
    public int updateAction(CodeBean bean) {
        
        return dao.updateAction(bean);
    }

    @Override
    public int deleteAction(CodeBean bean) {
        
        return dao.deleteAction(bean);
    }

    @Override
    public int crudAction(String[] inserts, String[] updates, String[] deletes) {
        
        return dao.crudAction(inserts, updates, deletes);
    }
    
    @Override
    public int orderAction(String grpCd, String[] orders) {
        
        return dao.orderAction(grpCd, orders);
    }
}
