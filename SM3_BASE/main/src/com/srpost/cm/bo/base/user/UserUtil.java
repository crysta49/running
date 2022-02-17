package com.srpost.cm.bo.base.user;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.spi.crypto.SalmonCrypto;

import static com.srpost.salmon.constant.Constant.USER_SESSION_KEY;

/**
 * 고객 정보 세션 Util
 *
 * @author  finkle
 * @date    2014-11-14
 * @since   2.0
 */
public final class UserUtil {

    /*----------------------------------------------------------------------------
     * 고객 유형 (CO_CODE_PRV : USER_TYPE)
     */
    public static final String REGISTER   = "400";   // 회원가입
    public static final String REALNAME   = "401";   // 실명인증
    public static final String MOBILE     = "402";   // 휴대폰인증
    public static final String IPIN       = "403";   // I-PIN, G-PIN
    public static final String AUTO_GEN   = "404";   // 자동생성
    public static final String MGR_REGIST = "405";   // 관리자 임의등록
    
    public static final String MGR_REGIST_NM  = "관리자 임의등록";
    
    /* 개인정보 조회 목적 */
    public static final int PUP_VIEW = 1000;
    public static final int PUP_UPDATE = 2000;
    
    
    /* 고객 세션 체크 */
    public static boolean hasSession(HttpServletRequest request) {
        return hasSession(request.getSession());
    }
    public static boolean hasSession(HttpSession session) {
        return getSession(session) != null;
    }
    
	/* 고객 세션 얻기 */
	public static UserBean getSession(HttpServletRequest request) {
        return getSession(request.getSession());
    }
    public static UserBean getSession(HttpSession session) {
        return (UserBean)session.getAttribute(USER_SESSION_KEY);
    }
    
    /* 고객 세션 설정 */
    public static void setSession(HttpServletRequest request, UserBean bean) {
        setSession(request.getSession(), bean);
    }
    public static void setSession(HttpSession session, UserBean bean) {
        session.setAttribute(USER_SESSION_KEY, bean);
    }
    
    /* 고객 세션 제거 */
    public static void removeSession(HttpServletRequest request) {
        removeSession(request.getSession());
    }
    public static void removeSession(HttpSession session) {
        session.removeAttribute(USER_SESSION_KEY);
    }
    
    public static Map<String, Object> getParameterMap(UserBean bean) {
        
        Map<String, Object> parameterMap = bean.createPagerMap();
        if ( StringUtil.isNotEmpty(bean.getUseYn()) )
            parameterMap.put("useYn", bean.getUseYn());
        if ( StringUtil.isNotEmpty(bean.getTypeCd()) )
            parameterMap.put("typeCd", bean.getTypeCd());
        
        return parameterMap;
    }
    
    public static void setNotNullValue(UserBean bean) {
        
        if ( StringUtil.isEmpty(bean.getUserKey()) ) {
            if ( StringUtil.isEmpty(bean.getUserId()) ) {
                bean.setTypeCd(UserUtil.AUTO_GEN);
                bean.setUserKey(createUserKey());
            }
            else
                bean.setUserKey(bean.getUserId());
        }
    }
    
    /* 사용자 KEY 생성 */
    public static String createUserKey() {
        
        String currentTime = String.valueOf(System.currentTimeMillis());
        
        return "USER_".concat(currentTime);
    }
    
    public static void encrypt(List<UserBean> list, SalmonCrypto salmonCtypto) {
        
        if (StringUtil.isEmpty(list)) return;
        
        for (UserBean item : list) {
            encrypt(item, salmonCtypto);
        }
    }
    
    public static void decrypt(List<UserBean> list, SalmonCrypto salmonCtypto) {
        
        if (StringUtil.isEmpty(list)) return;
        
        for (UserBean item : list) {
            decrypt(item, salmonCtypto);
        }
    }
    
    public static void encrypt(UserBean bean, SalmonCrypto salmonCtypto) {

        if ( StringUtil.isNotEmpty(bean.getUserEncPwd()) )
            bean.setUserEncPwd(salmonCtypto.encodePassword(bean.getUserEncPwd()));
        
        if ( StringUtil.isNotEmpty( bean.getUserEncTelNum()) ) 
            bean.setUserEncTelNum(salmonCtypto.encrypt(bean.getUserEncTelNum()));
        
        if ( StringUtil.isNotEmpty( bean.getUserEncMobile()) ) 
            bean.setUserEncMobile(salmonCtypto.encrypt(bean.getUserEncMobile()));
        
        if ( StringUtil.isNotEmpty( bean.getUserEncEmail()) ) 
            bean.setUserEncEmail(salmonCtypto.encrypt(bean.getUserEncEmail()));
    }

    public static void decrypt(UserBean bean, SalmonCrypto salmonCtypto) {

        if ( StringUtil.isNotEmpty(bean.getUserEncTelNum()) ) 
            bean.setUserEncTelNum(salmonCtypto.decrypt(bean.getUserEncTelNum()));
        
        if ( StringUtil.isNotEmpty(bean.getUserEncMobile()) ) 
            bean.setUserEncMobile(salmonCtypto.decrypt(bean.getUserEncMobile()));
        
        if ( StringUtil.isNotEmpty(bean.getUserEncEmail()) ) 
            bean.setUserEncEmail(salmonCtypto.decrypt(bean.getUserEncEmail()));
    }
}
