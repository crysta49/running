package com.srpost.cm.bo.base.menu;

import java.util.List;

import org.apache.ibatis.type.Alias;

import com.srpost.cm.bo.base.auth.AuthBean;
import com.srpost.salmon.bean.BaseTreeBean;
import com.srpost.salmon.constant.Constant;

/**
 * 내부단 메뉴 정보 Bean
 *
 * @author  finkle
 * @date    2014-10-14
 * @since   2.0
 */
@Alias("menuBean")
@SuppressWarnings("serial")
public class MenuBean extends BaseTreeBean {

    /** 디폴트 최상위 메뉴코드 */
    private Integer topMenuCd = Constant.TOP_MENU_CD; 
    
    
    /** 메뉴_코드 */
    private Integer menuCd;
    /** 메뉴_명 */
    private String menuNm;
    /** 상위_메뉴_코드 */
    private Integer highMenuCd;
    /** 상위_메뉴_명 */
    private String highMenuNm;
    /** 정렬_순서 */
    private Integer orderNo;
    /** 메뉴_URL */
    private String menuUrl;
    /** 메뉴_패턴 */
    private String menuPattern;
    /** 메뉴_아이디 */
    private String menuId;
    /** 메뉴_아이콘 */
    private String menuIcon;
    /** 사용_여부 */
    private String useYn;
    /** 구분선_여부 */
    private String dividerYn = "N";
    /** 등록_일시 */
    private String regDt;
    /** 수정_일시 */
    private String modiDt;
    
    /** 직원 ID */
    private String mgrId;
    /** 할당된 권한그룹 목록 */
    private List<AuthBean> authList;
    
    
    public Integer getTopMenuCd() {
        return topMenuCd;
    }
    public void setTopMenuCd(Integer topMenuCd) {
        this.topMenuCd = topMenuCd;
    }
    public Integer getMenuCd() {
        return menuCd;
    }
    public void setMenuCd(Integer menuCd) {
        this.menuCd = menuCd;
    }
    public String getMenuNm() {
        return menuNm;
    }
    public void setMenuNm(String menuNm) {
        this.menuNm = menuNm;
    }
    public Integer getHighMenuCd() {
        return highMenuCd;
    }
    public void setHighMenuCd(Integer highMenuCd) {
        this.highMenuCd = highMenuCd;
    }
    public String getHighMenuNm() {
        return highMenuNm;
    }
    public void setHighMenuNm(String highMenuNm) {
        this.highMenuNm = highMenuNm;
    }
    public Integer getOrderNo() {
        return orderNo;
    }
    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
    }
    public String getMenuUrl() {
        return menuUrl;
    }
    public void setMenuUrl(String menuUrl) {
        this.menuUrl = menuUrl;
    }
    public String getMenuPattern() {
        return menuPattern;
    }
    public void setMenuPattern(String menuPattern) {
        this.menuPattern = menuPattern;
    }
    public String getMenuId() {
        return menuId;
    }
    public void setMenuId(String menuId) {
        this.menuId = menuId;
    }
    public String getUseYn() {
        return useYn;
    }
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }
    public String getRegDt() {
        return regDt;
    }
    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }
    public String getModiDt() {
        return modiDt;
    }
    public void setModiDt(String modiDt) {
        this.modiDt = modiDt;
    }
    public String getMgrId() {
        return mgrId;
    }
    public void setMgrId(String mgrId) {
        this.mgrId = mgrId;
    }
    public List<AuthBean> getAuthList() {
        return authList;
    }
    public void setAuthList(List<AuthBean> authList) {
        this.authList = authList;
    }
    public String getMenuIcon() {
        return menuIcon;
    }
    public void setMenuIcon(String menuIcon) {
        this.menuIcon = menuIcon;
    }
    public String getDividerYn() {
        return dividerYn;
    }
    public void setDividerYn(String dividerYn) {
        this.dividerYn = dividerYn;
    }
}
