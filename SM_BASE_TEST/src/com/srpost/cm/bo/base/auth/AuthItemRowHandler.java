package com.srpost.cm.bo.base.auth;

import static com.srpost.salmon.constant.StringPool.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.BooleanUtils;
import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;

import com.srpost.cm.bo.base.menu.MenuBean;
import com.srpost.salmon.lang.StringUtil;

/**
 * 내부단 권한그룹_메뉴_맵핑_목록 row handler
 *
 * @author  finkle
 * @date    2014-11-06
 * @since   3.0
 */
public class AuthItemRowHandler implements ResultHandler {

	private List<Map<String, Object>> list;

    public AuthItemRowHandler() {
    	
    	list = new ArrayList<Map<String, Object>>();
    }
    
    @Override
    public void handleResult(ResultContext context) {
        
        MenuBean dataBean = (MenuBean)context.getResultObject();

        Map<String, Object> dataMap = new HashMap<String, Object>();
        
    	dataMap.put( "menuCd", dataBean.getMenuCd() );
    	dataMap.put( "menuNm", StringUtil.replace(dataBean.getMenuNm(), HAT, "&nbsp;") ); 
    	dataMap.put( "highMenuCd", dataBean.getHighMenuCd() );
    	dataMap.put( "menuUrl", dataBean.getMenuUrl() );
    	dataMap.put( "checked", BooleanUtils.toBoolean(dataBean.getChecked()) );
        dataMap.put( "depth", dataBean.getDepth() );

    	String text = dataBean.getText();
    	if (StringUtil.isEmpty(text)) {
            dataMap.put( "readYn", false );
            dataMap.put( "createYn", false );
            dataMap.put( "updateYn", false );
            dataMap.put( "deleteYn", false );
    	}
    	else {
    	    String[] texts = StringUtil.split(text, HAT);
            dataMap.put( "readYn", BooleanUtils.toBoolean(texts[0]) );
            dataMap.put( "createYn", BooleanUtils.toBoolean(texts[1]) );
            dataMap.put( "updateYn", BooleanUtils.toBoolean(texts[2]) );
            dataMap.put( "deleteYn", BooleanUtils.toBoolean(texts[3]) );
    	}
    	
        list.add(dataMap);
    }
    
    public List<Map<String, Object>> getList() {
        
        return list;
    }
}