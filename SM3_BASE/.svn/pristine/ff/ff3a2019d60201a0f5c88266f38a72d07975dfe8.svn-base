package com.srpost.cm.bo.si.ipFilter;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.srpost.cm.bo.base.login.LoginBean;
import com.srpost.cm.bo.base.mgr.MgrUtil;
import com.srpost.salmon.lang.WebUtil;

/**
 * IP Util
 *
 * @author  ally
 * @date    2017-06-30
 * @since   3.0
 */
public class IpUtil {
    public static Map<String, Object> getParameterMap(IpFilterBean bean) {
        
        Map<String, Object> parameterMap = bean.createPagerMap();
        
        return parameterMap;
    }
    
    public static void setNotNullValue(IpFilterBean bean) {
        
        HttpServletRequest request = WebUtil.getCurrentRequest();
        LoginBean loginBean = MgrUtil.getSession(request);
        bean.setRegId(loginBean.getMgrId());
    }
    
    
    /**
     * 클라이언트의 ip주소 가져오기
     */
    public static String getUserIp(HttpServletRequest request) {
        
        // web server나 load balancer에 의해 호출되는 경우
        String ip = request.getHeader("X-FORWARDED-FOR");
        
        // proxy 환경일 경우
        if (ip == null) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        // weblogic 서버일 경우
        if (ip == null) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        // 공용 IP 확인
        if (ip == null) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        // php
        if (ip == null) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }
    
    /**
     * String ip값을 Long형으로 변환 
     */
    public static long ipToLong(String ipAddress) {

        String[] ipAddressInArray = ipAddress.split("\\.");

        long result = 0;
        for (int i = 0; i < ipAddressInArray.length; i++) {

            int power = 3 - i;
            int ip = Integer.parseInt(ipAddressInArray[i]);
            result += ip * Math.pow(256, power);
        }

        return result;
    }
    
    /**
     * 허용된 ip 주소 대역인지 확인
     */
    public static boolean isPermitIp(String minIpAddr, String maxIpAddr, String ipAddr, Boolean result){
        
        long LminIpAddr = ipToLong(minIpAddr);
        long LmaxIpAddr = ipToLong(maxIpAddr);
        long LipAddr = ipToLong(ipAddr);
        
        if ( LminIpAddr > LmaxIpAddr ) {
            LminIpAddr = LmaxIpAddr;
            LmaxIpAddr = ipToLong(minIpAddr);
        }
            
        result = (LipAddr >= LminIpAddr && LipAddr <= LmaxIpAddr);
        
        return result;
    }
}
