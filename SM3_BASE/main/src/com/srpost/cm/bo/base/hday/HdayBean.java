package com.srpost.cm.bo.base.hday;

import java.util.Calendar;

import org.apache.ibatis.type.Alias;

import com.srpost.salmon.bean.BaseBean;

/**
 * 내부단 공휴일 정보 Bean
 *
 * @author  finkle
 * @date    2014-11-07
 * @since   2.0
 */
@Alias("hdayBean")
@SuppressWarnings("serial")
public class HdayBean extends BaseBean {
    
    /** 일련번호 */
    private Integer seq;
    /** 공휴일_명 */
    private String hdayNm;
    /** 시작_일자 */
    private String startDd;
    /** 종료_일자 */
    private String endDd;
    /** 음력_여부 */
    private String lunarYn;
    /** 주기 */
    private Integer cycle = HdayUtil.NO_CYCLE;
    /** 요일 */
    private Integer dow = Calendar.SATURDAY;
    /** 주 */
    private Integer week;
    /** 사용_여부 */
    private String useYn;
    /** 등록_일시 */
    private String regDt;
    /** 수정_일시 */
    private String modiDt;
    
    
    public Integer getSeq() {
        return seq;
    }
    public void setSeq(Integer seq) {
        this.seq = seq;
    }
    public String getHdayNm() {
        return hdayNm;
    }
    public void setHdayNm(String hdayNm) {
        this.hdayNm = hdayNm;
    }
    public String getStartDd() {
        return startDd;
    }
    public void setStartDd(String startDd) {
        this.startDd = startDd;
    }
    public String getEndDd() {
        return endDd;
    }
    public void setEndDd(String endDd) {
        this.endDd = endDd;
    }
    public String getLunarYn() {
        return lunarYn;
    }
    public void setLunarYn(String lunarYn) {
        this.lunarYn = lunarYn;
    }
    public Integer getCycle() {
        return cycle;
    }
    public void setCycle(Integer cycle) {
        this.cycle = cycle;
    }
    public Integer getDow() {
        return dow;
    }
    public void setDow(Integer dow) {
        this.dow = dow;
    }
    public Integer getWeek() {
        return week;
    }
    public void setWeek(Integer week) {
        this.week = week;
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
