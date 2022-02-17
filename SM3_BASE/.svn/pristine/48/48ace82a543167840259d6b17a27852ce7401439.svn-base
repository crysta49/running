package com.srpost.cm.bo.base.bbs.ntc;

import java.util.List;

import org.apache.ibatis.type.Alias;

import com.srpost.cm.bo.base.bbs.comment.BbsCmtBean;
import com.srpost.salmon.bean.BaseFileBean;
import com.srpost.salmon.bean.BaseListBean;

/**
 * 내부단 게시판 공지글 정보 Bean
 *
 * @author  finkle
 * @date    2014-11-17
 * @since   2.0
 */
@Alias("bbsNtcBean")
@SuppressWarnings("serial")
public class BbsNtcBean extends BaseListBean {

    List<BaseFileBean> fileList;
    List<BbsCmtBean> commentList;
    
    private Integer fileCnt;
    private Integer commentCnt;
    
    /** 게시판_코드 */
    private Integer bbsCd;
    /** 게시판_이름 */
    private String bbsNm;
    /** 일련_번호 */
    private Integer ntcSeq;
    /** 제목 */
    private String title;
    /** 내용 */
    private String contents;
    /** 첨부파일 */
    private Integer fileSeq;
    /** 담당자 ID */
    private String mgrId;
    /** 담당자 이름 */
    private String mgrNm;
    /** 조회수 */
    private Integer readCnt;
    /** 시작_일자 */
    private String startDd;
    /** 종료_일자 */
    private String endDd;
    /** 등록일 */
    private String regDt;
    /** 수정일 */
    private String modiDt;
    
    /** 조회수 증가 여부 */
    private boolean isIncreaseReadCnt = false;
    /** 게시 여부 */
    private String workYn = "N";
    
    /** 일련번호 배열 : (bbsCd|ntcSeq) */
    private String[] ntcSeqs;
    /** 첨부파일 배열 */
    private String[] fileIds;
    
    /** 제목 자르기 */
    private String shortTitle;
    /** 제목 자르기 기준값 */
    private Integer cutNo = -1;
    
    
	public List<BaseFileBean> getFileList() {
    	return fileList;
    }
	public void setFileList(List<BaseFileBean> fileList) {
    	this.fileList = fileList;
    }
	public Integer getBbsCd() {
    	return bbsCd;
    }
	public void setBbsCd(Integer bbsCd) {
    	this.bbsCd = bbsCd;
    }
	public Integer getNtcSeq() {
    	return ntcSeq;
    }
	public void setNtcSeq(Integer ntcSeq) {
    	this.ntcSeq = ntcSeq;
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
	public Integer getReadCnt() {
    	return readCnt;
    }
	public void setReadCnt(Integer readCnt) {
    	this.readCnt = readCnt;
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
	public boolean isIncreaseReadCnt() {
    	return isIncreaseReadCnt;
    }
	public void setIncreaseReadCnt(boolean isIncreaseReadCnt) {
    	this.isIncreaseReadCnt = isIncreaseReadCnt;
    }
	public String[] getNtcSeqs() {
    	return ntcSeqs;
    }
	public void setNtcSeqs(String[] ntcSeqs) {
    	this.ntcSeqs = ntcSeqs;
    }
	public String[] getFileIds() {
    	return fileIds;
    }
	public void setFileIds(String[] fileIds) {
    	this.fileIds = fileIds;
    }
	public Integer getFileCnt() {
    	return fileCnt;
    }
	public void setFileCnt(Integer fileCnt) {
    	this.fileCnt = fileCnt;
    }
	public String getWorkYn() {
    	return workYn;
    }
	public void setWorkYn(String workYn) {
    	this.workYn = workYn;
    }
	public String getBbsNm() {
    	return bbsNm;
    }
	public void setBbsNm(String bbsNm) {
    	this.bbsNm = bbsNm;
    }
	public String getShortTitle() {
    	return shortTitle;
    }
	public void setShortTitle(String shortTitle) {
    	this.shortTitle = shortTitle;
    }
	public Integer getCutNo() {
    	return cutNo;
    }
	public void setCutNo(Integer cutNo) {
    	this.cutNo = cutNo;
    }
    public List<BbsCmtBean> getCommentList() {
        return commentList;
    }
    public void setCommentList(List<BbsCmtBean> commentList) {
        this.commentList = commentList;
    }
    public Integer getCommentCnt() {
        return commentCnt;
    }
    public void setCommentCnt(Integer commentCnt) {
        this.commentCnt = commentCnt;
    }
}
