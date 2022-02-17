package com.srpost.cm.bo.base.mgr;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.srpost.salmon.bean.BasePagerBean;
import com.srpost.salmon.lang.StringUtil;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

import static com.srpost.salmon.constant.StringPool.ONE;

/**
 * 내부단 직원관리 DAO
 *
 * @author  finkle
 * @date    2014-11-05
 * @since   2.0
 */
@Repository
public class MgrDao extends EgovAbstractMapper {

    public BasePagerBean list(MgrBean bean) {
        
        Map<String, Object> parameterMap = MgrUtil.getParameterMap(bean);
        
        List<MgrBean> dataList = selectList("_mgr.list", parameterMap);
        int totalCount = (Integer)selectOne("_mgr.listCount", parameterMap);

        return new BasePagerBean(dataList, totalCount, bean);
    }
    
    public List<Map<String, Object>> listExcel(MgrBean bean) {
        
        Map<String, Object> parameterMap = MgrUtil.getParameterMap(bean);
        
        MgrExcelRowHandler rowHandler = new MgrExcelRowHandler();
        
        if ( StringUtil.equals(bean.getXlsScope(), MgrBean.SCOPE_TOTAL)) {
            getSqlSession().select("_mgr.listExcel", parameterMap, rowHandler);
        }
        else {
            getSqlSession().select("_mgr.list", parameterMap, rowHandler);
        }
        
        return rowHandler.getList();
    }
    
    public MgrBean view(MgrBean bean) {
        
        return view(bean.getMgrId());
    }
    
    public MgrBean view(String mgrId) {
        
        MgrBean dataBean = selectOne("_mgr.view", mgrId);
        MgrUtil.setPhoto(dataBean);
        
        return dataBean;
    }
    
    public Object insertAction(MgrBean bean) {
        
        MgrUtil.setNotNullValue(bean);
        
        int affected = insert("_mgr.insert", bean);
        if (affected == ONE) {
            return bean.getMgrId();
        }
        return null;
    }

    public int updateAction(MgrBean bean) {
        
        MgrUtil.setNotNullValue(bean);
        
        return update("_mgr.update", bean);
    }

    public int deleteAction(MgrBean bean) {
        
        return delete("_mgr.delete", bean);
    }
    
    public int updateLoginAction(MgrBean bean) {
        
        return update("_mgr.updateLogin", bean);
    }
    
    public int photoDeleteAction(MgrBean bean) {
        
        return update("_mgr.photoDelete", bean);
    }
    
    public int updateThemeAction(MgrBean bean) {
        
        return update("_mgr.updateTheme", bean);
    }
    
    public List<MgrBean> listAll(MgrBean bean) {
        
        Map<String, Object> parameterMap = MgrUtil.getParameterMap(bean);
        
        return selectList("_mgr.listAll", parameterMap);
    }
}
