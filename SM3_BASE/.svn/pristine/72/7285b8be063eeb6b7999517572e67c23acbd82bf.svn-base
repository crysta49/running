package com.srpost.cm.bo.base.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;

import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.spi.crypto.SalmonCrypto;

/**
 * 고객 정보 엑셀변환 row handler
 *
 * @author  finkle
 * @date    2014-11-24
 * @since   2.0
 */
public class UserExcelRowHandler implements ResultHandler {

    private SalmonCrypto salmonCtypto;
	private List<Map<String, Object>> list;

    public UserExcelRowHandler(SalmonCrypto salmonCtypto) {
    	
        this.salmonCtypto = salmonCtypto;
    	list = new ArrayList<Map<String, Object>>();
    }
    
    @Override
    public void handleResult(ResultContext context) {
        
    	UserBean dataBean = (UserBean)context.getResultObject();

    	Map<String, Object> dataMap = new HashMap<String, Object>();

    	dataMap.put( "userId", dataBean.getUserId() );
    	dataMap.put( "userNm", dataBean.getUserNm() );
        dataMap.put( "typeNm", dataBean.getTypeNm() );
        dataMap.put( "userEncTelNum", salmonCtypto.decrypt(dataBean.getUserEncTelNum()) );
        dataMap.put( "userEncMobile", salmonCtypto.decrypt(dataBean.getUserEncMobile()) );
        dataMap.put( "userEncEmail", salmonCtypto.decrypt(dataBean.getUserEncEmail()) );
        if (StringUtil.isNotEmpty(dataBean.getPostCd()) && StringUtil.isNotEmpty(dataBean.getAddr1())) {
            dataMap.put( "postCd", "[" + dataBean.getPostCd() + "] " + dataBean.getAddr1() + " " + dataBean.getAddr2());
        }
        dataMap.put( "useYn", StringUtil.parseUseYn(dataBean.getUseYn()) );
        dataMap.put( "regDt", dataBean.getRegDt() );
        dataMap.put( "modiDt", dataBean.getModiDt() );

        list.add(dataMap);
    }
    
    public List<Map<String, Object>> getList() {
        
        return list;
    }
}