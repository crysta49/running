package com.srpost.cm.bo.si.ipFilter;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.srpost.salmon.bean.BasePagerBean;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 내부단 IP Filter 정보 서비스 구현체
 *
 */
@Service
public class IpFilterServiceImpl extends EgovAbstractServiceImpl implements IIpFilterService {

    @Resource
    IpFilterDao dao;
    
    @Override
    public BasePagerBean list(IpFilterBean bean) {
        
        return dao.list(bean);
    }

    @Override
    public IpFilterBean view(IpFilterBean bean) {
        
        return dao.view(bean);
    }

    @Override
    public int insertAction(IpFilterBean bean) {
        
        return dao.insertAction(bean);
    }

    @Override
    public int updateAction(IpFilterBean bean) {
        
        return dao.updateAction(bean);
    }

    @Override
    public int deleteAction(IpFilterBean bean) {
        
        return dao.deleteAction(bean);
    }

}