package com.srpost.cm.bo.base.login.log;

import org.apache.ibatis.type.Alias;

import com.srpost.cm.bo.base.login.LoginBean;
import com.srpost.salmon.bean.BaseListBean;

/**
 * 내부단 로그인 로그 정보 Bean
 *
 * @author  finkle
 * @date    2014-10-27
 * @since   2.0
 */
@Alias("loginLogBean")
@SuppressWarnings("serial")
public class LoginLogBean extends BaseListBean {
    
    /** 로그일련번호 */
    private Long logSeq;
    /** 담당자_ID */
    private String mgrId;
    /** 담당자_이름 */
    private String mgrNm;
    /** IP_주소 */
    private String ipAddr;
    /** 로그인_일시 */
    private String loginDt;
    /** 로그아웃_일시 */
    private String logOutDt;
    /** 대리인_ID */
    private String agencyId;
    /** 대리인_이름 */
    private String agencyNm;
    
    
    private LoginBean loginBean;
    
    public LoginLogBean() {
    }
    public LoginLogBean(LoginBean loginBean) {

        this(loginBean, null);
    }
    public LoginLogBean(LoginBean loginBean, String ipAddr) {

        this.setLoginBean(loginBean);
        
        this.mgrId = loginBean.getMgrId();
        this.mgrNm = loginBean.getMgrNm();
        this.ipAddr = ipAddr;
    }    
    
    public Long getLogSeq() {
        return logSeq;
    }
    public void setLogSeq(Long logSeq) {
        this.logSeq = logSeq;
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
    public String getIpAddr() {
        return ipAddr;
    }
    public void setIpAddr(String ipAddr) {
        this.ipAddr = ipAddr;
    }
    public String getLoginDt() {
        return loginDt;
    }
    public void setLoginDt(String loginDt) {
        this.loginDt = loginDt;
    }
    public String getLogOutDt() {
        return logOutDt;
    }
    public void setLogOutDt(String logOutDt) {
        this.logOutDt = logOutDt;
    }
    public LoginBean getLoginBean() {
        return loginBean;
    }
    public void setLoginBean(LoginBean loginBean) {
        this.loginBean = loginBean;
    }
    public String getAgencyId() {
        return agencyId;
    }
    public void setAgencyId(String agencyId) {
        this.agencyId = agencyId;
    }
    public String getAgencyNm() {
        return agencyNm;
    }
    public void setAgencyNm(String agencyNm) {
        this.agencyNm = agencyNm;
    }
}
