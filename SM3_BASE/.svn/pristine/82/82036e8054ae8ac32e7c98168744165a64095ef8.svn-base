package com.srpost.cm.bo.base.cache;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 내부단 캐시 DAO
 *
 * @author  finkle
 * @date    2014-11-11
 * @since   3.0
 */
@Repository
public class CacheDao extends EgovAbstractMapper {


    public List<CacheBean> list(String address) {
        
        return selectList("_cache.list", address);
    }
    
    public int insertAction(CacheBean bean) {
        
        return insert("_cache.insert", bean);
    }

    public int updateAction(Integer seq) {
        
        return update("_cache.update", seq);
    }
}
