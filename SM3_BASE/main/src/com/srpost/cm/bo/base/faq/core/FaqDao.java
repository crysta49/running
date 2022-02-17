package com.srpost.cm.bo.base.faq.core;

import static com.srpost.salmon.constant.StringPool.*;

import java.lang.reflect.Array;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.srpost.cm.bo.base.file.FileDao;
import com.srpost.salmon.bean.BasePagerBean;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.spi.egov.ISalmonSeqGenerator;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 내부단 FAQ관리 DAO
 *
 * @author  finkle
 * @date    2014-11-20
 * @since   2.0
 */
@Repository
public class FaqDao extends EgovAbstractMapper {

    @Resource
    FileDao fileDao;
    
    @Resource(name = "faqSeqGenerator")
    ISalmonSeqGenerator seqGenerator;
    
    
    public BasePagerBean list(FaqBean bean) {
        
        Map<String, Object> parameterMap = FaqUtil.getParameterMap(bean);
        
        List<FaqBean> dataList = selectList("_faq.list", parameterMap);
        int totalCount = (Integer)selectOne("_faq.listCount", parameterMap);

        return new BasePagerBean(dataList, totalCount, bean);
    }
    
    public List<Map<String, Object>> listExcel(FaqBean bean) {
    	
        Map<String, Object> parameterMap = FaqUtil.getParameterMap(bean);
    	
        FaqExcelRowHandler rowHandler = new FaqExcelRowHandler();
        
    	if ( StringUtil.equals(bean.getXlsScope(), FaqBean.SCOPE_TOTAL)) {
    		getSqlSession().select("_faq.listExcel", parameterMap, rowHandler);
    	}
    	else {
    	    getSqlSession().select("_faq.list", parameterMap, rowHandler);
    	}
    	
    	return rowHandler.getList();
    }
    
    public FaqBean view(FaqBean bean, boolean needUpdateReadCnt) {
        
        FaqBean dataBean = (FaqBean)selectOne("_faq.view", bean);
        if (dataBean != null) {
            dataBean.setFileList( fileDao.list(dataBean.getFileSeq()) );
            
            if (needUpdateReadCnt) {
                update("_faq.updateReadCnt", bean);
            }
        }
        return dataBean;
    }
    
    public synchronized int insertAction(FaqBean bean) {
        
        FaqUtil.setNotNullValue(bean);
        
        bean.setFileSeq( fileDao.insertAction(bean.getFileList()) );
        bean.setSeq(seqGenerator.getNextInteger());
        
        int affected = insert("_faq.insert", bean);
        if (affected == ONE) {

        }
        return affected;
    }

    public int updateAction(FaqBean bean) {
        
        FaqUtil.setNotNullValue(bean);
        
        if ( StringUtil.isNotEmpty(bean.getFileIds()) ) {
            fileDao.deleteAction(bean.getFileSeq(), bean.getFileIds());
        }
        bean.setFileSeq( fileDao.insertAction(bean.getFileList(), bean.getFileSeq()) );

        int affected = update("_faq.update", bean);
        if (affected == ONE) {

        }
        return affected;
    }    

    public int deleteAction(FaqBean bean) {
        
        if (StringUtil.isNotEmpty(bean.getSeqs())) {
            List<Integer> fileSeqList = selectList("_faq.listFileSeq", bean);
            
            int affected = delete("_faq.delete", bean);
            if (affected == Array.getLength(bean.getSeqs())) {
                // 첨부파일 삭제
                for (Integer fileSeq : fileSeqList) {
                    fileDao.deleteAction(fileSeq);
                }
                return ONE;
            }
        }
        
        return ZERO;
    }
    
    public int aprvAction(FaqBean bean) {
        
        return update("_faq.updateAprvYn", bean);
    }
    
    public int scoreAction(FaqBean bean) {
        
        if (StringUtil.isNotEmpty(bean.getRecomCnt()))
            return update("_faq.updateRecomCnt", bean.getSeq());
        else
            return update("_faq.updateOppCnt", bean.getSeq());
    }
    
    public List<FaqBean> listForDashboard(FaqBean bean) {
        
        Map<String, Object> parameterMap = FaqUtil.getParameterMap(bean);

        return selectList("_faq.list", parameterMap);
    }
}
