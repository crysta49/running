package com.srpost.cm.bo.base.login.log;

import java.util.List;
import java.util.Map;

import com.srpost.salmon.bean.BasePagerBean;

/**
 * 내부단 로그인 로그 서비스 인터페이스
 *
 * @author  finkle
 * @date    2014-09-26
 * @since   2.0
 */
public interface ILoginLogService {

    BasePagerBean list(LoginLogBean bean);
    
    List<Map<String, Object>> listExcel(LoginLogBean bean);
    
    int loginAction(LoginLogBean bean);
    
    int logoutAction(LoginLogBean bean);
}
