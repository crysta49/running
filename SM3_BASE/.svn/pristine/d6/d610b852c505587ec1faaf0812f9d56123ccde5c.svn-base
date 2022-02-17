package com.srpost.cm.bo.base.menu;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.AntPathMatcher;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.srpost.cm.bo.base.login.LoginBean;
import com.srpost.cm.bo.base.login.MyMenuBean;
import com.srpost.cm.bo.base.mgr.MgrUtil;
import com.srpost.salmon.constant.StringPool;
import com.srpost.salmon.lang.StringUtil;

/**
 * 메뉴 인터셉터
 *
 * @author  finkle
 * @date    2015-12-29
 * @since   3.0
 */
@SuppressWarnings("unchecked")
public class MenuInterceptor extends HandlerInterceptorAdapter {

    public static final String MY_MENU_JSON_KEY = "__mmjk__";
    
    @Resource
    AntPathMatcher pathMatcher;
    

    public boolean preHandle(HttpServletRequest request,
            HttpServletResponse response, Object handler) throws Exception {

        /*
         * 1. TOP 메뉴 및 하위메뉴 목록 전체
         * 2. TOP 메뉴 키에 해당하는 2단계 메뉴 목록 전체
         */
        
        LoginBean loginBean = MgrUtil.getSession(request);
        
        MyMenuBean myMenuBean = loginBean.getMyMenu();
        
        // 1. 최상단 메뉴 목록
        request.setAttribute("topList", myMenuBean.getTopList());
        // 2. 마이페이지 메뉴 목록
        request.setAttribute("mpList", myMenuBean.getMpList());
        
        // 요청 URL 체크 후 해당하는 메뉴정보 로드
        String reqUri = request.getRequestURI();
        String query = request.getQueryString();
        if (StringUtil.isNotEmpty(query))
            reqUri += "?" + query;

        // 3. 현재 페이지 MenuBean
        MenuBean curMenuBean = findMenu(myMenuBean.getMenuList(), reqUri);
        request.setAttribute("curMenuBean", curMenuBean);
        
        // 4. 현재 위치
        Map<Integer, MenuBean> menuMap = myMenuBean.getMenuMap();
        List<MenuBean> locList = new ArrayList<MenuBean>();
        if (curMenuBean != null) {
            MenuBean mfBean = menuMap.get(curMenuBean.getMenuCd());

            locList.add(mfBean);

            locRecursive(menuMap, locList, mfBean.getHighMenuCd());

            Collections.reverse(locList);
        }

        request.setAttribute("locList", locList);

        if (StringUtil.isNotEmpty(locList)) {
            Integer topMenuCd = locList.get(StringPool.ZERO).getMenuCd();
            request.setAttribute("subList", 
                    myMenuBean.getSubMenuMap().get(topMenuCd));
        }
        
        return true;
    }

    private void locRecursive(Map<Integer, MenuBean> menuMap, List<MenuBean> locList, Integer menuCd) {

        MenuBean mfBean = menuMap.get(menuCd);
        if (mfBean != null) {
            locList.add(mfBean);
            locRecursive(menuMap, locList, mfBean.getHighMenuCd());
        }
    }

    private MenuBean findMenu(List<MenuBean> menuList, String reqUri) {

        if (StringUtil.isEmpty(menuList)) return null;

        for (MenuBean item : menuList) {

            if ( StringUtil.isNotEmpty(item.getChildren()) ) {
                MenuBean currentMenuBean = findMenu((List<MenuBean>)item.getChildren(), reqUri);
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
