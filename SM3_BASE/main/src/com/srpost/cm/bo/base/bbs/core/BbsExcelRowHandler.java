package com.srpost.cm.bo.base.bbs.core;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;

import com.srpost.salmon.lang.StringUtil;

/**
 * 내부단 게시판 엑셀변환 row handler
 *
 * @author  finkle
 * @date    2014-11-17
 * @since   3.0
 */
public class BbsExcelRowHandler implements ResultHandler {

	private List<Map<String, Object>> list;

    public BbsExcelRowHandler() {
    	
    	list = new ArrayList<Map<String, Object>>();
    }
    
    @Override
    public void handleResult(ResultContext context) {
        
    	BbsBean dataBean = (BbsBean)context.getResultObject();

    	Map<String, Object> dataMap = new HashMap<String, Object>();

    	dataMap.put( "bbsCd", dataBean.getBbsCd() );
    	dataMap.put( "bbsSeq", dataBean.getBbsSeq() );
    	dataMap.put( "title", dataBean.getTitle() );
    	dataMap.put( "writerNm", dataBean.getWriterNm() );
        dataMap.put( "readCnt", dataBean.getReadCnt() );
        dataMap.put( "ctgNm", dataBean.getCtgNm() );
        dataMap.put( "replyNm", dataBean.getReplyNm() );
        dataMap.put( "fileCnt", dataBean.getFileCnt() );
        dataMap.put( "commentCnt", dataBean.getCommentCnt() );
        dataMap.put( "openYn", StringUtil.parseOpenYn(dataBean.getOpenYn()) );
    	dataMap.put( "statusNm", dataBean.getStatusNm() );
        dataMap.put( "regDt", dataBean.getRegDt() );
        dataMap.put( "modiDt", dataBean.getModiDt() );

        list.add(dataMap);
    }
    
    public List<Map<String, Object>> getList() {
        
        return list;
    }
}