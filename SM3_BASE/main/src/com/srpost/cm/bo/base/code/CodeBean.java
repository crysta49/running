package com.srpost.cm.bo.base.code;

import org.apache.ibatis.type.Alias;

import com.srpost.salmon.bean.BaseBean;
import com.srpost.salmon.constant.StringPool;

/**
 * 내부단 코드 정보 Bean
 *
 * @author  finkle
 * @date    2014-10-27
 * @since   2.0
 */
@Alias("codeBean")
@SuppressWarnings("serial")
public class CodeBean extends BaseBean {
    
    /** 그룹_코드 */
    private String grpCd;
    /** 그룹_명 */
    private String grpNm;
    /** 개별_코드 */
    private String prvCd;
    /** 개별_명 */
    private String prvNm;
    /** 정렬_순서 */
    private Integer orderNo;
    /** 하위_그룹_코드 */
    private String subGrpCd;
    /** 사용_여부 */
    private String useYn;
    /** 등록_일시 */
    private String regDt;
    /** 수정_일시 */
    private String modiDt;
    
    /** 사용여부 */
    private Boolean isUse = true;
    
    
    public String getGrpCd() {
        return grpCd;
    }
    public void setGrpCd(String grpCd) {
        this.grpCd = grpCd;
    }
    public String getGrpNm() {
        return grpNm;
    }
    public void setGrpNm(String grpNm) {
        this.grpNm = grpNm;
    }
    public String getPrvCd() {
        return prvCd;
    }
    public void setPrvCd(String prvCd) {
        this.prvCd = prvCd;
    }
    public String getPrvNm() {
        return prvNm;
    }
    public void setPrvNm(String prvNm) {
        this.prvNm = prvNm;
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
        setIsUse(useYn.equals(StringPool.Y) ? true : false);
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
    public Boolean getIsUse() {
        return isUse;
    }
    public void setIsUse(Boolean isUse) {
        this.isUse = isUse;
    }
    public String getSubGrpCd() {
        return subGrpCd;
    }
    public void setSubGrpCd(String subGrpCd) {
        this.subGrpCd = subGrpCd;
    }
}
