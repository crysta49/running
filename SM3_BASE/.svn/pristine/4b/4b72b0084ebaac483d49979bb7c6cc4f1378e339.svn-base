package com.srpost.cm.bo.base.bbs.comment;

import java.util.List;

import org.apache.ibatis.type.Alias;

import com.srpost.salmon.bean.BaseBean;
import com.srpost.salmon.bean.BaseFileBean;


/**
 * 내부단 게시판 의견글 정보 Bean
 *
 * @author  finkle
 * @date    2015-01-23
 * @since   2.0
 */
@Alias("bbsCmtBean")
@SuppressWarnings("serial")
public class BbsCmtBean extends BaseBean {

    /** 게시판_코드 */
    private Integer bbsCd;
    /** 게시판_일련번호 */
    private Integer bbsSeq;
    /** 의견_일련번호 */
    private Integer cmtSeq;
    /** 참조_일련번호 */
    private Integer refSeq;
    /** 정렬_순서 */
    private Integer orderNo;
    /** 고객_KEY */
    private String userKey;
    /** 담당자_ID */
    private String mgrId;
    /** 의견글 깊이 */
    private Integer depth;
    /** 내용 */
    private String cmtContents;
    /** 파일 순번 */
    private Integer fileSeq;
    /** 작성자_이름 */
    private String writerNm;
    /** 작성자_암호화_비밀번호 */
    private String writerEncPwd;
    /** 등록_일시 */
    private String regDt;
    /** 수정_일시 */
    private String modiDt;
    
    /** 첨부파일 목록 */
    private List<BaseFileBean> fileList;
    /** 첨부파일 배열 */
    private String[] fileIds;
    /** 첨부파일 수 */
    private Integer fileCnt = 0;
    

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
    public Integer getDepth() {
        return depth;
    }
    public void setDepth(Integer depth) {
        this.depth = depth;
    }
    public String getCmtContents() {
        return cmtContents;
    }
    public void setCmtContents(String cmtContents) {
        this.cmtContents = cmtContents;
    }
    public List<BaseFileBean> getFileList() {
        return fileList;
    }
    public void setFileList(List<BaseFileBean> fileList) {
        this.fileList = fileList;
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
    public Integer getFileSeq() {
        return fileSeq;
    }
    public void setFileSeq(Integer fileSeq) {
        this.fileSeq = fileSeq;
    }
    public Integer getCmtSeq() {
        return cmtSeq;
    }
    public void setCmtSeq(Integer cmtSeq) {
        this.cmtSeq = cmtSeq;
    }
    public Integer getRefSeq() {
        return refSeq;
    }
    public void setRefSeq(Integer refSeq) {
        this.refSeq = refSeq;
    }
    public String getUserKey() {
        return userKey;
    }
    public void setUserKey(String userKey) {
        this.userKey = userKey;
    }
    public String getWriterNm() {
        return writerNm;
    }
    public void setWriterNm(String writerNm) {
        this.writerNm = writerNm;
    }
    public Integer getBbsCd() {
        return bbsCd;
    }
    public void setBbsCd(Integer bbsCd) {
        this.bbsCd = bbsCd;
    }
    public Integer getBbsSeq() {
        return bbsSeq;
    }
    public void setBbsSeq(Integer bbsSeq) {
        this.bbsSeq = bbsSeq;
    }
    public String getWriterEncPwd() {
        return writerEncPwd;
    }
    public void setWriterEncPwd(String writerEncPwd) {
        this.writerEncPwd = writerEncPwd;
    }
}
