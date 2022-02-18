package com.srpost.cm.si.bbs.haru;

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
public interface IBbsHaruService {

    BasePagerBean list(BbsHaruBean bean, BbsConfBean confBean);
    
    List<Map<String, Object>> listExcel(BbsHaruBean bean, BbsConfBean confBean);
    
    BbsHaruBean view(BbsHaruBean bean, BbsConfBean confBean, boolean needUpdateReadCnt);
    
    BbsHaruBean viewWithPrevNext(BbsHaruBean bean, BbsConfBean confBean, boolean needUpdateReadCnt);
    
    int insertAction(BbsHaruBean bean, BbsConfBean confBean);
    
    int updateAction(BbsHaruBean bean, BbsConfBean confBean);
    
    int deleteAction(BbsHaruBean bean);
}
