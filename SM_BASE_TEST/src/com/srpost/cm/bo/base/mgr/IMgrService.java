package com.srpost.cm.bo.base.mgr;

import java.util.List;
import java.util.Map;

import com.srpost.salmon.bean.BasePagerBean;

/**
 * 내부단 직원관리 서비스 인터페이스
 *
 * @author  finkle
 * @date    2014-11-05
 * @since   2.0
 */
public interface IMgrService {

    BasePagerBean list(MgrBean bean);
    
    List<Map<String, Object>> listExcel(MgrBean bean);
    
    MgrBean view(MgrBean bean);
    
    MgrBean view(String mgrId);

    Object insertAction(MgrBean bean);

    int updateAction(MgrBean bean);

    int deleteAction(MgrBean bean);
    
    int updateLoginAction(MgrBean bean);
    
    int photoDeleteAction(MgrBean bean);
    
    int updateThemeAction(MgrBean bean);
    
    List<MgrBean> listAll(MgrBean bean);
}
