package com.srpost.cm.bo.base.bbs.core;

import java.lang.reflect.Array;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.srpost.cm.bo.base.bbs.conf.BbsConfBean;
import com.srpost.cm.bo.base.bbs.conf.BbsConfUtil;
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
public class BbsDao extends EgovAbstractMapper {

    @Resource
    FileDao fileDao;
    @Resource
    MgrDao mgrDao;
    @Resource
    BbsExtDao bbsExtDao;
    
    @Resource(name = "bbsSeqGenerator")
    ISalmonSeqGenerator seqGenerator;
    

    public BasePagerBean list(BbsBean bean, BbsConfBean confBean) {
        
        Map<String, Object> parameterMap = BbsUtil.getParameterMap(bean);
        
        List<BbsBean> dataList = selectList("_bbs.list", parameterMap);
        int totalCount = (Integer)selectOne("_bbs.listCount", parameterMap);

        if (StringUtil.isNotEmpty(confBean.getTableNm())) {
            bbsExtDao.list(dataList, confBean);
        }
        
        return new BasePagerBean(dataList, totalCount, bean);
    }
    
    public List<Map<String, Object>> listExcel(BbsBean bean, BbsConfBean confBean) {
    	
        Map<String, Object> parameterMap = BbsUtil.getParameterMap(bean);
    	
        BbsExcelRowHandler rowHandler = new BbsExcelRowHandler();
        
    	if ( StringUtil.equals(bean.getXlsScope(), BbsBean.SCOPE_TOTAL)) {
    		getSqlSession().select("_bbs.listExcel", parameterMap, rowHandler);
    	}
    	else {
    	    getSqlSession().select("_bbs.list", parameterMap, rowHandler);
    	}
    	
    	List<Map<String, Object>> dataList = rowHandler.getList();
    	
    	if (StringUtil.isNotEmpty(confBean.getTableNm())) {
            bbsExtDao.listExcel(dataList, confBean);
        }
    	
    	return dataList;
    }
    
    public BbsBean view(BbsBean bean, BbsConfBean confBean, boolean needUpdateReadCnt) {
        
        BbsBean dataBean = selectOne("_bbs.view", bean);
        if (dataBean != null) {
            
            if (StringUtil.equals(confBean.getFileYn(), Y))
                dataBean.setFileList( fileDao.list(dataBean.getFileSeq()) );
            
            if (StringUtil.isNotEmpty(confBean.getTableNm())) {
                dataBean.setExtMap(bbsExtDao.view(dataBean, confBean));
            }
            
            /*-- 의견글 목록 설정
            if (StringUtil.equals(confBean.getCmtYn(), Y))
                dataBean.setCommentList(null);
            --*/
            
            dataBean.setAlertNms(BbsUtil.getAlertNms(dataBean.getAlertCds()));
            
            if (needUpdateReadCnt) {
                update("_bbs.updateReadCnt", bean);
            }
        }
        return dataBean;
    }
    
    public BbsBean viewWithPrevNext(BbsBean bean, BbsConfBean confBean, boolean needUpdateReadCnt) {
        
        BbsBean dataBean = view(bean, confBean, needUpdateReadCnt);
        
        Map<String, Object> parameterMap = BbsUtil.getParameterMap(bean);
        parameterMap.put("bbsSeq", bean.getBbsSeq());
        
        dataBean.setPrevNextBean((BasePrevNextBean)selectOne("_bbs.prevNext", parameterMap));
        
        return dataBean;
    }
    
    public synchronized int insertAction(BbsBean bean, BbsConfBean confBean) {
        
        int affected = ZERO;
        
        if (StringUtil.isEmpty(bean.getBbsSeq())) {
            
            BbsUtil.setNotNullValue(bean, confBean);
            
            if (StringUtil.equals(confBean.getTypeCd(), BbsConfUtil.QNA)) {
                if( StringUtil.isEmpty(bean.getStatusCd()) ){
                    bean.setStatusCd(BbsConfUtil.RECEIVE);
                }
            }
            
            bean.setBbsSeq(seqGenerator.getNextInteger());
            bean.setRefSeq((Integer)selectOne("_bbs.viewMinRefSeq", bean));
            bean.setDepth(ZERO);
            bean.setOrderNo(ZERO);
            bean.setFileSeq(fileDao.insertAction(bean.getFileList()));
            
            affected = insert("_bbs.insert", bean);
            if (affected == ONE) {
                
                if (StringUtil.isNotEmpty(confBean.getTableNm())) {
                    bbsExtDao.insertAction(bean, confBean);
                }
                
                afterInsertOrReply(bean, confBean);
            }
        }
        else {
            if (StringUtil.equals(confBean.getTypeCd(), BbsConfUtil.QNA)) {
                // 답변형 게시판 처리 완료
                BbsUtil.setReplyInfo(bean);
                
                affected = endReplyAction(bean, confBean);
            } 
            else {
                // 계층형 게시판 댓글 등록
                affected = replyAction(bean, confBean);
            }
        }
        
        return affected;
    }
    
