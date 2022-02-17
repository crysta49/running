package com.srpost.cm.bo.base.faq.core;

import static com.srpost.salmon.constant.StringPool.*;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.srpost.cm.bo.base.login.LoginBean;
import com.srpost.cm.bo.base.mgr.MgrUtil;
import com.srpost.salmon.constant.Constant;
import com.srpost.salmon.lang.CookieUtil;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.lang.WebUtil;

/**
 * 내부단 FAQ관리 Util
 *
 * @author  finkle
 * @date    2014-11-20
 * @since   2.0
 */
public final class FaqUtil {

    public static final String SORT_BEST = "best";
    public static final String SORT_WORST = "worst";
    
    public static Map<String, Object> getParameterMap(FaqBean bean) {
        
        Map<String, Object> parameterMap = bean.createPagerMap();
        if ( StringUtil.isNotEmpty(bean.getCtgCd()) )
            parameterMap.put("ctgCd", bean.getCtgCd());
        if ( StringUtil.isNotEmpty(bean.getAprvYn()) )
            parameterMap.put("aprvYn", bean.getAprvYn());
        if ( StringUtil.isNotEmpty(bean.getMgrId()) )
            parameterMap.put("mgrId", bean.getMgrId());
        
        return parameterMap;
    }
    
    public static void setNotNullValue(FaqBean bean) {
        
        if (StringUtil.isEmpty(bean.getFileSeq()))
            bean.setFileSeq(MINUS_ONE);
        if (StringUtil.isEmpty(bean.getAprvYn()))
            bean.setAprvYn(N);
        
        LoginBean loginBean = MgrUtil.getSession(WebUtil.getCurrentRequest());
        bean.setMgrId(loginBean.getMgrId());
    }
    
    public static boolean needUpdateReadCnt(
            FaqBean bean, HttpServletRequest request, HttpServletResponse response) {

        String key = "FAQ_" + bean.getSeq();
        
        String value = CookieUtil.getCookie(request, key);
        if (!StringUtil.equals(value, Y)) {
            CookieUtil.setCookie(response, key, Y, Constant.READ_CNT_MINUTES);
            return true;
        }
        return false;
    }
    
    public static boolean existScoreCookie(
            FaqBean bean, HttpServletRequest request, HttpServletResponse response) {

        String key = "FAQ_S_" + bean.getSeq();
        
        String value = CookieUtil.getCookie(request, key);
        if (!StringUtil.equals(value, Y)) {
            CookieUtil.setCookie(response, key, Y, 60*24*30); // 30 days
            return false;
        }
        
        return true;
    }
}
