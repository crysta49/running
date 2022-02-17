package com.srpost.cm.bo.si.ipFilter;

import org.apache.ibatis.type.Alias;

import com.srpost.salmon.bean.BaseListBean;

/**
 * 내부단 IP Filter 정보 Bean
 *
 */
@Alias("ipFilterBean")
@SuppressWarnings("serial")
public class IpFilterBean extends BaseListBean {
    
    /** IP_일련번호 */
    private Integer ipSeq;
    /** IP_명 */
    private String ipNm;
    /** 시작_IP */
    private String startIp;
    /** 종료_IP */
    private String endIp;
    /** 등록_아이디 */
    private String regId;
    /** 등록_명 */
    private String regNm;
    /** 등록_일시 */
    private String regDt;
    /** 수정_일시 */
    private String modiDt;
    /** 사용_여부 */
    private String useYn;
    
    /** IP_일련번호 배열 */
    private Integer[] ipSeqs;
    
    public Integer getIpSeq() {
        return ipSeq;
    }
    public void setIpSeq(Integer ipSeq) {
        this.ipSeq = ipSeq;
    }
    public String getIpNm() {
        return ipNm;
    }
    public void setIpNm(String ipNm) {
        this.ipNm = ipNm;
    }
    public String getStartIp() {
        return startIp;
    }
    public void setStartIp(String startIp) {
        this.startIp = startIp;
    }
    public String getEndIp() {
        return endIp;
    }
    public void setEndIp(String endIp) {
        this.endIp = endIp;
    }
    public String getRegId() {
        return regId;
    }
    public void setRegId(String regId) {
        this.regId = regId;
    }
    public String getRegNm() {
        return regNm;
    }
    public void setRegNm(String regNm) {
        this.regNm = regNm;
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
    public Integer[] getIpSeqs() {
        Integer[] tempIpSeqs = null;
        
        if ( this.ipSeqs != null ) {
            tempIpSeqs = new Integer[ipSeqs.length];
            
            for (int i = 0; i < ipSeqs.length; i++) {
                tempIpSeqs[i] = this.ipSeqs[i];
            }
        }
        return tempIpSeqs;
    }
    public void setIpSeqs(Integer[] ipSeqs) {
        this.ipSeqs = new Integer[ipSeqs.length];
        
        for (int i = 0; i < ipSeqs.length; ++i) {
            this.ipSeqs[i] = ipSeqs[i];
        }
    }
    public String getUseYn() {
        return useYn;
    }
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }
    
}
