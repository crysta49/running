package com.srpost.cm.bo.base.faq.core;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;

import com.srpost.salmon.lang.StringUtil;

/**
 * 내부단 FAQ 엑셀변환 row handler
 *
 * @author  finkle
 * @date    2014-11-20
 * @since   3.0
 */
public class FaqExcelRowHandler implements ResultHandler {

	private List<Map<String, Object>> list;

    public FaqExcelRowHandler() {
    	
    	list = new ArrayList<Map<String, Object>>();
    }
    
    @Override
    public void handleResult(ResultContext context) {
        
    	FaqBean dataBean = (FaqBean)context.getResultObject();

    	Map<String, Object> dataMap = new HashMap<String, Object>();

    	dataMap.put( "ctgNm", dataBean.getCtgNm() );
    	dataMap.put( "title", dataBean.getTitle() );
        dataMap.put( "mgrNm", dataBean.getMgrNm() );
        dataMap.put( "recomCnt", dataBean.getRecomCnt() );
        dataMap.put( "oppCnt", dataBean.getOppCnt() );
    	dataMap.put( "readCnt", dataBean.getReadCnt() );
    	dataMap.put( "fileCnt", dataBean.getFileCnt() );
        dataMap.put( "aprvYn", StringUtil.parseAprvYn(dataBean.getAprvYn()) );
        dataMap.put( "regDt", dataBean.getRegDt() );
        dataMap.put( "modiDt", dataBean.getModiDt() );

        list.add(dataMap);
    }
    
    public List<Map<String, Object>> getList() {
        
        return list;
    }
}