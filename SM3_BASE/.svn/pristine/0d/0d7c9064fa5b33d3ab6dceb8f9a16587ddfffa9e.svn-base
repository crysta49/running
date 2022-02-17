package com.srpost.salmon.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.srpost.cm.bo.base.user.UserUtil;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.exception.UserHttpSessionRequireException;

/**
 * 사용자단 로그인 세션 체크 인터셉터 
 * 
 * @date    2020-10-05
 */
public class UserSessionCheckInterceptor extends HandlerInterceptorAdapter {

    @SuppressWarnings("unused")
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Override
    public boolean preHandle(HttpServletRequest request,
            HttpServletResponse response, Object handler) throws Exception {
        
        if ( !UserUtil.hasSession(request) ) {
            throw new UserHttpSessionRequireException( Message.get(Message.FRONT_LOGIN_REQUIRE_KEY, request) );
        }
        
        return true;
    }
}
