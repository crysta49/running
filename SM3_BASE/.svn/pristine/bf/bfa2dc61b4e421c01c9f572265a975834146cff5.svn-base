package com.srpost.cm.fe.bbs;

import javax.servlet.http.HttpServletRequest;

import com.srpost.cm.bo.base.bbs.conf.BbsConfBean;
import com.srpost.cm.bo.base.user.UserBean;
import com.srpost.cm.bo.base.user.UserUtil;
import com.srpost.salmon.constant.StringPool;
import com.srpost.salmon.lang.StringUtil;



/**
 * 외부단 게시판 정보 Util
 *
 * @author  finkle
 * @date    2015-12-29
 * @since   3.0
 */
public final class FeBbsUtil {
    
    public static boolean hasAuth(HttpServletRequest request, String userKey) {
        
        UserBean userBean = UserUtil.getSession(request);
        
        if (userBean == null) return false;
        
        return StringUtil.equals(userBean.getUserKey(), userKey);
    }
}
