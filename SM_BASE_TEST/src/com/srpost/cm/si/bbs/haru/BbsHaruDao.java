package com.srpost.cm.si.bbs.haru;

import java.lang.reflect.Array;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.srpost.cm.bo.base.bbs.conf.BbsConfBean;
import com.srpost.cm.bo.base.bbs.conf.BbsConfUtil;
import com.srpost.cm.bo.base.bbs.core.BbsExcelRowHandler;
import com.srpost.cm.bo.base.bbs.core.ext.BbsExtDao;
import com.srpost.cm.bo.base.file.FileDao;
import com.srpost.cm.bo.base.mgr.MgrDao;
import com.srpost.salmon.bean.BasePagerBean;
import com.srpost.salmon.bean.BasePrevNextBean;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.spi.egov.ISalmonSeqGenerator;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

import static com.srpost.salmon.constant.StringPool.ONE;
import static com.srpost.salmon.constant.StringPool.Y;
import static com.srpost.salmon.constant.StringPool.ZERO;

/**
 * 내부단 게시판 DAO
 *
 * @author  finkle
 * @date    2014-11-17
 * @since   2.0
 */
@Repository
public class BbsHaruDao extends EgovAbstractMapper {

    @Resource
    FileDao fileDao;
    @Resource
    MgrDao mgrDao;
    @Resource
    BbsExtDao bbsExtDao;
    
    @Resource(name = "bbsHaruSeqGenerator")
    ISalmonSeqGenerator seqGenerator;
    

    public BasePagerBean list(BbsHaruBean bean, BbsConfBean confBean) {
        
        Map<String, Object> parameterMap = BbsHaruUtil.getParameterMap(bean);
        
        List<BbsHaruBean> dataList = selectList("_bbsHaru.list", parameterMap);
        int totalCount = (Integer)selectOne("_bbsHaru.listCount", parameterMap);

        if (StringUtil.isNotEmpty(confBean.getTableNm())) {
            bbsExtDao.listHaru(dataList, confBean);
        }
        
        return new BasePagerBean(dataList, totalCount, bean);
    }
    
    public List<Map<String, Object>> listExcel(BbsHaruBean bean, BbsConfBean confBean) {
    	
        Map<String, Object> parameterMap = BbsHaruUtil.getParameterMap(bean);
    	
        BbsExcelRowHandler rowHandler = new BbsExcelRowHandler();
        
    	if ( StringUtil.equals(bean.getXlsScope(), BbsHaruBean.SCOPE_TOTAL)) {
    		getSqlSession().select("_bbsHaru.listExcel", parameterMap, rowHandler);
    	}
    	else {
    	    getSqlSession().select("_bbsHaru.list", parameterMap, rowHandler);
    	}
    	
    	List<Map<String, Object>> dataList = rowHandler.getList();
    	
    	if (StringUtil.isNotEmpty(confBean.getTableNm())) {
            bbsExtDao.listExcel(dataList, confBean);
        }
    	
    	return dataList;
    }
    
    public BbsHaruBean view(BbsHaruBean bean, BbsConfBean confBean, boolean needUpdateReadCnt) {
        
        BbsHaruBean dataBean = selectOne("_bbsHaru.view", bean);
        if (dataBean != null) {
            
            if (StringUtil.equals(confBean.getFileYn(), Y))
                dataBean.setFileList( fileDao.list(dataBean.getFileSeq()) );
            
            if (StringUtil.isNotEmpty(confBean.getTableNm())) {
                dataBean.setExtMap(bbsExtDao.viewHaru(dataBean, confBean));
            }
            
            if (needUpdateReadCnt) {
                update("_bbsHaru.updateReadCnt", bean);
            }
        }
        return dataBean;
    }
    
    public BbsHaruBean viewWithPrevNext(BbsHaruBean bean, BbsConfBean confBean, boolean needUpdateReadCnt) {
        
        BbsHaruBean dataBean = view(bean, confBean, needUpdateReadCnt);
        
        Map<String, Object> parameterMap = BbsHaruUtil.getParameterMap(bean);
        parameterMap.put("bbsSeq", bean.getBbsSeq());
        
        dataBean.setPrevNextBean((BasePrevNextBean)selectOne("_bbsHaru.prevNext", parameterMap));
        
        return dataBean;
    }
    
