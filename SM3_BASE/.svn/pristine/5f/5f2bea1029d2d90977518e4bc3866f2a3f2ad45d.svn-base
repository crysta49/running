package com.srpost.cm.bo.base.menu.front;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.srpost.cm.bo.base.domain.DomainBean;
import com.srpost.cm.bo.base.domain.IDomainService;
import com.srpost.salmon.cache.AbstractCache;
import com.srpost.salmon.cache.Cache;
import com.srpost.salmon.lang.StringUtil;

/**
 * 내부단 프론트 메뉴 정보 Cache
 * 
 * @author  finkle
 * @date    2015-12-29
 * @since   3.0
 */
public class MenuFrontCache extends AbstractCache {

    public static final String DOMAIN_MAP_KEY = "__dmk__";
    public static final String ALL_MENU_MAP_KEY = "__ammk__";
    public static final String TOP_MENU_MAP_KEY = "__tmnumk__";
    
    private Map<String, List<MenuFrontBean>> cacheMap = new HashMap<String, List<MenuFrontBean>>();
    
    @Resource
    IMenuFrontService service;
    @Resource
    IDomainService domainService;
    
    @Override
    public void createCache() {
     
        List<DomainBean> domainList = domainService.list();
        if (StringUtil.isEmpty(domainList))
            return;
        
        if (!cacheMap.isEmpty()) {
            cacheMap.clear();
        }
        
        Map<String, List<MenuFrontBean>> topMenuMap = new HashMap<String, List<MenuFrontBean>>();

        for (DomainBean item : domainList) {
            MenuFrontBean paramBean = new MenuFrontBean();
            paramBean.setHighMenuCd(item.getDomainCd());
            paramBean.setDomainCd(item.getDomainCd());
            
            List<MenuFrontBean> dataList = service.listCache(paramBean);
            
            List<MenuFrontBean> topMenuList = new ArrayList<MenuFrontBean>();            
            for (MenuFrontBean mfBean : dataList) {   
                topMenuList.add(mfBean);
            }            
            topMenuMap.put(item.getDomainUrl(), topMenuList);
            
            cacheMap.put(item.getDomainUrl(), dataList);
        }
        
        // TOP 메뉴 목록
        Cache.put(TOP_MENU_MAP_KEY, topMenuMap);
        // 도메인별 메뉴 목록
        Cache.put(DOMAIN_MAP_KEY, cacheMap);
        // 전체 메뉴 목록
        Cache.put(ALL_MENU_MAP_KEY, service.mapAllCache());
    }
    
    @Override
    public void clearCache() {
        
        Cache.clear(TOP_MENU_MAP_KEY);
        Cache.clear(DOMAIN_MAP_KEY);
        Cache.clear(ALL_MENU_MAP_KEY);
    }

    @Override
    public Object getCacheContents() {
        
        return cacheMap;
    }

    @Override
    public String getName() {
        
        return "메뉴 정보 (고객단)";
    }

}
