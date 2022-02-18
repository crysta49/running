package com.srpost.cm.si.bbs.haru;

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
public class BbsHaruServiceImpl extends EgovAbstractServiceImpl implements IBbsHaruService {

    @Resource
    BbsHaruDao dao;
    @Resource
    SalmonCrypto salmonCtypto;

    @Override
    public BasePagerBean list(BbsHaruBean bean, BbsConfBean confBean) {
        
        return dao.list(bean, confBean);
    }
    
    @Override
    public List<Map<String, Object>> listExcel(BbsHaruBean bean, BbsConfBean confBean) {
        
        return dao.listExcel(bean, confBean);
    }

    @Override
    public BbsHaruBean view(BbsHaruBean bean, BbsConfBean confBean, boolean needUpdateReadCnt) {
        
        return dao.view(bean, confBean, needUpdateReadCnt);
    }
    
    @Override
    public BbsHaruBean viewWithPrevNext(BbsHaruBean bean, BbsConfBean confBean, boolean needUpdateReadCnt) {
        
        return dao.viewWithPrevNext(bean, confBean, needUpdateReadCnt);
    }

    @Override
    public int insertAction(BbsHaruBean bean, BbsConfBean confBean) {
        
        BbsHaruUtil.encrypt(bean, salmonCtypto);
        
        return dao.insertAction(bean, confBean);
    }

    @Override
    public int updateAction(BbsHaruBean bean, BbsConfBean confBean) {
        
        return dao.updateAction(bean, confBean);
    }

    @Override
    public int deleteAction(BbsHaruBean bean) {
        
        return dao.deleteAction(bean);
    }
}
