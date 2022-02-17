package com.srpost.cm.bo.base.faq.core;

import java.util.List;
import java.util.Map;

import com.srpost.salmon.bean.BasePagerBean;

/**
 * 내부단 FAQ관리 서비스 인터페이스
 *
 * @author  finkle
 * @date    2014-11-20
 * @since   2.0
 */
public interface IFaqService {

    BasePagerBean list(FaqBean bean);
    
    List<Map<String, Object>> listExcel(FaqBean bean);
    
    FaqBean view(FaqBean bean, boolean needUpdateReadCnt);
    
    int insertAction(FaqBean bean);
    
    int updateAction(FaqBean bean);
    
    int deleteAction(FaqBean bean);
    
    int aprvAction(FaqBean bean);
    
    int scoreAction(FaqBean bean);
    
    List<FaqBean> listForDashboard(FaqBean bean);
}
