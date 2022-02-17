package com.srpost.salmon.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.srpost.salmon.constant.Constant;

public class FilterExceptionInterceptor extends HandlerInterceptorAdapter {
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        
        // SalmonFilter의 forceXss가 true일때 파일업로드 처리를 filter에서 처리함 
        // >> 파일업로드 관련 exception 발생해도 csrf오류라고 메시지 표시됨 
        // 그래서 csrf 인터셉터 전에 filter에서발생한 exception들을 처리해주는 인터셉터 추가
        
        Object exMultipart = request.getAttribute(Constant.MULTIPART_EXCEPTION_KEY);
        if ( exMultipart!= null && exMultipart instanceof MultipartException ) {
            // 파일업로드 관련 오류는 그대로 다시던짐 > GlobalControllerExceptionHandler에서 처리해줌.
            throw (MultipartException)exMultipart;
        }
        
        return true;
    }
}