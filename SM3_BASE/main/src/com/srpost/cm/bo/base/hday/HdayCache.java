package com.srpost.cm.bo.base.hday;

import javax.annotation.Resource;

import com.srpost.salmon.cache.AbstractCache;
import com.srpost.salmon.cache.Cache;

/**
 * 내부단 공휴일 정보 Cache
 *
 * @author  finkle
 * @date    2014-12-01
 * @since   3.0
 */
public class HdayCache extends AbstractCache {

    public static final String LIST_KEY = "__hd_lk__";

    @Resource
    IHdayService service;
    
    @Override
    public void createCache() {

        Cache.put(LIST_KEY, service.listCache());
    }
    
    @Override
    public void clearCache() {
        
        Cache.clear(LIST_KEY);
    }

    @Override
    public Object getCacheContents() {

        return Cache.get(LIST_KEY);
    }

    @Override
    public String getName() {
        
        return "공휴일 정보";
    }

}
