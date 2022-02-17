package com.srpost.cm.bo.base.bbs.comment;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.srpost.salmon.spi.crypto.SalmonCrypto;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 내부단 게시판 의견글 서비스 구현체
 *
 * @author  finkle
 * @date    2015-01-23
 * @since   2.0
 */
@Service
public class BbsCmtServiceImpl extends EgovAbstractServiceImpl implements IBbsCmtService {

    @Resource
    BbsCmtDao dao;
    @Resource
    SalmonCrypto salmonCtypto;

    @Override
    public List<BbsCmtBean> list(BbsCmtBean bean) {

        return dao.list(bean);
    }

    @Override
    public BbsCmtBean view(BbsCmtBean bean) {

        return dao.view(bean);
    }

    @Override
    public int insertAction(BbsCmtBean bean) {

        BbsCmtUtil.encrypt(bean, salmonCtypto);
        
        return dao.insertAction(bean);
    }

    @Override
    public int updateAction(BbsCmtBean bean) {

        return dao.updateAction(bean);
    }

    @Override
    public int replyAction(BbsCmtBean bean) {

        return dao.replyAction(bean);
    }

    @Override
    public int deleteAction(BbsCmtBean bean) {

        return dao.deleteAction(bean);
    }

    
}
