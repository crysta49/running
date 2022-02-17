package com.srpost.cm.bo.base.login.log;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;

/**
 * 내부단 로그인 로그 엑셀변환 row handler
 *
 * @author  finkle
 * @date    2014-10-27
 * @since   2.0
 */
public class LoginLogExcelRowHandler implements ResultHandler {

	private List<Map<String, Object>> list;

    public LoginLogExcelRowHandler() {
    	
    	list = new ArrayList<Map<String, Object>>();
    }
    
    @Override
    public void handleResult(ResultContext context) {
        
        LoginLogBean dataBean = (LoginLogBean)context.getResultObject();

    	Map<String, Object> dataMap = new HashMap<String, Object>();

    	dataMap.put( "mgrId", dataBean.getMgrId() );
    	dataMap.put( "mgrNm", dataBean.getMgrNm() ); 
        dataMap.put( "ipAddr", dataBean.getIpAddr() );
    	dataMap.put( "loginDt", dataBean.getLoginDt() );
    	dataMap.put( "logOutDt", dataBean.getLogOutDt() );
        dataMap.put( "agencyId", dataBean.getAgencyId() );
        dataMap.put( "agencyNm", dataBean.getAgencyNm() );
    	
        list.add(dataMap);
    }
    
    public List<Map<String, Object>> getList() {
        
        return list;
    }
}