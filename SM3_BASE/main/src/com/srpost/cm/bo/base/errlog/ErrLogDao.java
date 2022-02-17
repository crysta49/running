package com.srpost.cm.bo.base.errlog;

import static com.srpost.salmon.constant.StringPool.*;

import java.lang.reflect.Array;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.srpost.salmon.bean.BasePagerBean;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.spi.egov.ISalmonSeqGenerator;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 내부단 에러로그 DAO
 *
 * @author  finkle
 * @date    2014-10-27
 * @since   2.0
 */
@Repository
public class ErrLogDao extends EgovAbstractMapper {
    
    @Resource(name = "errLogSeqGenerator")
    ISalmonSeqGenerator seqGenerator;

    public BasePagerBean list(ErrLogBean bean) {
        
        Map<String, Object> parameterMap = ErrLogUtil.getParameterMap(bean);
        
        List<ErrLogBean> dataList = selectList("_errLog.list", parameterMap);
        int totalCount = (Integer)selectOne("_errLog.listCount", parameterMap);

        return new BasePagerBean(dataList, totalCount, bean);
    }
    
    public List<Map<String, Object>> listExcel(ErrLogBean bean) {
    	
        Map<String, Object> parameterMap = ErrLogUtil.getParameterMap(bean);
    	
        ErrLogExcelRowHandler rowHandler = new ErrLogExcelRowHandler();
        
    	if ( StringUtil.equals(bean.getXlsScope(), ErrLogBean.SCOPE_TOTAL)) {
    		getSqlSession().select("_errLog.listExcel", parameterMap, rowHandler);
    	}
    	else {
    	    getSqlSession().select("_errLog.list", parameterMap, rowHandler);
    	}
    	
    	return rowHandler.getList();
    }
    
    public ErrLogBean view(ErrLogBean bean) {
        
        return (ErrLogBean)selectOne("_errLog.view", bean);
    }
    
    public synchronized Object insertAction(ErrLogBean bean) {
        
        ErrLogUtil.setNotNullValue(bean);
        bean.setSeq(seqGenerator.getNextInteger());
        
        int affected = insert("_errLog.insert", bean);
        if (affected == ONE) {
            return bean.getSeq();
        }
        return null;
    }

    public int updateAction(ErrLogBean bean) {
        
        return update("_errLog.update", bean);
    }

    public int deleteAction(ErrLogBean bean) {
        
        if (StringUtil.isNotEmpty(bean.getSeqs())) {
            int affected = delete("_errLog.delete", bean);
            if (affected == Array.getLength(bean.getSeqs())) 
                return ONE;
        }
        
        return ZERO;
    }
}
