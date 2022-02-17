package com.srpost.cm.bo.base.bbs.ntc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;

/**
 * 내부단 게시판 공지글 엑셀변환 row handler
 *
 * @author  finkle
 * @date    2014-11-17
 * @since   3.0
 */
public class BbsNtcExcelRowHandler implements ResultHandler {

	private List<Map<String, Object>> list;

    public BbsNtcExcelRowHandler() {
    	
    	list = new ArrayList<Map<String, Object>>();
    }
    
    @Override
    public void handleResult(ResultContext context) {
        
        BbsNtcBean dataBean = (BbsNtcBean)context.getResultObject();

    	Map<String, Object> dataMap = new HashMap<String, Object>();

    	dataMap.put( "title", dataBean.getTitle() );
    	dataMap.put( "mgrNm", dataBean.getMgrNm() );
        dataMap.put( "readCnt", dataBean.getReadCnt() );
        dataMap.put( "fileCnt", dataBean.getFileCnt() );
        dataMap.put( "commentCnt", dataBean.getCommentCnt() );
        dataMap.put( "startDd", dataBean.getStartDd() );
        dataMap.put( "endDd", dataBean.getEndDd() );
        dataMap.put( "regDt", dataBean.getRegDt() );
        dataMap.put( "modiDt", dataBean.getModiDt() );

        list.add(dataMap);
    }
    
    public List<Map<String, Object>> getList() {
        
        return list;
    }
}