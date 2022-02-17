package com.srpost.cm.bo.base.bbs.conf;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;

import com.srpost.salmon.lang.StringUtil;

/**
 * 내부단 게시판설정 엑셀변환 row handler
 *
 * @author  finkle
 * @date    2014-11-10
 * @since   2.0
 */
public class BbsConfExcelRowHandler implements ResultHandler {

	private List<Map<String, Object>> list;

    public BbsConfExcelRowHandler() {
    	
    	list = new ArrayList<Map<String, Object>>();
    }
    
    @Override
    public void handleResult(ResultContext context) {
        
    	BbsConfBean dataBean = (BbsConfBean)context.getResultObject();

    	Map<String, Object> dataMap = new HashMap<String, Object>();

    	dataMap.put( "bbsCd", dataBean.getBbsCd() );
    	dataMap.put( "bbsNm", dataBean.getBbsNm() );
        dataMap.put( "typeNm", dataBean.getTypeNm() );
        dataMap.put( "folderNm", dataBean.getFolderNm() );
        dataMap.put( "tableNm", dataBean.getTableNm() );
        dataMap.put( "cmtYn", StringUtil.parseUseYn(dataBean.getCmtYn()) );
    	dataMap.put( "ctgYn", StringUtil.parseUseYn(dataBean.getCtgYn()) );
    	dataMap.put( "fileYn", StringUtil.parseUseYn(dataBean.getFileYn()) );
    	dataMap.put( "fileCnt", dataBean.getFileCnt() );
        dataMap.put( "openYn", StringUtil.parseUseYn(dataBean.getOpenYn()) );
        dataMap.put( "ntcYn", StringUtil.parseUseYn(dataBean.getNtcYn()) );
        dataMap.put( "htmlYn", StringUtil.parseUseYn(dataBean.getHtmlYn()) );
        dataMap.put( "admYn", StringUtil.parseUseYn(dataBean.getAdmYn()) );
        dataMap.put( "alimYn", StringUtil.parseUseYn(dataBean.getAlimYn()) );
        dataMap.put( "useYn", StringUtil.parseUseYn(dataBean.getUseYn()) );
        dataMap.put( "regDt", dataBean.getRegDt() );
        dataMap.put( "modiDt", dataBean.getModiDt() );

        list.add(dataMap);
    }
    
    public List<Map<String, Object>> getList() {
        
        return list;
    }
}