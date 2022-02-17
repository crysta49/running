package com.srpost.cm.bo.base.errlog;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;

/**
 * 내부단 에러로그 엑셀변환 row handler
 *
 * @author  finkle
 * @date    2014-10-27
 * @since   2.0
 */
public class ErrLogExcelRowHandler implements ResultHandler {

	private List<Map<String, Object>> list;

    public ErrLogExcelRowHandler() {
    	
    	list = new ArrayList<Map<String, Object>>();
    }
    
    @Override
    public void handleResult(ResultContext context) {
        
    	ErrLogBean dataBean = (ErrLogBean)context.getResultObject();

    	Map<String, Object> dataMap = new HashMap<String, Object>();

    	dataMap.put( "title", dataBean.getTitle() );
    	dataMap.put( "url", dataBean.getUrl() ); 
    	dataMap.put( "regDt", dataBean.getRegDt() );
    	dataMap.put( "solvYn", dataBean.getSolvYn() );
    	dataMap.put( "solvDt", dataBean.getSolvDt() );

        list.add(dataMap);
    }
    
    public List<Map<String, Object>> getList() {
        
        return list;
    }
}