package com.srpost.cm.bo.base.bbs.core;

import java.util.List;
import java.util.Map;

import com.srpost.cm.bo.base.bbs.conf.BbsConfBean;
import com.srpost.salmon.bean.BasePagerBean;

/**
 * 내부단 게시판 서비스 인터페이스
 *
 * @author  finkle
 * @date    2014-11-17
 * @since   2.0
 */
public interface IBbsService {

    BasePagerBean list(BbsBean bean, BbsConfBean confBean);
    
    List<Map<String, Object>> listExcel(BbsBean bean, BbsConfBean confBean);
    
    BbsBean view(BbsBean bean, BbsConfBean confBean, boolean needUpdateReadCnt);
    
    BbsBean viewWithPrevNext(BbsBean bean, BbsConfBean confBean, boolean needUpdateReadCnt);
    
    int insertAction(BbsBean bean, BbsConfBean confBean);
    
    int updateAction(BbsBean bean, BbsConfBean confBean);
    
    int deleteAction(BbsBean bean);
    
    List<BbsBean> listForDashboard(BbsBean bean);
}
