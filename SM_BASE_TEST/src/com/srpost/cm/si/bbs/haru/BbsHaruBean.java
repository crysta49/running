package com.srpost.cm.si.bbs.haru;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.type.Alias;

import com.srpost.cm.bo.base.user.UserBean;
import com.srpost.salmon.bean.BaseFileBean;
import com.srpost.salmon.bean.BaseListBean;
import com.srpost.salmon.bean.BasePrevNextBean;

/**
 * 내부단 게시판 정보 Bean
 *
 * @author  finkle
 * @date    2014-11-17
 * @since   2.0
 */
@Alias("bbsHaruBean")
@SuppressWarnings("serial")
public class BbsHaruBean extends BaseListBean {

    /** 파일 리스트 */
    private List<BaseFileBean> fileList;
    /** 이전 다음글 */
    private BasePrevNextBean prevNextBean;
    /** 확장map */
    private Map<String, Object> extMap = new HashMap<String, Object>();
    
    /** 파일 카운트 */
    private Integer fileCnt;
    
    /** 고객정보 */
    private UserBean userBean;
    
    /** 게시판_코드 */
    private Integer bbsCd;
    /** 게시판_명 */
    private String bbsNm;
    /** 게시판_일련번호 */
    private Integer bbsSeq;
    /** 참조_일련번호 (음수형태로 -1씩 감소) (기본:-1) */
    private Integer refSeq;
    /** 정렬_순서 */
    private Integer orderNo;
    /** 댓글_레벨 */
    private Integer depth;
    /** 카테고리_코드 */
    private Integer ctgCd;
    /** 카테고리_명 */
    private String ctgNm;
    /** 제목 */
    private String title;
    /** 사용자_KEY */
    private String userKey;
    /** 작성자_명 */
    private String writerNm;
    /** 작성자_암호화_비밀번호 */
    private String writerEncPwd;
    /** 담당자_아이디 */
    private String mgrId;
    /** 담당자_명 */
    private String mgrNm;
    /** 답변자_명 */
    private String replyNm;
    /** 질문 */
    private String question;
    /** 답변 */
    private String reply;
    /** 통지_코드S */
    private String alertCds;
    /** 통지_코드명S */
    private String alertNms;
    /** 상태_코드 */
    private String statusCd;
    /** 상태_명 */
    private String statusNm;
    /** 파일_일련번호 */
    private Integer fileSeq;
    /** HTML_여부 */
    private String htmlYn;
    /** 공개_여부 */
    private String openYn;
    /** 삭제_여부 */
    private String delYn;
    /** 조회_건수 */
    private Integer readCnt;
    /** 등록_일시 */
    private String regDt;
    /** 수정_일시 */
    private String modiDt;
    
    /** 게시판_일련_번호 배열 */
    private Integer[] bbsSeqs;
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
    
    public UserBean getUserBean() {
        return userBean;
    }
    public void setUserBean(UserBean userBean) {
        this.userBean = userBean;
    }
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
    public Integer getBbsSeq() {
        return bbsSeq;
    }
    public void setBbsSeq(Integer bbsSeq) {
        this.bbsSeq = bbsSeq;
    }
    public Integer getRefSeq() {
        return refSeq;
    }
    public void setRefSeq(Integer refSeq) {
        this.refSeq = refSeq;
    }
    public Integer getOrderNo() {
        return orderNo;
    }
    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
    }
    public Integer getDepth() {
        return depth;
    }
    public void setDepth(Integer depth) {
        this.depth = depth;
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
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
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
    public String getWriterEncPwd() {
        return writerEncPwd;
    }
    public void setWriterEncPwd(String writerEncPwd) {
        this.writerEncPwd = writerEncPwd;
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
    public String getReplyNm() {
        return replyNm;
    }
    public void setReplyNm(String replyNm) {
        this.replyNm = replyNm;
    }
    public String getQuestion() {
        return question;
    }
    public void setQuestion(String question) {
        this.question = question;
    }
    public String getReply() {
        return reply;
    }
    public void setReply(String reply) {
        this.reply = reply;
    }
    public String getAlertCds() {
        return alertCds;
    }
    public void setAlertCds(String alertCds) {
        this.alertCds = alertCds;
    }
    public String getStatusCd() {
        return statusCd;
    }
    public void setStatusCd(String statusCd) {
        this.statusCd = statusCd;
    }
    public String getStatusNm() {
        return statusNm;
    }
    public void setStatusNm(String statusNm) {
        this.statusNm = statusNm;
    }
    public Integer getFileSeq() {
        return fileSeq;
    }
    public void setFileSeq(Integer fileSeq) {
        this.fileSeq = fileSeq;
    }
    public String getOpenYn() {
        return openYn;
    }
    public void setOpenYn(String openYn) {
        this.openYn = openYn;
    }
    public String getDelYn() {
        return delYn;
    }
    public void setDelYn(String delYn) {
        this.delYn = delYn;
    }
    public Integer getReadCnt() {
        return readCnt;
    }
    public void setReadCnt(Integer readCnt) {
        this.readCnt = readCnt;
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
    public Integer[] getBbsSeqs() {
        return bbsSeqs;
    }
    public void setBbsSeqs(Integer[] bbsSeqs) {
        this.bbsSeqs = bbsSeqs;
    }
    public String[] getFileIds() {
        return fileIds;
    }
    public void setFileIds(String[] fileIds) {
        this.fileIds = fileIds;
    }
    public String getHtmlYn() {
        return htmlYn;
    }
    public void setHtmlYn(String htmlYn) {
        this.htmlYn = htmlYn;
    }
    public String getAlertNms() {
        return alertNms;
    }
    public void setAlertNms(String alertNms) {
        this.alertNms = alertNms;
    }
    public BasePrevNextBean getPrevNextBean() {
        return prevNextBean;
    }
    public void setPrevNextBean(BasePrevNextBean prevNextBean) {
        this.prevNextBean = prevNextBean;
    }
    public Map<String, Object> getExtMap() {
        return extMap;
    }
    public void setExtMap(Map<String, Object> extMap) {
        this.extMap = extMap;
    }
}
