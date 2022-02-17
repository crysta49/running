package com.srpost.cm.bo.base.bbs.comment;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.util.UrlPathHelper;

import com.srpost.cm.bo.base.login.LoginBean;
import com.srpost.cm.bo.base.mgr.MgrUtil;
import com.srpost.cm.bo.base.user.UserBean;
import com.srpost.cm.bo.base.user.UserUtil;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.spi.crypto.SalmonCrypto;

/**
 * 내부단 게시판 의견글 Util
 *
 * @author  finkle
 * @date    2015-01-23
 * @since   3.0
 */
public final class BbsCmtUtil {

    public static void setNotNullValue(BbsCmtBean bean) {
    }
    
    public static void setWriterlValue(BbsCmtBean bean, HttpServletRequest request) {

        String url = new UrlPathHelper().getRequestUri(request);

        if (url.indexOf("/bo/") != -1) {
            LoginBean loginBean = MgrUtil.getSession(request);
            bean.setMgrId(loginBean.getMgrId());
            bean.setWriterNm(loginBean.getMgrNm());
        }
        else {
            UserBean userBean = UserUtil.getSession(request);
            bean.setUserKey(userBean.getUserKey());
            bean.setWriterNm(userBean.getUserNm());
        }
    }
    
    public static void encrypt(BbsCmtBean bean, SalmonCrypto salmonCtypto) {

        if ( StringUtil.isNotEmpty(bean.getWriterEncPwd()) )
            bean.setWriterEncPwd(salmonCtypto.encodePassword(bean.getWriterEncPwd()));
    }
    
    /* 본인 작성 글 여부 확인 */
    public static boolean isOwner(BbsCmtBean bean, HttpServletRequest request) {
        
        String url = new UrlPathHelper().getRequestUri(request);
        
        if (url.indexOf("/bo/") != -1) {
            LoginBean loginBean = MgrUtil.getSession(request);
            if (loginBean == null) return false;
            return StringUtil.equals(loginBean.getMgrId(), bean.getMgrId());
        }
        else {
            UserBean userBean = UserUtil.getSession(request);
            if (userBean == null) return false;
            return StringUtil.equals(userBean.getUserKey(), bean.getUserKey());
        }
    }
}
