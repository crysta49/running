package com.srpost.cm.bo.si;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;

import com.srpost.salmon.constant.Constant;
import com.srpost.salmon.lang.SessionUtil;

/**
 * 내부단 FAQ 엑셀변환 row handler
 *
 * @author  finkle
 * @date    2014-11-20
 * @since   3.0
 */
public class SampleExcelRowHandler implements ResultHandler {

	private List<Map<String, Object>> list;
	private HttpSession session;
	
    int totalCount = 1000000;
	private int affected;
	
    public SampleExcelRowHandler(HttpSession session) {
    	
    	list = new ArrayList<Map<String, Object>>();
    	this.session = session;
    }
    
    @Override
    @SuppressWarnings("unchecked")
    public void handleResult(ResultContext context) {
        
        
        Map<String, Object> rowMap = (Map<String, Object>)context.getResultObject();
        
        list.add(rowMap);
        
        SessionUtil.set(session, Constant.GLOBAL_PROGRESS_KEY, (Math.round(((float)affected/(float)totalCount)*100)) + "% 진행 중, 전체 " + 
                totalCount + "건의 자료 중 " + affected + "건을 DB에서 추출했습니다.");
        
        affected++;
    }
    
    public List<Map<String, Object>> getList() {
        
        return list;
    }
}