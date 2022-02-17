package com.srpost.cm.bo.base.cache;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 내부단 캐시 서비스 구현체
 *
 * @author  finkle
 * @date    2014-11-11
 * @since   3.0
 */
@Service
public class CacheServiceImpl extends EgovAbstractServiceImpl implements ICacheService {

    @Resource
    CacheDao dao;
    
    @Override
    public List<CacheBean> list(String address) {
        
        return dao.list(address);
    }

    @Override
    public int insertAction(CacheBean bean) {
        
        return dao.insertAction(bean);
    }
    
    @Override
    public int updateAction(Integer seq) {
        
        return dao.updateAction(seq);
    }
}
