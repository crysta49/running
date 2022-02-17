package com.srpost.cm.bo.base.auth;

import org.apache.ibatis.type.Alias;

import com.srpost.salmon.bean.BaseBean;

/**
 * 내부단 직원 권한할당 맵핑 정보 Bean
 *
 * @author  finkle
 * @date    2014-11-07
 * @since   3.0
 */
@Alias("authAssignBean")
@SuppressWarnings("serial")
public class AuthAssignBean extends BaseBean {
    
    /** 권한_코드 */
    private Integer authCd;
    /** 권한_명 */
    private String authNm;
    /** 담당자_아이디 */
    private String mgrId;
    /** 담당자_명 */
    private String mgrNm;
    
    /** 할당 여부 */
    private String checked;
    
    
    public Integer getAuthCd() {
        return authCd;
    }
    public void setAuthCd(Integer authCd) {
        this.authCd = authCd;
    }
    public String getAuthNm() {
        return authNm;
    }
    public void setAuthNm(String authNm) {
        this.authNm = authNm;
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
    public String getChecked() {
        return checked;
    }
    public void setChecked(String checked) {
        this.checked = checked;
    }
}
