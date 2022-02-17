package com.srpost.cm.bo.base.mgr.absence;

import java.util.List;


/**
 * 내부단 직원 부재중 관리 서비스 인터페이스
 *
 * @author  finkle
 * @date    2014-12-17
 * @since   3.0
 */
public interface IMgrAbsenceService {

    MgrAbsenceBean view(MgrAbsenceBean bean);
    
    MgrAbsenceBean view(String mgrId);

    int insertAction(MgrAbsenceBean bean);

    int updateAction(MgrAbsenceBean bean);

    int deleteAction(MgrAbsenceBean bean);
    
    List<MgrAbsenceBean> listMyHandOver(String agencyId);
    
    List<MgrAbsenceBean> listAgencyOver(MgrAbsenceBean bean);
    
    MgrAbsenceBean viewAgencyId(String agencyId);
}
