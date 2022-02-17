package com.srpost.cm.bo.base.mgr.absence;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 내부단 직원 부재중 관리 서비스 구현체
 *
 * @author  finkle
 * @date    2014-12-17
 * @since   3.0
 */
@Service
public class MgrAbsenceServiceImpl extends EgovAbstractServiceImpl implements IMgrAbsenceService {

    @Resource
    MgrAbsenceDao dao;
    
    @Override
    public MgrAbsenceBean view(MgrAbsenceBean bean) {
        
        return view(bean.getMgrId());
    }
    
    @Override
    public MgrAbsenceBean view(String mgrId) {
        
        return dao.view(mgrId);
    }

    @Override
    public int insertAction(MgrAbsenceBean bean) {

        return dao.insertAction(bean);
    }

    @Override
    public int updateAction(MgrAbsenceBean bean) {

        return dao.updateAction(bean);
    }

    @Override
    public int deleteAction(MgrAbsenceBean bean) {
        
        return dao.deleteAction(bean);
    }

    @Override
    public List<MgrAbsenceBean> listMyHandOver(String agencyId) {
        
        return dao.listMyHandOver(agencyId);
    }
    
    @Override
    public List<MgrAbsenceBean> listAgencyOver(MgrAbsenceBean bean) {
        
        return dao.listAgencyOver(bean);
    }
    
    @Override
    public MgrAbsenceBean viewAgencyId(String agencyId) {
        
        return dao.viewAgencyId(agencyId);
    }
}
