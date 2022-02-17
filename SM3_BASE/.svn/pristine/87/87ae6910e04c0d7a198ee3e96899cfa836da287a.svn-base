package com.srpost.cm.bo.base.code;

import java.util.List;

import com.srpost.salmon.cache.Cache;
import com.srpost.salmon.lang.StringUtil;

public final class CodeUtil {

    
    /**
     * 목록 요청 : prvCd 미존재 시 그룹코드에 대한 처리로 판단
     */
    public static boolean isGrpList(CodeBean bean) {
        
        return StringUtil.isEmpty(bean.getPrvCd());
    }
    
    /**
     * 상세 요청 : prvCd 미존재 시 그룹코드에 대한 처리로 판단
     */
    public static boolean isGrpView(CodeBean bean) {
        
        return StringUtil.isEmpty(bean.getPrvCd());
    }
    
    /**
     * 코드 목록 얻기 from cache
     */
    @SuppressWarnings("unchecked")
    public static List<CodeBean> getCodeList(String grpCd) {
        
        return (List<CodeBean>)Cache.get(CodeCache.LIST_KEY + grpCd);
    }
}
