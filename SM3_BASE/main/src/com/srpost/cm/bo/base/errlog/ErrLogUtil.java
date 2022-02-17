package com.srpost.cm.bo.base.errlog;

import java.util.Map;

import com.srpost.salmon.lang.StringUtil;



/**
 * 내부단 에러로그 Util
 *
 * @author  finkle
 * @date    2014-11-10
 * @since   2.0
 */
public final class ErrLogUtil {
    
    public static Map<String, Object> getParameterMap(ErrLogBean bean) {
        
        Map<String, Object> parameterMap = bean.createPagerMap();
        if ( StringUtil.isNotEmpty(bean.getSolvYn()) )
            parameterMap.put("solvYn", bean.getSolvYn());
        
        return parameterMap;
    }
    
    public static void setNotNullValue(ErrLogBean bean) {

        bean.setTitle( StringUtil.fixLength(bean.getTitle(), 200) );
    }
}
