package com.srpost.cm.bo.base.menu.front;

import org.apache.ibatis.type.Alias;

import com.srpost.cm.bo.base.menu.MenuBean;
import com.srpost.cm.bo.base.mgr.MgrBean;

/**
 * 내부단 프론트 메뉴 정보 Bean
 *
 * @author  finkle
 * @date    2014-10-14
 * @since   2.0
 */
@Alias("menuFrontBean")
@SuppressWarnings("serial")
public class MenuFrontBean extends MenuBean {

    
    /** 도메인_코드 */
    private Integer domainCd;
    /** 담당자_ID */
    private String mgrId;
    /** 담당자_이름 */
    private String mgrNm;
    /** 담당자 Bean */
    private MgrBean mgrBean;
    
    /** 메뉴_유형 */
    private String typeCd;
    /** 표시_여부 */
    private String showYn = "Y";
    
    
    public Integer getDomainCd() {
        return domainCd;
    }
    public void setDomainCd(Integer domainCd) {
        this.domainCd = domainCd;
    }
    public String getMgrId() {
        return mgrId;
    }
    public void setMgrId(String mgrId) {
        this.mgrId = mgrId;
    }
    public String getMgrNm() {
        return mgrNm;
    }
    public void setMgrNm(String mgrNm) {
        this.mgrNm = mgrNm;
    }
    public MgrBean getMgrBean() {
        return mgrBean;
    }
    public void setMgrBean(MgrBean mgrBean) {
        this.mgrBean = mgrBean;
    }
    public String getTypeCd() {
        return typeCd;
    }
    public void setTypeCd(String typeCd) {
        this.typeCd = typeCd;
    }
    public String getShowYn() {
        return showYn;
    }
    public void setShowYn(String showYn) {
        this.showYn = showYn;
    }
}
