package com.srpost.cm.bo.base.dept;

import org.apache.ibatis.type.Alias;

import com.srpost.salmon.bean.BaseTreeBean;
import com.srpost.salmon.constant.Constant;

/**
 * 내부단 부서 정보 Bean
 *
 * @author  finkle
 * @date    2014-10-27
 * @since   2.0
 */
@Alias("deptBean")
@SuppressWarnings("serial")
public class DeptBean extends BaseTreeBean {
    
    /** 디폴트 최상위 부서코드 */
    private String topDeptCd = Constant.TOP_DEPT_CD;
    
    /** 부서_코드 */
    private String deptCd;
    /** 부서_명 */
    private String deptNm;
    /** 상위_부서_코드 */
    private String highDeptCd;
    /** 상위_부서_명 */
    private String highDeptNm;
    /** 부점_코드 */
    private String branchCd;
    /** 부점_명 */
    private String branchNm;
    /** 정렬_순서 */
    private Integer orderNo;
    /** 사용_여부 */
    private String useYn;
    /** 등록_일시 */
    private String regDt;
    /** 수정_일시 */
    private String modiDt;
    
    
    public String getTopDeptCd() {
        return topDeptCd;
    }
    public void setTopDeptCd(String topDeptCd) {
        this.topDeptCd = topDeptCd;
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
    public String getHighDeptCd() {
        return highDeptCd;
    }
    public void setHighDeptCd(String highDeptCd) {
        this.highDeptCd = highDeptCd;
    }
    public String getHighDeptNm() {
        return highDeptNm;
    }
    public void setHighDeptNm(String highDeptNm) {
        this.highDeptNm = highDeptNm;
    }
    public Integer getOrderNo() {
        return orderNo;
    }
    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
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
    public String getBranchCd() {
        return branchCd;
    }
    public void setBranchCd(String branchCd) {
        this.branchCd = branchCd;
    }
    public String getBranchNm() {
        return branchNm;
    }
    public void setBranchNm(String branchNm) {
        this.branchNm = branchNm;
    }
}
