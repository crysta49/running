package com.srpost.cm.bo.base.bbs.core.ext;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.srpost.cm.bo.base.bbs.conf.BbsConfBean;
import com.srpost.cm.bo.base.bbs.core.BbsBean;
import com.srpost.salmon.lang.StringUtil;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 내부단 게시판 확장 테이블 DAO
 *
 * @author  finkle
 * @date    2016-01-11
 * @since   3.0
 */
@Repository
@SuppressWarnings({"unchecked", "rawtypes"})
public class BbsExtDao extends EgovAbstractMapper {


    public void list(List<BbsBean> dataList, BbsConfBean confBean) {
        
        if (StringUtil.isEmpty(confBean.getTableNm())
                || StringUtil.isEmpty(confBean.getColumnList())) {
            return;
        }
        
        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("TABLE_NM", confBean.getTableNm());
        parameterMap.put("COLUMNZ", confBean.getColumnList());
        
        for (BbsBean item : dataList) {
            parameterMap.put("BBS_CD", item.getBbsCd());
            parameterMap.put("BBS_SEQ", item.getBbsSeq());
            
            item.setExtMap( (Map<String, Object>)selectOne("_bbsExt.view", parameterMap) );
        }
    }
    
    public void listExcel(List<Map<String, Object>> dataList, BbsConfBean confBean) {
        
        if (StringUtil.isEmpty(confBean.getTableNm())
                || StringUtil.isEmpty(confBean.getColumnList())) {
            return;
        }
        
        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("TABLE_NM", confBean.getTableNm());
        parameterMap.put("COLUMNZ", confBean.getColumnList());
    	
        for (Map item : dataList) {
            parameterMap.put("BBS_CD", item.get("bbsCd"));
            parameterMap.put("BBS_SEQ", item.get("bbsSeq"));
            
            item.putAll( (Map<String, Object>)selectOne("_bbsExt.view", parameterMap) );
        }
    }
    
    public Map<String, Object> view(BbsBean dataBean, BbsConfBean confBean) {

        if (StringUtil.isEmpty(confBean.getTableNm())
                || StringUtil.isEmpty(confBean.getColumnList())) {
            return null;
        }

        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("TABLE_NM", confBean.getTableNm());
        parameterMap.put("COLUMNZ", confBean.getColumnList());
        parameterMap.put("BBS_CD", dataBean.getBbsCd());
        parameterMap.put("BBS_SEQ", dataBean.getBbsSeq());

        return selectOne("_bbsExt.view", parameterMap);
    }
    
    public void insertAction(BbsBean bean, BbsConfBean confBean) {

        if (StringUtil.isEmpty(confBean.getTableNm())
                || StringUtil.isEmpty(confBean.getColumnList())) {
            return;
        }
        
        update("_bbsExt.insert", getParameterMap(bean, confBean));
    }
    
    public void replyAction(BbsBean bean, BbsConfBean confBean) {

        insertAction(bean, confBean);
    }

    public void updateAction(BbsBean bean, BbsConfBean confBean) {

        if (StringUtil.isEmpty(confBean.getTableNm())
                || StringUtil.isEmpty(confBean.getColumnList())) {
            return;
        }
        
        update("_bbsExt.insert", getParameterMap(bean, confBean));
    }
    
    private Map<String, Object> getParameterMap(BbsBean bean, BbsConfBean confBean) {
        
        Map<String, Object> parameterMap = new HashMap<String, Object>();
        parameterMap.put("TABLE_NM", confBean.getTableNm());
        parameterMap.put("BBS_CD", bean.getBbsCd());
        parameterMap.put("BBS_SEQ", bean.getBbsSeq());
        parameterMap.put("COLUMNZ", bean.getExtMap());
        
        return parameterMap;
    }
}
