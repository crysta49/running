package com.srpost.cm.bo.base.user;

import org.apache.ibatis.type.Alias;

import com.srpost.salmon.bean.BaseListBean;

/**
 * 고객 정보 Bean
 *
 * @author  finkle
 * @date    2014-11-14
 * @since   2.0
 */
@Alias("userBean")
@SuppressWarnings("serial")
public class UserBean extends BaseListBean {
    
    /** 사용자_KEY */
    private String userKey;
    /** 유형_코드 */
    private String typeCd;
    /** 유형_명 */
    private String typeNm;
    /** 사용자_아이디 */
    private String userId;
    /** 사용자_명 */
    private String userNm;
    /** 사용자_암호화_비밀번호 */
    private String userEncPwd;
    /** 사용자_암호화_전화_번호 */
    private String userEncTelNum;
    /** 사용자_암호화_휴대폰 */
    private String userEncMobile;
    /** 사용자_암호화_이메일 */
    private String userEncEmail;
    /** 우편번호 */
    private String postCd;
    /** 기본주소 */
    private String addr1;
    /** 상세주소 */
    private String addr2;
    /** 도로명_여부 */
    private String roadYn;
    /** 사용_여부 */
    private String useYn;
    /** 등록_일시 */
    private String regDt;
    /** 수정_일시 */
    private String modiDt;
    
    
    public String getUserKey() {
        return userKey;
    }
    public void setUserKey(String userKey) {
        this.userKey = userKey;
    }
    public String getTypeCd() {
        return typeCd;
    }
    public void setTypeCd(String typeCd) {
        this.typeCd = typeCd;
    }
    public String getTypeNm() {
        return typeNm;
    }
    public void setTypeNm(String typeNm) {
        this.typeNm = typeNm;
    }
    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public String getUserNm() {
        return userNm;
    }
    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }
    public String getUserEncPwd() {
        return userEncPwd;
    }
    public void setUserEncPwd(String userEncPwd) {
        this.userEncPwd = userEncPwd;
    }
    public String getUserEncTelNum() {
        return userEncTelNum;
    }
    public void setUserEncTelNum(String userEncTelNum) {
        this.userEncTelNum = userEncTelNum;
    }
    public String getUserEncMobile() {
        return userEncMobile;
    }
    public void setUserEncMobile(String userEncMobile) {
        this.userEncMobile = userEncMobile;
    }
    public String getUserEncEmail() {
        return userEncEmail;
    }
    public void setUserEncEmail(String userEncEmail) {
        this.userEncEmail = userEncEmail;
    }
    public String getPostCd() {
        return postCd;
    }
    public void setPostCd(String postCd) {
        this.postCd = postCd;
    }
    public String getAddr1() {
        return addr1;
    }
    public void setAddr1(String addr1) {
        this.addr1 = addr1;
    }
    public String getAddr2() {
        return addr2;
    }
    public void setAddr2(String addr2) {
        this.addr2 = addr2;
    }
    public String getRoadYn() {
        return roadYn;
    }
    public void setRoadYn(String roadYn) {
        this.roadYn = roadYn;
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
}
