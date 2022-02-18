package com.srpost.cm.bo.base.bbs.conf;

import org.apache.ibatis.type.Alias;

import com.srpost.salmon.bean.BaseBean;

/**
 * 내부단 게시판설정 분류정보 Bean
 *
 * @author  finkle
 * @date    2014-11-10
 * @since   2.0
 */
@Alias("bbsCtgBean")
@SuppressWarnings("serial")
public class BbsCtgBean extends BaseBean {
    
    /** 게시판_코드 */
    private Integer bbsCd;
    /** 게시판_명 */
    private String bbsNm;
    /** 카테고리_코드 */
    private Integer ctgCd;
    /** 카테고리_명 */
    private String ctgNm;
    /** 정렬_순서 */
    private Integer orderNo;
    
    
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
    public Integer getCtgCd() {
        return ctgCd;
    }
    public void setCtgCd(Integer ctgCd) {
        this.ctgCd = ctgCd;
    }
    public String getCtgNm() {
        return ctgNm;
    }
    public void setCtgNm(String ctgNm) {
        this.ctgNm = ctgNm;
    }
    public Integer getOrderNo() {
        return orderNo;
    }
    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
    }
}
