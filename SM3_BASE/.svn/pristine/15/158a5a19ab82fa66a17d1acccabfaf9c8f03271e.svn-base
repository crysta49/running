package com.srpost.cm.bo.base.hday;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 내부단 공휴일 서비스 구현체
 *
 * @author  finkle
 * @date    2014-11-07
 * @since   2.0
 */
@Service
public class HdayServiceImpl extends EgovAbstractServiceImpl implements IHdayService {

    @Resource
    HdayDao dao;
    
    @Override
    public List<HdayBean> list() {
        
        return dao.list();
    }

    @Override
    public HdayBean view(HdayBean bean) {
        
        return dao.view(bean);
    }

    @Override
    public int insertAction(HdayBean bean) {
        
        return dao.insertAction(bean);
    }

    @Override
    public int updateAction(HdayBean bean) {
        
        return dao.updateAction(bean);
    }

    @Override
    public int deleteAction(HdayBean bean) {
        
        return dao.deleteAction(bean);
    }
    
    @Override
    public List<HdayBean> listCache() {
        
        return dao.listCache();
    }
}
