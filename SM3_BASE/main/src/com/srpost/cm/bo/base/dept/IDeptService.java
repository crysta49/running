package com.srpost.cm.bo.base.dept;

import java.util.List;

/**
 * 내부단 부서관리 서비스 인터페이스
 *
 * @author  finkle
 * @date    2014-10-27
 * @since   2.0
 */
public interface IDeptService {

    List<DeptBean> list(DeptBean bean);
    
    DeptBean view(DeptBean bean);

    Object insertAction(DeptBean bean);

    int updateAction(DeptBean bean);

    int deleteAction(DeptBean bean);

    String listAllJSON();
    
    List<DeptBean> listAll();
}
