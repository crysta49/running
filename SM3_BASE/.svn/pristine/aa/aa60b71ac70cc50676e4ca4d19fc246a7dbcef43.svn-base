package com.srpost.cm.bo.base.mgr.absence;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 내부단 직원 부재중 관리 DAO
 *
 * @author  finkle
 * @date    2014-12-17
 * @since   3.0
 */
@Repository
public class MgrAbsenceDao extends EgovAbstractMapper {

    
    public MgrAbsenceBean view(MgrAbsenceBean bean) {
        
        return view(bean.getMgrId());
    }
    
    public MgrAbsenceBean view(String mgrId) {
        
        return selectOne("_mgrAbsence.view", mgrId);
    }
    
    public int insertAction(MgrAbsenceBean bean) {

        return insert("_mgrAbsence.insert", bean);
    }

    public int updateAction(MgrAbsenceBean bean) {

        return update("_mgrAbsence.update", bean);
    }

    public int deleteAction(MgrAbsenceBean bean) {
        
        return delete("_mgrAbsence.delete", bean);
    }
    
    public List<MgrAbsenceBean> listMyHandOver(String agencyId) {
        
        return selectList("_mgrAbsence.listMyHandOver", agencyId);
    }
    
    public List<MgrAbsenceBean> listAgencyOver(MgrAbsenceBean bean) {
        
        return selectList("_mgrAbsence.listAgencyOver", bean);
    }
    
    public MgrAbsenceBean viewAgencyId(String agencyId) {
        
        return selectOne("_mgrAbsence.viewAgencyId", agencyId);
    }
    
    public int deleteInvalidAbsenceDataAction() {
        
        return delete("_mgrAbsence.deleteInvalidAbsenceData");
    }
}
