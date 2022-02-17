package com.srpost.cm.bo.base.faq.core;

import java.util.List;

import org.apache.ibatis.type.Alias;

import com.srpost.salmon.bean.BaseFileBean;
import com.srpost.salmon.bean.BaseListBean;

/**
 * 내부단 FAQ관리 정보 Bean
 *
 * @author  finkle
 * @date    2014-11-20
 * @since   2.0
 */
@Alias("faqBean")
@SuppressWarnings("serial")
public class FaqBean extends BaseListBean {
    
    List<BaseFileBean> fileList;
    
    private Integer fileCnt;
    
    /** 일련번호 */
    private Integer seq;
    /** 카테고리_코드 */
    private Integer ctgCd;
    /** 카테고리_명 */
    private String ctgNm;
    /** 담당자_아이디 */
    private String mgrId;
    /** 담당자_명 */
    private String mgrNm;
    /** 제목 */
    private String title;
    /** 내용 */
    private String contents;
    /** 파일_일련번호 */
    private Integer fileSeq;
    /** 추천_건수 */
    private Integer recomCnt;
    /** 반대_건수 */
    private Integer oppCnt;
    /** 조회_건수 */
    private Integer readCnt;
    /** BEST, WORST 점수 */
    private Integer scoreAvg;
    /** 승인_여부 */
    private String aprvYn;
    /** 등록_일시 */
    private String regDt;
    /** 수정_일시 */
    private String modiDt;
    
    /** 일련번호 배열 */
    private Integer[] seqs;
    /** 첨부파일 배열 */
    private String[] fileIds;
    
    
    public List<BaseFileBean> getFileList() {
        return fileList;
    }
    public void setFileList(List<BaseFileBean> fileList) {
        this.fileList = fileList;
    }
    public Integer getFileCnt() {
        return fileCnt;
    }
    public void setFileCnt(Integer fileCnt) {
        this.fileCnt = fileCnt;
    }
    public Integer getSeq() {
        return seq;
    }
    public void setSeq(Integer seq) {
        this.seq = seq;
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
    public Integer getFileSeq() {
        return fileSeq;
    }
    public void setFileSeq(Integer fileSeq) {
        this.fileSeq = fileSeq;
    }
    public Integer getRecomCnt() {
        return recomCnt;
    }
    public void setRecomCnt(Integer recomCnt) {
        this.recomCnt = recomCnt;
    }
    public Integer getOppCnt() {
        return oppCnt;
    }
    public void setOppCnt(Integer oppCnt) {
        this.oppCnt = oppCnt;
    }
    public Integer getReadCnt() {
        return readCnt;
    }
    public void setReadCnt(Integer readCnt) {
        this.readCnt = readCnt;
    }
    public String getAprvYn() {
        return aprvYn;
    }
    public void setAprvYn(String aprvYn) {
        this.aprvYn = aprvYn;
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
    public Integer[] getSeqs() {
        return seqs;
    }
    public void setSeqs(Integer[] seqs) {
        this.seqs = seqs;
    }
    public String[] getFileIds() {
        return fileIds;
    }
    public void setFileIds(String[] fileIds) {
        this.fileIds = fileIds;
    }
    public Integer getScoreAvg() {
        return scoreAvg;
    }
    public void setScoreAvg(Integer scoreAvg) {
        this.scoreAvg = scoreAvg;
    }
}
