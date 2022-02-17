package com.srpost.cm.bo.base.bbs.core;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.srpost.cm.bo.base.bbs.conf.BbsConfBean;
import com.srpost.salmon.bean.BasePagerBean;
import com.srpost.salmon.spi.crypto.SalmonCrypto;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 내부단 게시판 서비스 구현체
 *
 * @author  finkle
 * @date    2014-11-17
 * @since   2.0
 */
@Service
public class BbsServiceImpl extends EgovAbstractServiceImpl implements IBbsService {

    @Resource
    BbsDao dao;
    @Resource
    SalmonCrypto salmonCtypto;

    @Override
    public BasePagerBean list(BbsBean bean, BbsConfBean confBean) {
        
        return dao.list(bean, confBean);
    }
    
    @Override
    public List<Map<String, Object>> listExcel(BbsBean bean, BbsConfBean confBean) {
        
        return dao.listExcel(bean, confBean);
    }

    @Override
    public BbsBean view(BbsBean bean, BbsConfBean confBean, boolean needUpdateReadCnt) {
        
        return dao.view(bean, confBean, needUpdateReadCnt);
    }
    
    @Override
    public BbsBean viewWithPrevNext(BbsBean bean, BbsConfBean confBean, boolean needUpdateReadCnt) {
        
        return dao.viewWithPrevNext(bean, confBean, needUpdateReadCnt);
    }

    @Override
    public int insertAction(BbsBean bean, BbsConfBean confBean) {
        
        BbsUtil.encrypt(bean, salmonCtypto);
        
        return dao.insertAction(bean, confBean);
    }

    @Override
    public int updateAction(BbsBean bean, BbsConfBean confBean) {
        
        return dao.updateAction(bean, confBean);
    }

    @Override
    public int deleteAction(BbsBean bean) {
        
        return dao.deleteAction(bean);
    }
    
    @Override
    public List<BbsBean> listForDashboard(BbsBean bean) {
        
        return dao.listForDashboard(bean);
    }
}
