package com.srpost.cm.bo.base.bbs.ntc;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.srpost.cm.bo.base.bbs.conf.BbsConfBean;
import com.srpost.cm.bo.base.bbs.conf.BbsConfCache;
import com.srpost.cm.bo.base.bbs.core.BbsUtil;
import com.srpost.cm.bo.base.login.LoginBean;
import com.srpost.cm.bo.base.mgr.MgrUtil;
import com.srpost.salmon.cache.Cache;
import com.srpost.salmon.constant.Constant;
import com.srpost.salmon.constant.StringPool;
import com.srpost.salmon.lang.CookieUtil;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.lang.WebUtil;

import static com.srpost.salmon.constant.StringPool.MINUS_ONE;
import static com.srpost.salmon.constant.StringPool.UNDERSCORE;
import static com.srpost.salmon.constant.StringPool.Y;



/**
 * 내부단 게시판 공지글 정보 Util
 *
 * @author  finkle
 * @date    2014-11-17
 * @since   3.0
 */
public final class BbsNtcUtil {
    
    public static Map<String, Object> getParameterMap(BbsNtcBean bean) {
        
        Map<String, Object> parameterMap = bean.createPagerMap();
        parameterMap.put("bbsCd", bean.getBbsCd());
        
        return parameterMap;
    }
    
    public static void setNotNullValue(BbsNtcBean bean) {
        
        if (StringUtil.isEmpty(bean.getFileSeq()))
            bean.setFileSeq(MINUS_ONE);
        
        if (StringUtil.isNotEmpty(bean.getStartDd()))
            bean.setStartDd(StringUtil.removeChars(bean.getStartDd(), StringPool.DASH));
        if (StringUtil.isNotEmpty(bean.getEndDd()))
            bean.setEndDd(StringUtil.removeChars(bean.getEndDd(), StringPool.DASH));
        
        HttpServletRequest request = WebUtil.getCurrentRequest();
        
        LoginBean loginBean = MgrUtil.getSession(request);
        bean.setMgrId(loginBean.getMgrId());
    }
    
    public static boolean hasAuth(HttpServletRequest request, Integer bbsCd) {
        
        return BbsUtil.hasAuth(request, bbsCd);
    }
    public static boolean hasAuth(HttpServletRequest request, String mgrId) {
        
        return BbsUtil.hasAuth(request, mgrId);
    }
    
    public static boolean needUpdateReadCnt(
            BbsNtcBean bean, HttpServletRequest request, HttpServletResponse response) {

        String key = "NTC" + UNDERSCORE + bean.getBbsCd() + UNDERSCORE + bean.getNtcSeq();
        
        String value = CookieUtil.getCookie(request, key);
        if (!StringUtil.equals(value, Y)) {
            CookieUtil.setCookie(response, key, Y, Constant.READ_CNT_MINUTES);
            return true;
        }
        return false;
    }
    
    @SuppressWarnings("unchecked")
    public static List<BbsConfBean> confList() {
        
        List<BbsConfBean> resultList = new ArrayList<BbsConfBean>();
        
        List<BbsConfBean> confList = (List<BbsConfBean>)Cache.get(BbsConfCache.LIST_KEY);
        for (BbsConfBean item : confList) {
            if (StringUtil.equals(Y, item.getNtcYn()))
                resultList.add(item);
        }
        return resultList;
    }
}
