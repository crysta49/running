package com.srpost.cm.bo.base.mgr;

import org.apache.ibatis.type.Alias;

import com.srpost.salmon.bean.BaseListBean;

/**
 * 내부단 직원정보 Bean
 *
 * @author  finkle
 * @date    2014-10-14
 * @since   2.0
 */
@Alias("mgrBean")
@SuppressWarnings("serial")
public class MgrBean extends BaseListBean {
    
    /** 담당자_아이디 */
    private String mgrId;
    /** 담당자_명 */
    private String mgrNm;
    /** 부서_코드 */
    private String deptCd;
    /** 부서_명 */
    private String deptNm;
    /** 담당자_암호화_비밀번호 */
    private String mgrEncPwd;
    /** 직급_명 */
    private String gradeNm;
    /** 역할_명 */
    private String roleNm;
    /** 전화_번호 */
    private String telNum;
    /** 팩스_번호 */
    private String faxNum;
    /** 휴대폰 */
    private String mobile;
    /** 이메일 */
    private String email;
    /** 사진 */
    private String photo;
    /** 로그인_건수 */
    private Integer loginCnt;
    /** 로그인_일시 */
    private String loginDt;
    /** 알림_여부 */
    private String alimYn;
    /** 이메일_여부 */
    private String emailYn;
    /** SMS_여부 */
    private String smsYn;
    /** 연계_아이디 */
    private String connId;
    /** 연계_명 */
    private String connNm;
    /** 테마 */
    private String theme;
    /** 사용_여부 */
    private String useYn;
    /** 등록_일시 */
    private String regDt;
    /** 수정_일시 */
    private String modiDt;
    
    /** 권한그룹 코드 */
    private Integer authCd;
    /** 검색에서 제외할 부서코드 */
    private String excludeDeptCds;
    
    
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
    public String getDeptCd() {
        return deptCd;
    }
    public void setDeptCd(String deptCd) {
        this.deptCd = deptCd;
    }
    public String getDeptNm() {
        return deptNm;
    }
    public void setDeptNm(String deptNm) {
        this.deptNm = deptNm;
    }
    public String getMgrEncPwd() {
        return mgrEncPwd;
    }
    public void setMgrEncPwd(String mgrEncPwd) {
        this.mgrEncPwd = mgrEncPwd;
    }
    public String getGradeNm() {
        return gradeNm;
    }
    public void setGradeNm(String gradeNm) {
        this.gradeNm = gradeNm;
    }
    public String getRoleNm() {
        return roleNm;
    }
    public void setRoleNm(String roleNm) {
        this.roleNm = roleNm;
    }
    public String getTelNum() {
        return telNum;
    }
    public void setTelNum(String telNum) {
        this.telNum = telNum;
    }
    public String getFaxNum() {
        return faxNum;
    }
    public void setFaxNum(String faxNum) {
        this.faxNum = faxNum;
    }
    public String getMobile() {
        return mobile;
    }
    public void setMobile(String mobile) {
        this.mobile = mobile;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public Integer getLoginCnt() {
        return loginCnt;
    }
    public void setLoginCnt(Integer loginCnt) {
        this.loginCnt = loginCnt;
    }
    public String getLoginDt() {
        return loginDt;
    }
    public void setLoginDt(String loginDt) {
        this.loginDt = loginDt;
    }
    public String getAlimYn() {
        return alimYn;
    }
    public void setAlimYn(String alimYn) {
        this.alimYn = alimYn;
    }
    public String getEmailYn() {
        return emailYn;
    }
    public void setEmailYn(String emailYn) {
        this.emailYn = emailYn;
    }
    public String getSmsYn() {
        return smsYn;
    }
    public void setSmsYn(String smsYn) {
        this.smsYn = smsYn;
    }
    public String getConnId() {
        return connId;
    }
    public void setConnId(String connId) {
        this.connId = connId;
    }
    public String getConnNm() {
        return connNm;
    }
    public void setConnNm(String connNm) {
        this.connNm = connNm;
    }
    public String getTheme() {
        return theme;
    }
    public void setTheme(String theme) {
        this.theme = theme;
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
    public Integer getAuthCd() {
        return authCd;
    }
    public void setAuthCd(Integer authCd) {
        this.authCd = authCd;
    }
    public String getExcludeDeptCds() {
        return excludeDeptCds;
    }
    public void setExcludeDeptCds(String excludeDeptCds) {
        this.excludeDeptCds = excludeDeptCds;
    }
    public String getPhoto() {
        return photo;
    }
    public void setPhoto(String photo) {
        this.photo = photo;
    }
}
