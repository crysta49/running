package com.srpost.cm.bo.base.auth;

import static com.srpost.salmon.constant.StringPool.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.srpost.salmon.constant.Constant;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.spi.egov.ISalmonSeqGenerator;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 내부단 권한 DAO
 *
 * @author  finkle
 * @date    2014-11-06
 * @since   3.0
 */
@Repository
public class AuthDao extends EgovAbstractMapper {

    @Resource(name = "authSeqGenerator")
    ISalmonSeqGenerator seqGenerator;
    
    public List<AuthBean> list() {
        
        return selectList("_auth.list");
    }
    
    public AuthBean view(AuthBean bean) {
        
        return (AuthBean)selectOne("_auth.view", bean);
    }
    
    public synchronized int insertAction(AuthBean bean) {

        bean.setAuthCd(seqGenerator.getNextInteger());
        
        return insert("_auth.insert", bean);
    }

    public int updateAction(AuthBean bean) {
        
        return update("_auth.update", bean);
    }

    public int deleteAction(AuthBean bean) {
        
        return delete("_auth.delete", bean);
    }
    
    public List<Map<String, Object>> listAuthItemAll(AuthBean bean) {
        
        Map<String, Integer> parameterMap = new HashMap<String, Integer>();
        parameterMap.put("topMenuCd", Constant.TOP_MENU_CD);
        parameterMap.put("authCd", bean.getAuthCd());
        
        AuthItemRowHandler rowHandler = new AuthItemRowHandler();
        
        getSqlSession().select("_auth.listAuthItemAll", parameterMap, rowHandler);
        
        return rowHandler.getList();
    }
    
    public int crudAction(Integer authCd, String[] updates) {
        
        /* 배열 정보 
         * menuCd^readYn^createYn^updateYn^deleteYn
         */
        
        delete("_auth.deleteAuthItem", authCd);
        
        if (StringUtil.isNotEmpty(updates)) {

            for (String item : updates) {
                String[] items = StringUtil.split(item, HAT);
                AuthItemBean bean = new AuthItemBean();
                bean.setAuthCd(authCd);
                bean.setMenuCd(Integer.parseInt(items[0]));
                bean.setReadYn(Boolean.valueOf(items[1]) ? Y : N);
                bean.setCreateYn(Boolean.valueOf(items[2]) ? Y : N);
                bean.setUpdateYn(Boolean.valueOf(items[3]) ? Y : N);
                bean.setDeleteYn(Boolean.valueOf(items[4]) ? Y : N);
                
                insert("_auth.insertAuthItem", bean);
            }
        }
        
        return ONE;
    }
    
    public List<AuthAssignBean> listAuthAssign(String mgrId) {
        
        return selectList("_auth.listAuthAssign", mgrId);
    }
    
    public int updateAuthAssignAction(String mgrId, String[] authCds) {
        
        /* 배열 정보 
         * authCd^Y
         */

        delete("_auth.deleteAuthAssign", mgrId);
        
        if (StringUtil.isNotEmpty(authCds)) {
            
            for (String item : authCds) {
                String[] items = StringUtil.split(item, HAT);
                if ( StringUtil.equals(items[1], Y) ) {
                    AuthAssignBean bean = new AuthAssignBean();
                    bean.setMgrId(mgrId);
                    bean.setAuthCd(Integer.parseInt(items[0]));
                    
                    insert("_auth.insertAuthAssign", bean);
                }
            }
        }
        
        insertAuthAssignLog(mgrId);
        
        return ONE;
    }
    
    public List<AuthAssignLogBean> listAuthAssignLog(String mgrId) {
        
        return selectList("_auth.listAuthAssignLog", mgrId);
    }
    
    
    public List<AuthBean> listAuthByLogin(String mgrId) {
        
        return selectList("_auth.listAuthByLogin", mgrId);
    }
    
    public List<AuthItemBean> listAuthItemByLogin(String mgrId) {
        
        return selectList("_auth.listAuthItemByLogin", mgrId);
    }
    
    
    /*
     * 권한 변경이력 저장
     */
    private void insertAuthAssignLog(String mgrId) {
        
        String newStr;
        
        List<AuthAssignBean> newAssignList = listAuthAssign(mgrId);

        StringBuilder newAssignStr = new StringBuilder();
        for (AuthAssignBean item : newAssignList) {
            if (StringUtil.equals(item.getChecked(), Y))
                newAssignStr.append(item.getAuthNm()).append(", ");
        }

        if ( newAssignStr.length() == ZERO )
            newStr = "할당권한 없음";
        else
            newStr = newAssignStr.substring(0, newAssignStr.length()-2);

        AuthAssignLogBean authAssignLogBean = new AuthAssignLogBean();
        authAssignLogBean.setMgrId(mgrId);
        authAssignLogBean.setLogContents(newStr);
        
        insert("_auth.insertAuthAssignLog", authAssignLogBean);
    }
}
