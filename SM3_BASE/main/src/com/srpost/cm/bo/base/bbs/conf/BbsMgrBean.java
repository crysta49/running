package com.srpost.cm.bo.base.bbs.conf;

import org.apache.ibatis.type.Alias;

import com.srpost.salmon.bean.BaseBean;

/**
 * 내부단 게시판설정 관리자정보 Bean
 *
 * @author  finkle
 * @date    2014-11-10
 * @since   2.0
 */
@Alias("bbsMgrBean")
@SuppressWarnings("serial")
public class BbsMgrBean extends BaseBean {
    
    /** 게시판_코드 */
    private Integer bbsCd;
    /** 게시판_명 */
    private String bbsNm;
    /** 담당자_아이디 */
    private String mgrId;
    /** 담당자_명 */
    private String mgrNm;
    
    /** 부서_명 */
    private String deptNm;
    
    
    public Integer getBbsCd() {
        return bbsCd;
    }
    public void setBbsCd(Integer bbsCd) {
        this.bbsCd = bbsCd;
    }
    public String getBbsNm() {
        return bbsNm;
    }
    public void setBbsNm(String bbsNm) {
        this.bbsNm = bbsNm;
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
    public String getDeptNm() {
        return deptNm;
    }
    public void setDeptNm(String deptNm) {
        this.deptNm = deptNm;
    }
}
