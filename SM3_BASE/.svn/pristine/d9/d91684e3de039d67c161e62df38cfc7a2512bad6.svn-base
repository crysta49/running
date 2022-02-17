package com.srpost.cm.bo.base.explorer;

import java.util.List;
import java.util.Map;

import com.srpost.cm.bo.base.bbs.core.BbsBean;
import com.srpost.cm.bo.base.faq.core.FaqBean;

/**
 * 익스플로러 서비스 인터페이스
 *
 * @author  finkle
 * @date    2014-12-18
 * @since   3.0
 */
public interface IExplorerService {

    /** 이달의 일정 */
    List<Map<String, Object>> planList(Map<String, Object> parameterMap);
    
    /** 이달의 일정 - 현재날짜 기준 +- 1일 */
    Map<String, Object> calendar(String planDay);
    
    List<BbsBean> listForDashboard(BbsBean bean, boolean withStatus);
    List<FaqBean> listForDashboard(FaqBean bean);
    
    Map<String, Map<String, Object>> recentBbsCount(int day);
    Map<String, Map<String, Object>> qnaStatusCount(int bbsCd);
}
