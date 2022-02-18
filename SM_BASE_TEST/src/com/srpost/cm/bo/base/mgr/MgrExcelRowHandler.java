package com.srpost.cm.bo.base.mgr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;

import com.srpost.salmon.lang.StringUtil;

/**
 * 내부단 직원정보 엑셀변환 row handler
 *
 * @author  finkle
 * @date    2014-11-10
 * @since   2.0
 */
public class MgrExcelRowHandler implements ResultHandler {

	private List<Map<String, Object>> list;

    public MgrExcelRowHandler() {
    	
    	list = new ArrayList<Map<String, Object>>();
    }
    
    @Override
    public void handleResult(ResultContext context) {
        
    	MgrBean dataBean = (MgrBean)context.getResultObject();

    	Map<String, Object> dataMap = new HashMap<String, Object>();

    	dataMap.put( "deptCd", dataBean.getDeptCd() );
    	dataMap.put( "deptNm", dataBean.getDeptNm() );
        dataMap.put( "mgrId", dataBean.getMgrId() );
        dataMap.put( "mgrNm", dataBean.getMgrNm() );
    	dataMap.put( "gradeNm", dataBean.getGradeNm() );
    	dataMap.put( "roleNm", dataBean.getRoleNm() );
    	dataMap.put( "telNum", dataBean.getTelNum() );
        dataMap.put( "faxNum", dataBean.getFaxNum() );
        dataMap.put( "mobile", dataBean.getMobile() );
        dataMap.put( "email", dataBean.getEmail() );
        dataMap.put( "theme", dataBean.getTheme() );
        dataMap.put( "loginCnt", dataBean.getLoginCnt() );
        dataMap.put( "loginDt", dataBean.getLoginDt() );
        dataMap.put( "useYn", StringUtil.parseUseYn(dataBean.getUseYn()) );
        dataMap.put( "regDt", dataBean.getRegDt() );
        dataMap.put( "modiDt", dataBean.getModiDt() );

        list.add(dataMap);
    }
    
    public List<Map<String, Object>> getList() {
        
        return list;
    }
}