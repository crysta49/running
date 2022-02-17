package com.srpost.cm.bo.base.bbs.ntc;

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

import static com.srpost.salmon.constant.StringPool.ONE;
import static com.srpost.salmon.constant.StringPool.ZERO;

/**
 * 내부단 게시판 공지글 DAO
 *
 * @author  finkle
 * @date    2014-11-17
 * @since   2.0
 */
@Repository
public class BbsNtcDao extends EgovAbstractMapper {

    @Resource
    FileDao fileDao;

    @Resource(name = "bbsNtcSeqGenerator")
    ISalmonSeqGenerator seqGenerator;
    
    
    public BasePagerBean list(BbsNtcBean bean) {
        
        Map<String, Object> parameterMap = BbsNtcUtil.getParameterMap(bean);
        
        List<BbsNtcBean> dataList = selectList("_bbsNtc.list", parameterMap);
        int totalCount = (Integer)selectOne("_bbsNtc.listCount", parameterMap);

        return new BasePagerBean(dataList, totalCount, bean);
    }
    
    public List<Map<String, Object>> listExcel(BbsNtcBean bean) {
        
        Map<String, Object> parameterMap = BbsNtcUtil.getParameterMap(bean);
        
        BbsNtcExcelRowHandler rowHandler = new BbsNtcExcelRowHandler();
        
        if ( StringUtil.equals(bean.getXlsScope(), BbsNtcBean.SCOPE_TOTAL)) {
            getSqlSession().select("_bbsNtc.listExcel", parameterMap, rowHandler);
        }
        else {
            getSqlSession().select("_bbsNtc.list", parameterMap, rowHandler);
        }
        
        return rowHandler.getList();
    }
    
    public BbsNtcBean view(BbsNtcBean bean, boolean needUpdateReadCnt) {
        
        BbsNtcBean dataBean = selectOne("_bbsNtc.view", bean);
        if (dataBean != null) {
            
            dataBean.setFileList( fileDao.list(dataBean.getFileSeq()) );
            
            /*-- 의견글 목록 설정
            if (StringUtil.equals(confBean.getCmtYn(), Y))
                dataBean.setCommentList(null);
            --*/
            
            if (needUpdateReadCnt) {
                update("_bbsNtc.updateReadCnt", bean);
            }
        }
        return dataBean;
    }
    
    public synchronized int insertAction(BbsNtcBean bean) {

        BbsNtcUtil.setNotNullValue(bean);

        bean.setNtcSeq(seqGenerator.getNextInteger());
        bean.setFileSeq(fileDao.insertAction(bean.getFileList()));
        
        int affected = insert("_bbsNtc.insert", bean);
        if (affected == ONE) {
        }
        
        return affected;
    }

    public int updateAction(BbsNtcBean bean) {
        
        BbsNtcUtil.setNotNullValue(bean);

        if ( StringUtil.isNotEmpty(bean.getFileIds()) ) {
            fileDao.deleteAction(bean.getFileSeq(), bean.getFileIds());
        }
        
        bean.setFileSeq( fileDao.insertAction(bean.getFileList(), bean.getFileSeq()) );
        
        int affected = update("_bbsNtc.update", bean);
        if (affected == ONE) {
        }
        return affected;
    }

    public int deleteAction(BbsNtcBean bean) {
        
        if (StringUtil.isNotEmpty(bean.getNtcSeqs())) {
            
            List<Integer> fileSeqList = selectList("_bbsNtc.listFileSeq", bean);

            int affected = delete("_bbsNtc.delete", bean);

            if (affected == Array.getLength(bean.getNtcSeqs())) {
                // 첨부파일 삭제
                for (Integer fileSeq : fileSeqList) {
                    fileDao.deleteAction(fileSeq);
                }
                return ONE;
            }
        }
        return ZERO;
    }

    public List<BbsNtcBean> workList(Integer bbsCd) {

        return selectList("_bbsNtc.workList", bbsCd);
    }
}
