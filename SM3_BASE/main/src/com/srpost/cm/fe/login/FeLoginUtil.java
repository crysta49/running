package com.srpost.cm.fe.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.srpost.cm.bo.base.user.UserBean;
import com.srpost.salmon.lang.StringUtil;

/**
 * 고객단 인증처리 Util
 * 
 * @author  finkle
 * @date    2015-12-29
 * @since   2.0
 */
public class FeLoginUtil {

    /**
     * 로그인 액션 레퍼러 및 로그인 페이지 세션 체크
     */
    public static boolean isValidReferer(HttpServletRequest request) {
        
        String refererUri = request.getHeader("referer");

        if (refererUri.indexOf("/fe/login/NR_index.do") == -1) return false;
        
        HttpSession session = request.getSession();
        String sessionId = (String)session.getAttribute("SESSION_ID");
        if ( StringUtil.isEmpty(sessionId) ) return false;
        
        return true;
    }
    
    /**
     * 회원 로그인 : ID & 비밀번호 체크
     */
    public static boolean isValidLoginInfo(UserBean bean) {
        
        if ( StringUtil.isEmpty(bean.getUserKey()) )return false;
        if ( StringUtil.isEmpty(bean.getUserEncPwd()) )return false;
        
        return true;
    }
    
    /**
     * 실명인증 : 주민번호 & 이름 체크
     */
    public static boolean isValidRealNameInfo(String rrn, String name) {

        if ( StringUtil.isEmpty(rrn) ) return false;
        if ( StringUtil.isEmpty(name) ) return false;
        
        return true;
    }
}
