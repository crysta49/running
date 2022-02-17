package com.srpost.cm.fe2.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.srpost.salmon.lang.StringUtil;

/**
 * 사용자단 메뉴 인터셉터
 * 
 * @author sasha
 * @deprecated com.srpost.cm.fe.common.interceptor.FeMenuFrontInterceptor로 대체됨
 */
public class Fe2MenuFrontInterceptor extends HandlerInterceptorAdapter {
    
    private final String MENU_KEY = "__menuKey";

    @Override
    public boolean preHandle(HttpServletRequest request,
            HttpServletResponse response, Object handler) throws Exception {
        
        HttpSession session = request.getSession();
        String sessionMenuKey = (String)session.getAttribute(MENU_KEY);
        
        String menuKey = request.getParameter("_m");
        if ( StringUtil.isEmpty(menuKey) ) {
            if ( StringUtil.isEmpty(sessionMenuKey) ) {
                menuKey = "home";
            }
            else {
                menuKey = sessionMenuKey;
            }
        }
        else {
            if ( !menuKey.equals(sessionMenuKey) ) {
                session.setAttribute(MENU_KEY, menuKey);
            }
        }
        
        request.setAttribute("menuKey", menuKey);
        
        return true;
    }

}
