package com.srpost.cm.bo.base.user;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.srpost.cm.bo.base.bbs.conf.BbsConfBean;
import com.srpost.cm.bo.base.mgr.MgrUtil;
import com.srpost.salmon.bean.BasePagerBean;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.lang.WebUtil;
import com.srpost.salmon.spi.crypto.SalmonCrypto;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import static com.srpost.salmon.constant.StringPool.*;

/**
 * 고객 정보 DAO
 *
 * @author  finkle
 * @date    2014-11-24
 * @since   2.0
 */
@Repository
public class UserDao extends EgovAbstractMapper {

    public BasePagerBean list(UserBean bean) {
        
        Map<String, Object> parameterMap = UserUtil.getParameterMap(bean);
        
        List<UserBean> dataList = selectList("_user.list", parameterMap);
        int totalCount = (Integer)selectOne("_user.listCount", parameterMap);

        return new BasePagerBean(dataList, totalCount, bean);
    }
    
    public List<Map<String, Object>> listExcel(UserBean bean, SalmonCrypto salmonCtypto) {
        
        Map<String, Object> parameterMap = UserUtil.getParameterMap(bean);
        
        UserExcelRowHandler rowHandler = new UserExcelRowHandler(salmonCtypto);
        
        if ( StringUtil.equals(bean.getXlsScope(), BbsConfBean.SCOPE_TOTAL)) {
            getSqlSession().select("_user.listExcel", parameterMap, rowHandler);
        }
        else {
            getSqlSession().select("_user.list", parameterMap, rowHandler);
        }
        
        return rowHandler.getList();
    }
    
    public UserBean view(UserBean bean, int purporse) {
        
        UserBean dataBean = (UserBean)selectOne("_user.view", bean.getUserKey());
        if (purporse != MINUS_ONE) {
            insertUserLog(dataBean.getUserKey(), purporse);
        }
        return dataBean;
    }
    
    public String insertAction(UserBean bean) {
        
        UserUtil.setNotNullValue(bean);
        
        logger.info("#### userKey [1] #### " + bean.getUserKey() + ", userId : " + bean.getUserId());

        UserBean dataBean = (UserBean)selectOne("_user.view", bean.getUserKey());
        
        int affected = ZERO;
        
        if (dataBean == null) {
            affected = insert("_user.insert", bean);
        }
        else {
            affected = updateAction(bean);
            affected = ONE;
        }
        
        logger.info("#### userKey [2] #### " + (dataBean == null ? "I" : "U") + ", affected " + affected);
        
        if (affected == ONE) {
            return bean.getUserKey();
        }
        
        return EMPTY;
    }

    public int updateAction(UserBean bean) {
        
        UserUtil.setNotNullValue(bean);
        
        return update("_user.update", bean);
    }

    public int deleteAction(UserBean bean) {
        
        return delete("_user.delete", bean);
    }
    
    public int userKeyCnt(String userKey) {
        
        return selectOne("_user.userKeyCnt", userKey);
    }
    
    public List<UserLogBean> listLog(String userKey) {
        
        return selectList("_user.listLog", userKey);
    }
    
    
    private void insertUserLog(String userKey, int purporse) {

        UserLogBean bean = new UserLogBean();
        
        bean.setUserKey(userKey);
        bean.setMgrId(MgrUtil.getSession(WebUtil.getCurrentRequest()).getMgrId());
        if (UserUtil.PUP_VIEW == purporse)
            bean.setLogContents("조회");
        else if (UserUtil.PUP_UPDATE == purporse)
            bean.setLogContents("수정");
        else
            bean.setLogContents("N/A");
        
        insert("_user.insertLog", bean);
    }
}
