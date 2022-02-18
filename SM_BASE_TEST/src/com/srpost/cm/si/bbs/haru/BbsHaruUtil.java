package com.srpost.cm.si.bbs.haru;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.srpost.cm.bo.base.bbs.conf.BbsConfBean;
import com.srpost.cm.bo.base.bbs.conf.BbsConfCache;
import com.srpost.cm.bo.base.bbs.conf.BbsMgrBean;
import com.srpost.cm.bo.base.login.LoginBean;
import com.srpost.cm.bo.base.mgr.MgrUtil;
import com.srpost.cm.bo.base.user.UserBean;
import com.srpost.cm.bo.base.user.UserUtil;
import com.srpost.salmon.cache.Cache;
import com.srpost.salmon.constant.Constant;
import com.srpost.salmon.lang.CookieUtil;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.lang.WebUtil;
import com.srpost.salmon.spi.crypto.SalmonCrypto;

import static com.srpost.salmon.constant.StringPool.*;



/**
 * 내부단 게시판 정보 Util
 *
 * @author  finkle
 * @date    2014-11-17
 * @since   3.0
 */
public final class BbsHaruUtil {
    
    public static Map<String, Object> getParameterMap(BbsHaruBean bean) {
        
        Map<String, Object> parameterMap = bean.createPagerMap();
        parameterMap.put("bbsCd", bean.getBbsCd());
        if ( StringUtil.isNotEmpty(bean.getCtgCd()) )
            parameterMap.put("ctgCd", bean.getCtgCd());
        if ( StringUtil.isNotEmpty(bean.getOpenYn()) )
            parameterMap.put("openYn", bean.getOpenYn());
        if ( StringUtil.isNotEmpty(bean.getDelYn()) )
            parameterMap.put("delYn", bean.getDelYn());
        if ( StringUtil.isNotEmpty(bean.getStatusCd()) )
            parameterMap.put("statusCd", bean.getStatusCd());
        
        return parameterMap;
    }
    
    public static void setNotNullValue(BbsHaruBean bean, BbsConfBean confBean) {
        
        if (StringUtil.isEmpty(bean.getFileSeq()))
            bean.setFileSeq(MINUS_ONE);
        
        if (StringUtil.isEmpty(bean.getOpenYn()))
            bean.setOpenYn(Y);
        
        HttpServletRequest request = WebUtil.getCurrentRequest();
        String requestUri = request.getRequestURI();
        
        if (StringUtil.isNotEmpty(confBean.getTableNm())) {
            bean.setExtMap( getColumnMapFromRequest(request, confBean) );
        }
        
        if (requestUri.indexOf("/bo/") != -1) {
            if (StringUtil.equals(Y, confBean.getHtmlYn()))
                bean.setHtmlYn(Y);
            else 
                bean.setHtmlYn(N);
        }
        else
            bean.setHtmlYn(N);
        
        if (requestUri.indexOf("/bo/") != -1) {
            LoginBean loginBean = MgrUtil.getSession(request);
            bean.setMgrId(loginBean.getMgrId());
            bean.setWriterNm(loginBean.getMgrNm());
        }
        else {
            UserBean userBean = UserUtil.getSession(request);
            if (userBean != null) {
                bean.setUserKey(userBean.getUserKey());
                bean.setWriterNm(userBean.getUserNm());
            }
        }
    }

    
    public static void encrypt(BbsHaruBean bean, SalmonCrypto salmonCtypto) {

        if ( StringUtil.isNotEmpty(bean.getWriterEncPwd()) )
            bean.setWriterEncPwd(salmonCtypto.encodePassword(bean.getWriterEncPwd()));
    }
    
    public static BbsConfBean getConfBean(Integer bbsCd) {
        
        return (BbsConfBean)Cache.get(BbsConfCache.VIEW_KEY + bbsCd);
    }
    
    public static boolean hasAuth(HttpServletRequest request, Integer bbsCd) {
        
        LoginBean loginBean = MgrUtil.getSession(request);
        
        BbsConfBean confBean = getConfBean(bbsCd);
        
        if (confBean == null) return false;
        
        if (StringUtil.equals(confBean.getAdmYn(), N)) {
            return true;
        }
        
        List<BbsMgrBean> mgrList = confBean.getMgrList();
        
        if (StringUtil.isEmpty(mgrList))
            return false;
        
        for (BbsMgrBean bean : mgrList) {
            if (StringUtil.equals(loginBean.getMgrId(), bean.getMgrId()))
                return true;
        }
        return false;
    }
    public static boolean hasAuth(HttpServletRequest request, String mgrId) {
        
        LoginBean loginBean = MgrUtil.getSession(request);
        
        return StringUtil.equals(loginBean.getMgrId(), mgrId);
    }
    
    public static Map<String, Object> getColumnMapFromRequest(
            HttpServletRequest request, BbsConfBean confBean) {
        
        Map<String, Object> columnMap = new HashMap<String, Object>();
        
        List<String> columns = confBean.getColumnList();
        if ( StringUtil.isEmpty(columns) ) {
            return columnMap;
        }
        
        for (String column : columns) {
            String value = request.getParameter(column);
            columnMap.put(column, StringUtil.isEmpty(value) ? EMPTY : value);
        }
        
        return columnMap;
    }
    
    public static boolean needUpdateReadCnt(
            BbsHaruBean bean, HttpServletRequest request, HttpServletResponse response) {

        String key = "BBS" + UNDERSCORE + bean.getBbsCd() + UNDERSCORE + bean.getBbsSeq();
        
        String value = CookieUtil.getCookie(request, key);
        if (!StringUtil.equals(value, Y)) {
            CookieUtil.setCookie(response, key, Y, Constant.READ_CNT_MINUTES);
            return true;
        }
        return false;
    }
}
