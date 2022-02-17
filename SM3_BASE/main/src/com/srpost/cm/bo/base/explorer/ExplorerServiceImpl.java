package com.srpost.cm.bo.base.explorer;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.srpost.cm.bo.base.bbs.core.BbsBean;
import com.srpost.cm.bo.base.faq.core.FaqBean;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 익스플로러 서비스 구현체
 *
 * @author  finkle
 * @date    2014-12-18
 * @since   3.0
 */
@Service
public class ExplorerServiceImpl extends EgovAbstractServiceImpl implements IExplorerService{

    @Resource
    ExplorerDao dao;
    
    @Override
    public List<Map<String, Object>> planList(Map<String, Object> parameterMap) {
        
        return dao.planList(parameterMap);
    }
    
    @Override
    public Map<String, Object> calendar(String planDay) {
        
        return dao.calendar(planDay);
    }

    @Override
    public List<BbsBean> listForDashboard(BbsBean bean, boolean withStatus) {
        
        return dao.listForDashboard(bean, withStatus);
    }
    
    @Override
    public List<FaqBean> listForDashboard(FaqBean bean) {
        
        return dao.listForDashboard(bean);
    }
    
    @Override
    public Map<String, Map<String, Object>> recentBbsCount(int day) {
        
        return dao.recentBbsCount(day);
    }
    
    @Override
    public Map<String, Map<String, Object>> qnaStatusCount(int bbsCd) {
        
        return dao.qnaStatusCount(bbsCd);
    }

}