    public synchronized int insertAction(BbsHaruBean bean, BbsConfBean confBean) {
        
        int affected = ZERO;
        
        if (StringUtil.isEmpty(bean.getBbsSeq())) {
            
            BbsHaruUtil.setNotNullValue(bean, confBean);
            
            if (StringUtil.equals(confBean.getTypeCd(), BbsConfUtil.QNA)) {
                if( StringUtil.isEmpty(bean.getStatusCd()) ){
                    bean.setStatusCd(BbsConfUtil.RECEIVE);
                }
            }
            
            bean.setBbsSeq(seqGenerator.getNextInteger());
            bean.setRefSeq((Integer)selectOne("_bbsHaru.viewMinRefSeq", bean));
            bean.setDepth(ZERO);
            bean.setOrderNo(ZERO);
            bean.setFileSeq(fileDao.insertAction(bean.getFileList()));
            
            affected = insert("_bbsHaru.insert", bean);
            if (affected == ONE) {
                
                if (StringUtil.isNotEmpty(confBean.getTableNm())) {
                    bbsExtDao.insertActionHaru(bean, confBean);
                }
            }
        }
        
        return affected;
    }

    public int updateAction(BbsHaruBean bean, BbsConfBean confBean) {
        
        BbsHaruUtil.setNotNullValue(bean, confBean);

        if ( StringUtil.isNotEmpty(bean.getFileIds()) ) {
            fileDao.deleteAction(bean.getFileSeq(), bean.getFileIds());
        }
        
        bean.setFileSeq( fileDao.insertAction(bean.getFileList(), bean.getFileSeq()) );
        
        int affected = update("_bbsHaru.update", bean);
        if (affected == ONE) {
            
            if (StringUtil.isNotEmpty(confBean.getTableNm())) {
                bbsExtDao.updateActionHaru(bean, confBean);
            }
        }
        return affected;
    }

    public int deleteAction(BbsHaruBean bean) {
        
        if (StringUtil.isNotEmpty(bean.getBbsSeqs())) {
            
            List<Integer> fileSeqList = selectList("_bbsHaru.listFileSeq", bean);
            
            BbsConfBean confBean = BbsHaruUtil.getConfBean(bean.getBbsCd());
            
            int affected = ZERO;
            
            if (StringUtil.equals(confBean.getTypeCd(), BbsConfUtil.HIERARCHY)) {
                
                for (Integer bbsSeq : bean.getBbsSeqs()) {
                    
                    BbsHaruBean paramBean = new BbsHaruBean();
                    paramBean.setBbsCd(bean.getBbsCd());
                    paramBean.setBbsSeq(bbsSeq);
                    
                    BbsHaruBean dataBean = selectOne("_bbsHaru.view", paramBean);
                    dataBean.setOrderNo(dataBean.getOrderNo() + ONE);
                    dataBean.setDepth(dataBean.getDepth() + ONE);
                    
                    Integer childCount = selectOne("_bbsHaru.childCount", dataBean);

                    if (childCount > ZERO) {
                        affected += delete("_bbsHaru.updateForDelete", dataBean);
                    }
                    else {
                        affected += delete("_bbsHaru.deleteOne", dataBean);
                    }
                }
            }
            else {
                affected = delete("_bbsHaru.delete", bean);
            }

            if (affected == Array.getLength(bean.getBbsSeqs())) {
                // 첨부파일 삭제
                for (Integer fileSeq : fileSeqList) {
                    fileDao.deleteAction(fileSeq);
                }
                return ONE;
            }
        }
        return ZERO;
    }
    
    public List<BbsHaruBean> listForDashboard(BbsHaruBean bean) {
        
        Map<String, Object> parameterMap = BbsHaruUtil.getParameterMap(bean);
        
        return selectList("_bbsHaru.list", parameterMap);
    }
}