    public synchronized int replyAction(BbsBean bean, BbsConfBean confBean) {
        
        BbsUtil.setNotNullValue(bean, confBean);
        
        bean.setFileSeq( fileDao.insertAction(bean.getFileList()) );
        
        // 상위 게시물의 계층정보 설정
        BbsBean parentBean = (BbsBean)selectOne("_bbs.viewParent", bean);
        bean.setRefSeq(parentBean.getRefSeq());
        bean.setDepth(parentBean.getDepth() + 1);
        bean.setOrderNo(parentBean.getOrderNo() + 1);
        
        // 반 업데이트를 위한 대상 게시물 추출
        List<BbsBean> relativeList = selectList("_bbs.relativeList", bean);
        for (BbsBean item : relativeList) {
            if ( bean.getDepth() > item.getDepth() )
                break;
            else
                bean.setOrderNo(item.getOrderNo()+1);
        }
        
        // 반 업데이트
        update("_bbs.updateRelativeList", bean);

        bean.setBbsSeq(seqGenerator.getNextInteger());
        
        int affected = insert("_bbs.insert", bean);
        if (affected == ONE) {
            
            if (StringUtil.isNotEmpty(confBean.getTableNm())) {
                bbsExtDao.replyAction(bean, confBean);
            }
            
            afterInsertOrReply(parentBean, confBean);
        }
        return affected;
    }
    
    public int endReplyAction(BbsBean bean, BbsConfBean confBean) {
        
        bean.setStatusCd(BbsConfUtil.COMPLETE);
        
        int affected = update("_bbs.updateReply", bean);
        
        return affected;
    }

    public int updateAction(BbsBean bean, BbsConfBean confBean) {
        
        BbsUtil.setNotNullValue(bean, confBean);

        if ( StringUtil.isNotEmpty(bean.getFileIds()) ) {
            fileDao.deleteAction(bean.getFileSeq(), bean.getFileIds());
        }
        
        bean.setFileSeq( fileDao.insertAction(bean.getFileList(), bean.getFileSeq()) );
        
        int affected = update("_bbs.update", bean);
        if (affected == ONE) {
            
            if (StringUtil.isNotEmpty(confBean.getTableNm())) {
                bbsExtDao.updateAction(bean, confBean);
            }
        }
        return affected;
    }

    public int deleteAction(BbsBean bean) {
        
        if (StringUtil.isNotEmpty(bean.getBbsSeqs())) {
            
            List<Integer> fileSeqList = selectList("_bbs.listFileSeq", bean);
            
            BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
            
            int affected = ZERO;
            
            if (StringUtil.equals(confBean.getTypeCd(), BbsConfUtil.HIERARCHY)) {
                
                for (Integer bbsSeq : bean.getBbsSeqs()) {
                    
                    BbsBean paramBean = new BbsBean();
                    paramBean.setBbsCd(bean.getBbsCd());
                    paramBean.setBbsSeq(bbsSeq);
                    
                    BbsBean dataBean = selectOne("_bbs.view", paramBean);
                    dataBean.setOrderNo(dataBean.getOrderNo() + ONE);
                    dataBean.setDepth(dataBean.getDepth() + ONE);
                    
                    Integer childCount = selectOne("_bbs.childCount", dataBean);

                    if (childCount > ZERO) {
                        affected += delete("_bbs.updateForDelete", dataBean);
                    }
                    else {
                        affected += delete("_bbs.deleteOne", dataBean);
                    }
                }
            }
            else {
                affected = delete("_bbs.delete", bean);
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
    
    public List<BbsBean> listForDashboard(BbsBean bean) {
        
        Map<String, Object> parameterMap = BbsUtil.getParameterMap(bean);
        
        return selectList("_bbs.list", parameterMap);
    }
    
    
    /* 글, 댓글 등록 후 게시판 관리자에게 알림 */
    private void afterInsertOrReply(BbsBean bean, BbsConfBean confBean) {
        
        /*--
        // 게시판 관리자에게 알림
        if ( StringUtil.equals(Y, confBean.getAlimYn()) ) {
            // 본인이 작성한 글이 아닐 경우에만 알림
            List<BbsMgrBean> mgrList = confBean.getMgrList();
            
            for (BbsMgrBean item : mgrList) {
                if ( !StringUtil.equals(bean.getMgrId(), item.getMgrId()) ) {
                    MgrBean mgrBean = mgrDao.view(item.getMgrId());
                    
                    // mgrBean에게 알림 메시지 발송 !!!!
                }
            }
        }
        --*/
    }
}
