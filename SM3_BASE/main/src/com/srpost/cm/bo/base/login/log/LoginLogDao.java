package com.srpost.cm.bo.base.login.log;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.srpost.cm.bo.base.login.LoginBean;
import com.srpost.cm.bo.base.mgr.absence.MgrAbsenceBean;
import com.srpost.salmon.bean.BasePagerBean;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.spi.egov.ISalmonSeqGenerator;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

import static com.srpost.salmon.constant.StringPool.*;

/**
 * 내부단 로그인 로그 DAO
 *
 * @author  finkle
 * @date    2014-10-27
 * @since   2.0
 */
@Repository
public class LoginLogDao extends EgovAbstractMapper {

    @Resource(name = "loginLogSeqGenerator")
    ISalmonSeqGenerator seqGenerator;
    
    public BasePagerBean list(LoginLogBean bean) {
        
        Map<String, Object> parameterMap = LoginLogUtil.getParameterMap(bean);
        
        List<LoginLogBean> dataList = selectList("_loginLog.list", parameterMap);
        int totalCount = (Integer)selectOne("_loginLog.listCount", parameterMap);

        return new BasePagerBean(dataList, totalCount, bean);
    }
    
    public List<Map<String, Object>> listExcel(LoginLogBean bean) {
    	
        Map<String, Object> parameterMap = LoginLogUtil.getParameterMap(bean);
    	
        LoginLogExcelRowHandler rowHandler = new LoginLogExcelRowHandler();
        
    	if ( StringUtil.equals(bean.getXlsScope(), LoginBean.SCOPE_TOTAL)) {
    		getSqlSession().select("_loginLog.listExcel", parameterMap, rowHandler);
    	}
    	else {
    	    getSqlSession().select("_loginLog.list", parameterMap, rowHandler);
    	}
    	
    	return rowHandler.getList();
    }
    
    public synchronized int loginAction(LoginLogBean bean) {

        LoginBean loginBean = bean.getLoginBean();
        if (loginBean == null) {
            return MINUS_ONE;
        }
        
        MgrAbsenceBean absenceBean = loginBean.getMgrAbsenceBean();
        if (absenceBean != null) {
            bean.setAgencyId(absenceBean.getMgrId());
        }

        bean.setLogSeq(seqGenerator.getNextLong());
        
        int affected = insert("_loginLog.login", bean);
        if (affected == ONE) {
            loginBean.setLoginLogSeq(bean.getLogSeq());
        }
        return affected;
    }
    
    public int logoutAction(LoginLogBean bean) {

        LoginBean loginBean = bean.getLoginBean();
        if (loginBean == null) {
            return MINUS_ONE;
        }
        
        if (loginBean.getLoginLogSeq() == null) {
            return MINUS_ONE;
        }
        
        bean.setLogSeq(loginBean.getLoginLogSeq());
        
        return insert("_loginLog.logout", bean);
    }
}
