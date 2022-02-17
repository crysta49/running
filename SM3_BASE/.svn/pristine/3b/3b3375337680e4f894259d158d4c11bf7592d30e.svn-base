package com.srpost.cm.bo.base.mgr;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.srpost.cm.bo.base.auth.AuthBean;
import com.srpost.cm.bo.base.auth.AuthItemBean;
import com.srpost.cm.bo.base.login.LoginBean;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.spi.crypto.SalmonCrypto;

import static com.srpost.salmon.constant.Constant.*;
import static com.srpost.salmon.constant.StringPool.*;

/**
 * 내부단 직원 정보 세션 Util
 *
 * @author  finkle
 * @date    2014-10-14
 * @since   2.0
 */
public final class MgrUtil {

    public static final String DEFAULT_PHOTO = "/resources/base/images/shared/nophoto.png";

    /* 직원 세션 체크 */
    public static boolean hasSession(HttpServletRequest request) {
        return hasSession(request.getSession());
    }
    public static boolean hasSession(HttpSession session) {
        return getSession(session) != null;
    }
    
	/* 직원 세션 얻기 */
	public static LoginBean getSession(HttpServletRequest request) {
        return getSession(request.getSession());
    }
    public static LoginBean getSession(HttpSession session) {
        return (LoginBean)session.getAttribute(MGR_SESSION_KEY);
    }
    
    /* 직원 세션 설정 */
    public static void setSession(HttpServletRequest request, LoginBean bean) {
        setSession(request.getSession(), bean);
    }
    public static void setSession(HttpSession session, LoginBean bean) {
        if (getSession(session) != null) {
            removeSession(session);
        }
        session.setAttribute(MGR_SESSION_KEY, bean);
    }
    
    /* 직원 세션 제거 */
    public static void removeSession(HttpServletRequest request) {
        removeSession(request.getSession());
    }
    public static void removeSession(HttpSession session) {
        session.removeAttribute(MGR_SESSION_KEY);
    }
    
    /* 대리인으로 로그인 여부 확인 */
    public static boolean isAgency(LoginBean loginBean) {
        return loginBean.getMgrAbsenceBean() != null;
    }
    
    /* 권한 보유 여부 체크 */
    public static boolean hasAuthCd(HttpServletRequest request, int authCd) {
        
        return hasAuthCd(getSession(request), authCd);
    }
    public static boolean hasAuthCd(LoginBean loginBean, int authCd) {
        
        if (authCd <= ZERO) return true; 
                
        List<AuthBean> authList = loginBean.getAuthList();
        for (AuthBean item : authList) {
            if (authCd == item.getAuthCd()) return true;
        }
        return false;
    }
    
    /* 메뉴 보유 여부 체크 */
    public static boolean hasMenuCd(HttpServletRequest request, int menuCd) {
        
        if (menuCd <= ZERO) return true;
        
        LoginBean loginBean = getSession(request);
        List<AuthItemBean> authList = loginBean.getAuthItemList();
        for (AuthItemBean item : authList) {
            if ( menuCd == item.getMenuCd()) return true;
        }
        return false;
    }
    
    public static Map<String, Object> getParameterMap(MgrBean bean) {
        
        Map<String, Object> parameterMap = bean.createPagerMap();
        if ( StringUtil.isNotEmpty(bean.getUseYn()) )
            parameterMap.put("useYn", bean.getUseYn());
        if ( StringUtil.isNotEmpty(bean.getMgrId()) )
            parameterMap.put("mgrId", bean.getMgrId());
        if ( StringUtil.isNotEmpty(bean.getDeptCd()) )
            parameterMap.put("deptCd", bean.getDeptCd());
        if ( StringUtil.isNotEmpty(bean.getAuthCd()) )
            parameterMap.put("authCd", bean.getAuthCd());
        if ( StringUtil.isNotEmpty(bean.getExcludeDeptCds()) )
            parameterMap.put("excludeDeptCds", 
                    StringUtil.split(bean.getExcludeDeptCds(), COMMA));
        
        return parameterMap;
    }
    
    public static void setNotNullValue(MgrBean bean) {
        
        if ( StringUtil.isEmpty(bean.getAlimYn()) ) bean.setAlimYn(N);
        if ( StringUtil.isEmpty(bean.getEmailYn()) ) bean.setEmailYn(N);
        if ( StringUtil.isEmpty(bean.getSmsYn()) ) bean.setSmsYn(N);
        
        if ( StringUtil.isEmpty(bean.getTheme()) ) bean.setTheme(THEME);
    }
    
    public static void encrypt(MgrBean bean, SalmonCrypto salmonCtypto) {

        if ( StringUtil.isNotEmpty(bean.getMgrEncPwd()) )
            bean.setMgrEncPwd(salmonCtypto.encodePassword(bean.getMgrEncPwd()));
    }
    
    public static void setPhoto(MgrBean bean) {
        
        if (StringUtil.isNotEmpty(bean) && StringUtil.isEmpty(bean.getPhoto())) {
            bean.setPhoto(DEFAULT_PHOTO);
        }
    }
}
