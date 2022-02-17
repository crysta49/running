package com.srpost.cm.bo.base.bbs.ntc;

import java.util.List;
import java.util.Map;

import com.srpost.salmon.bean.BasePagerBean;

/**
 * 내부단 게시판 공지글 서비스 인터페이스
 *
 * @author  finkle
 * @date    2014-11-17
 * @since   2.0
 */
public interface IBbsNtcService {

    BasePagerBean list(BbsNtcBean bean);
    
    List<Map<String, Object>> listExcel(BbsNtcBean bean);
    
    BbsNtcBean view(BbsNtcBean bean, boolean needUpdateReadCnt);
    
    int insertAction(BbsNtcBean bean);
    
    int updateAction(BbsNtcBean bean);
    
    int deleteAction(BbsNtcBean bean);
    
    
    List<BbsNtcBean> workList(Integer bbsCd);
    
    BbsNtcBean workView(BbsNtcBean bean, boolean needUpdateReadCnt);
}
