package com.srpost.cm.bo.base.errlog;

import org.apache.ibatis.type.Alias;

import com.srpost.salmon.bean.BaseListBean;

/**
 * 내부단 에러로그 정보 Bean
 *
 * @author  finkle
 * @date    2014-10-27
 * @since   2.0
 */
@Alias("errLogBean")
@SuppressWarnings("serial")
public class ErrLogBean extends BaseListBean {
    
    /** 일련번호 */
    private Integer seq;
    /** 제목 */
    private String title;
    /** 내용 */
    private String contents;
    /** URL */
    private String url;
    /** 해결_여부 */
    private String solvYn;
    /** 해결_일시 */
    private String solvDt;
    /** 등록_일시 */
    private String regDt;
    
    /** 일련번호 배열 */
    private Integer[] seqs;
    
    public ErrLogBean() {
    }
    public ErrLogBean(String title, String url, String contents) {
        this.title = title;
        this.url = url;
        this.contents = contents;
    }
    
    
    public Integer getSeq() {
        return seq;
    }
    public void setSeq(Integer seq) {
        this.seq = seq;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getContents() {
        return contents;
    }
    public void setContents(String contents) {
        this.contents = contents;
    }
    public String getUrl() {
        return url;
    }
    public void setUrl(String url) {
        this.url = url;
    }
    public String getSolvYn() {
        return solvYn;
    }
    public void setSolvYn(String solvYn) {
        this.solvYn = solvYn;
    }
    public String getSolvDt() {
        return solvDt;
    }
    public void setSolvDt(String solvDt) {
        this.solvDt = solvDt;
    }
    public String getRegDt() {
        return regDt;
    }
    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }
    public Integer[] getSeqs() {
        return seqs;
    }
    public void setSeqs(Integer[] seqs) {
        this.seqs = seqs;
    }
}
