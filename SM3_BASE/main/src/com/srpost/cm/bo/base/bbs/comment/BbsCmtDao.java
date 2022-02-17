package com.srpost.cm.bo.base.bbs.comment;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.srpost.cm.bo.base.file.FileDao;
import com.srpost.salmon.lang.StringUtil;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

import static com.srpost.salmon.constant.StringPool.ONE;
import static com.srpost.salmon.constant.StringPool.ZERO;

/**
 * 내부단 게시판 의견글 DAO
 *
 * @author  finkle
 * @date    2015-01-23
 * @since   2.0
 */
@Repository
public class BbsCmtDao extends EgovAbstractMapper {

    @Resource
    FileDao fileDao;
    
    
    public List<BbsCmtBean> list(BbsCmtBean bean) {

        List<BbsCmtBean> dataList = selectList("_bbsCmt.list", bean);
        for (BbsCmtBean item : dataList) {
            if (item.getFileSeq() != null && item.getFileSeq() != -1) {
                item.setFileList( fileDao.list(item.getFileSeq()) );
            }
        }
        return dataList;
    }
    
    public BbsCmtBean view(BbsCmtBean bean) {

        BbsCmtBean dataBean = selectOne("_bbsCmt.view", bean);
        
        if (dataBean != null) {
            dataBean.setFileList( fileDao.list(dataBean.getFileSeq()) );
        }
        
        return dataBean;
    }
    
    public int insertAction(BbsCmtBean bean) {

        BbsCmtUtil.setNotNullValue(bean);

        bean.setRefSeq((Integer)selectOne("_bbsCmt.viewMinRefSeq", bean));
        bean.setDepth(ZERO);
        bean.setOrderNo(ZERO);
        bean.setFileSeq( fileDao.insertAction(bean.getFileList()) );
        
        return insert("_bbsCmt.insert", bean);
    }

    public int updateAction(BbsCmtBean bean) {

        BbsCmtUtil.setNotNullValue(bean);

        if ( StringUtil.isNotEmpty(bean.getFileIds()) ) {
            fileDao.deleteAction(bean.getFileSeq(), bean.getFileIds());
        }
        
        bean.setFileSeq( fileDao.insertAction(bean.getFileList(), bean.getFileSeq()) );
        
        return update("_bbsCmt.update", bean);
    }
    
    public int replyAction(BbsCmtBean bean) {

        BbsCmtUtil.setNotNullValue(bean);

        bean.setFileSeq( fileDao.insertAction(bean.getFileList()) );
        
        // 상위 자료의 계층정보 설정
        BbsCmtBean parentBean = (BbsCmtBean)selectOne("_bbsCmt.viewParent", bean);
        bean.setRefSeq(parentBean.getRefSeq());
        bean.setDepth(parentBean.getDepth() + ONE);
        bean.setOrderNo(parentBean.getOrderNo() + ONE);
        
        // 반 업데이트를 위한 대상 자료 추출
        List<BbsCmtBean> relativeList = selectList("_bbsCmt.relativeList", bean);
        for (BbsCmtBean item : relativeList) {
            if ( bean.getDepth() > item.getDepth() )
                break;
            else
                bean.setOrderNo(item.getOrderNo() + ONE);
        }
        
        // 반 업데이트
        update("_bbsCmt.updateRelativeList", bean);
        
        return insert("_bbsCmt.insert", bean);
    }

    public int deleteAction(BbsCmtBean bean) {

        BbsCmtBean dataBean = view(bean);
        dataBean.setOrderNo(dataBean.getOrderNo() + ONE);
        dataBean.setDepth(dataBean.getDepth() + ONE);
        
        Integer childCount = selectOne("_bbsCmt.childCount", dataBean);
        int affected = ZERO;
        
        if (childCount > ZERO) {
            affected = delete("_bbsCmt.updateForDelete", bean);
        }
        else {
            affected = delete("_bbsCmt.delete", bean);
        }
        
        if (affected > ZERO) {
            fileDao.deleteAction(dataBean.getFileSeq());
        }
        
        return affected;
    }
}