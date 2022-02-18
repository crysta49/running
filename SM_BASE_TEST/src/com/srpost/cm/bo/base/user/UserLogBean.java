package com.srpost.cm.bo.base.user;

import org.apache.ibatis.type.Alias;

import com.srpost.salmon.bean.BaseBean;

/**
 * 고객 정보 조회 이력 Bean
 *
 * @author  finkle
 * @date    2014-11-24
 * @since   3.0
 */
@Alias("userLogBean")
@SuppressWarnings("serial")
public class UserLogBean extends BaseBean {
    
    /** 사용자_KEY */
    private String userKey;
    /** 정렬_순서 */
    private Integer orderNo;
    /** 담당자_아이디 */
    private String mgrId;
    /** 담당자_명 */
    private String mgrNm;
    /** 로그_내용 */
    private String logContents;
    /** 등록_일시 */
    private String regDt;
    
    
    public String getUserKey() {
        return userKey;
    }
    public void setUserKey(String userKey) {
        this.userKey = userKey;
    }
    public Integer getOrderNo() {
        return orderNo;
    }
    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
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
    public String getLogContents() {
        return logContents;
    }
    public void setLogContents(String logContents) {
        this.logContents = logContents;
    }
    public String getRegDt() {
        return regDt;
    }
    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }
}
