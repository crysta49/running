package com.srpost.cm.fe.common.interceptor;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.AntPathMatcher;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.srpost.cm.bo.base.menu.front.MenuFrontBean;
import com.srpost.cm.bo.base.menu.front.MenuFrontCache;
import com.srpost.salmon.cache.Cache;
import com.srpost.salmon.lang.StringUtil;

/**
 * 사용자단 메뉴 인터셉터
 * 
 * @author  finkle
 * @date    2015-12-29
 * @since   3.0
 */
@SuppressWarnings("unchecked")
public class FeMenuFrontInterceptor extends HandlerInterceptorAdapter {

    @Resource
    AntPathMatcher pathMatcher;
    
    public boolean preHandle(HttpServletRequest request,
            HttpServletResponse response, Object handler) throws Exception {
        
        Map<String, List<MenuFrontBean>> cacheMap = 
                (Map<String, List<MenuFrontBean>>)Cache.get(MenuFrontCache.DOMAIN_MAP_KEY);
        
        if (cacheMap == null) return true;

        Map<String, List<MenuFrontBean>> topMenuMap = 
                (Map<String, List<MenuFrontBean>>)Cache.get(MenuFrontCache.TOP_MENU_MAP_KEY);
        
        Map<Integer, MenuFrontBean> allMap = 
                (Map<Integer, MenuFrontBean>)Cache.get(MenuFrontCache.ALL_MENU_MAP_KEY);

        // 요청 도메인 체크 후 해당하는 메뉴목록 로드
        String domain = request.getServerName();
        List<MenuFrontBean> menuList = cacheMap.get(domain);

        if (menuList == null) return true;
        
        List<MenuFrontBean> topMenuList = topMenuMap.get(domain);
        if (topMenuList == null) return true;
        
        // 1. 최상단 메뉴 목록
        request.setAttribute("topMenuList", topMenuList);
        
        // 2. 전체 메뉴 목록
        request.setAttribute("allMenuList", menuList);

        // 요청 URL 체크 후 해당하는 메뉴정보 로드
        String reqUri = request.getRequestURI();
        String query = request.getQueryString();
        if (StringUtil.isNotEmpty(query))
            reqUri += "?" + query;

        // 3. 현재 페이지 MenuBean
        MenuFrontBean currentMenuBean = findMenu(menuList, reqUri);
        request.setAttribute("currentMenuBean", currentMenuBean);
        
        // 4. 현재 위치
        List<MenuFrontBean> locList = new ArrayList<MenuFrontBean>();
        if (currentMenuBean != null) {
            MenuFrontBean mfBean = allMap.get(currentMenuBean.getMenuCd());
            
            locList.add(mfBean);
            
            locRecursive(allMap, locList, mfBean.getHighMenuCd());
        }
        
        Collections.reverse(locList);
        
        request.setAttribute("locList", locList);
        
        // 5. 현재페이지 담당자
        if (currentMenuBean != null) {
            request.setAttribute("currentMgrBean", currentMenuBean.getMgrBean());
        }
        
        return true;
    }

    private void locRecursive(Map<Integer, MenuFrontBean> allMap, List<MenuFrontBean> locList, Integer menuCd) {
        
        MenuFrontBean mfBean = allMap.get(menuCd);
        if (mfBean != null && mfBean.getMenuCd() != mfBean.getDomainCd()) {
            locList.add(mfBean);
            locRecursive(allMap, locList, mfBean.getHighMenuCd());
        }
    }
    
    private MenuFrontBean findMenu(List<MenuFrontBean> menuList, String reqUri) {
        
        if (StringUtil.isEmpty(menuList)) return null;
        
        for (MenuFrontBean item : menuList) {

            if ( StringUtil.isNotEmpty(item.getChildren()) ) {
                MenuFrontBean currentMenuBean = findMenu((List<MenuFrontBean>)item.getChildren(), reqUri);
                if (currentMenuBean != null) return currentMenuBean;
            }
            
            if ( StringUtil.isEmpty(item.getMenuPattern()) ) continue;
            
            if ( pathMatcher.match(item.getMenuPattern(), reqUri) ) {
                return item;
            }
        }
        return null;
    }
}
