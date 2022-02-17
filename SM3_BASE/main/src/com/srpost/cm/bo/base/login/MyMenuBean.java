package com.srpost.cm.bo.base.login;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.srpost.cm.bo.base.menu.MenuBean;
import com.srpost.salmon.lang.StringUtil;

@SuppressWarnings("unchecked")
public class MyMenuBean {
    
    /** 메뉴 목록 (전체) */
    private List<MenuBean> menuList;
    /** 메뉴 맵 (전체) */
    private Map<Integer, MenuBean> menuMap;
    /** TOP 메뉴 목록 (2레벨 한도) */
    private List<MenuBean> topList = new ArrayList<MenuBean>();
    /** MY PAGE 메뉴 목록 (2레벨 한도) */
    private List<MenuBean> mpList;
    /** SUB 메뉴 목록 (2레벨 한도) */
    private Map<Integer, List<MenuBean>> subMenuMap = new HashMap<Integer, List<MenuBean>>();
    

    public MyMenuBean(List<MenuBean> myMenuList, Map<Integer, MenuBean> myMenuMap) {
        
        if (StringUtil.isEmpty(myMenuList))
            return;
        
        this.menuList = myMenuList;
        this.menuMap = myMenuMap;
        
        for (MenuBean item : myMenuList) {
            if ( item.getMenuCd() == 2 ) {
                mpList = (List<MenuBean>)item.getChildren();
            }
            else {
                topList.add(item);
            }
            subMenuMap.put(item.getMenuCd(), (List<MenuBean>)item.getChildren());
        }
    }
    
    public List<MenuBean> getMenuList() {
        return menuList;
    }
    public void setMenuList(List<MenuBean> menuList) {
        this.menuList = menuList;
    }
    public List<MenuBean> getTopList() {
        return topList;
    }
    public void setTopList(List<MenuBean> topList) {
        this.topList = topList;
    }
    public List<MenuBean> getMpList() {
        return mpList;
    }
    public void setMpList(List<MenuBean> mpList) {
        this.mpList = mpList;
    }
    public Map<Integer, List<MenuBean>> getSubMenuMap() {
        return subMenuMap;
    }
    public void setSubMenuMap(Map<Integer, List<MenuBean>> subMenuMap) {
        this.subMenuMap = subMenuMap;
    }
    public Map<Integer, MenuBean> getMenuMap() {
        return menuMap;
    }
    public void setMenuMap(Map<Integer, MenuBean> menuMap) {
        this.menuMap = menuMap;
    }
}
