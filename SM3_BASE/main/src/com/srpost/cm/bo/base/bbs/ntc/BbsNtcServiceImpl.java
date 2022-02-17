package com.srpost.cm.bo.base.bbs.ntc;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.srpost.salmon.bean.BasePagerBean;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 내부단 게시판 공지글 서비스 구현체
 *
 * @author  finkle
 * @date    2014-11-17
 * @since   2.0
 */
@Service
public class BbsNtcServiceImpl extends EgovAbstractServiceImpl implements IBbsNtcService {

    @Resource
    BbsNtcDao dao;

    @Override
    public BasePagerBean list(BbsNtcBean bean) {
        
        return dao.list(bean);
    }
    
    @Override
    public List<Map<String, Object>> listExcel(BbsNtcBean bean) {
        
        return dao.listExcel(bean);
    }

    @Override
    public BbsNtcBean view(BbsNtcBean bean, boolean needUpdateReadCnt) {
        
        return dao.view(bean, needUpdateReadCnt);
    }

    @Override
    public int insertAction(BbsNtcBean bean) {
        
        return dao.insertAction(bean);
    }

    @Override
    public int updateAction(BbsNtcBean bean) {
        
        return dao.updateAction(bean);
    }

    @Override
    public int deleteAction(BbsNtcBean bean) {
        
        return dao.deleteAction(bean);
    }

    @Override
    public List<BbsNtcBean> workList(Integer bbsCd) {

        return dao.workList(bbsCd);
    }

    @Override
    public BbsNtcBean workView(BbsNtcBean bean, boolean needUpdateReadCnt) {

        return view(bean, needUpdateReadCnt);
    }
}
