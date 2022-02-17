package com.srpost.cm.bo.base.login.log;

import java.util.Map;

/**
 * 내부단 로그인 로그 Util
 *
 * @author  finkle
 * @date    2014-11-10
 * @since   2.0
 */
public final class LoginLogUtil {
    
    public static Map<String, Object> getParameterMap(LoginLogBean bean) {
        
        Map<String, Object> parameterMap = bean.createPagerMap();
        /*--
        if ( StringUtil.isNotEmpty(bean.getMgrId()) )
            parameterMap.put("mgrId", bean.getMgrId());
        if ( StringUtil.isNotEmpty(bean.getMgrNm()) )
            parameterMap.put("mgrNm", bean.getMgrNm());
        if ( StringUtil.isNotEmpty(bean.getIpAddr()) )
            parameterMap.put("ipAddr", bean.getIpAddr());
        --*/
        
        return parameterMap;
    }
}
