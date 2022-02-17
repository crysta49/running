package com.srpost.cm.bo.base.login;

import com.srpost.cm.bo.base.mgr.MgrBean;

/**
 * 내부단 로그인 서비스 인터페이스
 *
 * @author  finkle
 * @date    2014-09-26
 * @since   2.0
 */
public interface ILoginService {

    LoginBean loginAction(MgrBean bean);
    
    LoginBean loginAction(MgrBean bean, boolean isCheckPassword);
}
