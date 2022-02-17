package com.srpost.cm.bo.base.explorer;

import static com.srpost.salmon.constant.StringPool.ZERO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.srpost.cm.bo.base.bbs.core.BbsBean;
import com.srpost.cm.bo.base.faq.core.FaqBean;
import com.srpost.cm.bo.base.file.FileDao;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 익스플로러 DAO
 *
 * @author  finkle
 * @date    2014-12-18
 * @since   3.0
 */
@Repository
public class ExplorerDao extends EgovAbstractMapper {
    
    @Resource
    FileDao fileDao;
    
    public List<Map<String, Object>> planList(Map<String, Object> parameterMap) {
        
        return selectList("_explorer.planList", parameterMap);
    }
    
    public Map<String, Object> calendar(String planDay) {
        
        return selectOne("_explorer.calendar", planDay);
    }

    public List<BbsBean> listForDashboard(BbsBean bean, boolean withStatus) {
        
        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("bbsCd", bean.getBbsCd());
        parameterMap.put("rowPerPage", bean.getRowPerPage());
        parameterMap.put("withStatus", withStatus);
        
        List<BbsBean> bbsList =  selectList("_explorer.bbsList", parameterMap);
        
        for (BbsBean bbsBean : bbsList) {
            if (bbsBean.getFileCnt() > ZERO)
                bbsBean.setFileList( fileDao.list(bbsBean.getFileSeq()) );
        }
        return bbsList;
    }
    
    public List<FaqBean> listForDashboard(FaqBean bean) {
        
        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("rowPerPage", bean.getRowPerPage());

        return selectList("_explorer.faqList", parameterMap);
    }
    
    public Map<String, Map<String, Object>> recentBbsCount(int day) {

        return selectMap("_explorer.recentBbsCount", day, "KEYZ");
    }
    
    public Map<String, Map<String, Object>> qnaStatusCount(int bbsCd) {

        return selectMap("_explorer.qnaStatusCount", bbsCd, "KEYZ");
    }
}
