package com.srpost.cm.bo.base.bbs.conf;

import static com.srpost.salmon.constant.StringPool.*;

import java.util.Map;

import com.srpost.salmon.constant.StringPool;
import com.srpost.salmon.lang.StringUtil;



/**
 * 내부단 게시판설정 정보 Util
 *
 * @author  finkle
 * @date    2014-11-10
 * @since   2.0
 */
public final class BbsConfUtil {
    
    /*----------------------------------------------------------------------------
     * 게시판 유형 (CO_CODE_PRV : BBS_TYPE)
     */
    public static final String NORMAL = "100";      // 기본형
    public static final String HIERARCHY = "101";   // 계층형
    public static final String QNA = "102";         // QNA형
    
    /*----------------------------------------------------------------------------
     * 게시판 처리상태 (CO_CODE_PRV : BBS_STATUS)
     */
    public static final String RECEIVE = "200";         // 접수
    public static final String WORKING = "201";         // 처리중
    public static final String COMPLETE = "202";        // 처리완료
    
    
    public static Map<String, Object> getParameterMap(BbsConfBean bean) {
        
        Map<String, Object> parameterMap = bean.createPagerMap();
        if ( StringUtil.isNotEmpty(bean.getTypeCd()) )
            parameterMap.put("typeCd", bean.getTypeCd());
        if ( StringUtil.isNotEmpty(bean.getUseYn()) )
            parameterMap.put("useYn", bean.getUseYn());
        
        return parameterMap;
    }
    
    public static void setNotNullValue(BbsConfBean bean) {

        if ( StringUtil.isEmpty(bean.getFileYn()) || 
                StringUtil.equals(bean.getFileYn(), N))
            bean.setFileCnt(ZERO);
        else
            bean.setFileCnt(bean.getFileCnt());
            
        if ( StringUtil.isEmpty(bean.getFileCnt()) )
            bean.setFileCnt(ZERO);
        
        if ( StringUtil.isNotEmpty(bean.getFolderNm()) ) {
            if ( !bean.getFolderNm().startsWith("/") )
                bean.setFolderNm("/" + bean.getFolderNm());
        }
        
        if ( StringUtil.isEmpty(bean.getOpenYn()) ) bean.setOpenYn(Y);
        if ( StringUtil.isEmpty(bean.getCtgYn()) ) bean.setCtgYn(N);
        if ( StringUtil.isEmpty(bean.getAdmYn()) ) bean.setAdmYn(N);
        if ( StringUtil.isEmpty(bean.getAlimYn()) ) bean.setAlimYn(N);
        if ( StringUtil.isEmpty(bean.getHtmlYn()) ) bean.setHtmlYn(N);
        if ( StringUtil.isEmpty(bean.getNtcYn()) ) bean.setNtcYn(N);
        if ( StringUtil.isEmpty(bean.getCmtYn()) ) bean.setCmtYn(N);
    }
    
    public static String getFolderNm(BbsConfBean confBean) {
        
        String folderNm = confBean.getFolderNm();
        
        if (StringUtil.isEmpty(folderNm))
            return StringPool.EMPTY;
        
        if ( StringUtil.equals(folderNm, "/normal") || 
                StringUtil.equals(folderNm, "/hir") || 
                StringUtil.equals(folderNm, "/qna") ) 
        {
            return StringPool.EMPTY;
        }
        
        return folderNm;
    }
}
