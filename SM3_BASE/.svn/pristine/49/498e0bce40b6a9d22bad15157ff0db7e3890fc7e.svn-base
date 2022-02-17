package com.srpost.cm.bo.si.ipFilter.interceptor;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.srpost.cm.bo.si.ipFilter.IpFilterBean;
import com.srpost.cm.bo.si.ipFilter.IpFilterDao;
import com.srpost.cm.bo.si.ipFilter.IpUtil;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.exception.AuthorizationException;
import com.srpost.salmon.lang.StringUtil;

public class IpFilterInterceptor extends HandlerInterceptorAdapter {

    private Logger logger = LoggerFactory.getLogger(getClass());
    private List<IpFilterBean> ipList = new ArrayList<IpFilterBean>();

    @Resource
    IpFilterDao ipDao;
    
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        ipList = ipDao.simpleList();
        
        if ( StringUtil.isEmpty(ipList) ) {
            return true;
        }
        
        String clientIpAddr = IpUtil.getUserIp(request);
        
        for (int i = 0; i < ipList.size(); i++) {
            String startIp = ipList.get(i).getStartIp();
            String endIp = ipList.get(i).getEndIp();
            
            if ( IpUtil.isPermitIp(startIp, endIp, clientIpAddr, true) ) {
                return true;
            }
        }
        
        logger.warn(clientIpAddr + " => Access denied to admin page.");

        throw new AuthorizationException(Message.get("base.login.admin.access.fail", request));
    }

}
