package com.srpost.cm.bo.base.file;

import org.apache.ibatis.type.Alias;

import com.srpost.salmon.bean.BaseListBean;

/**
 * 공용 파일 다운로드 로그 정보 Bean
 *
 * @author  finkle
 * @date    2014-11-14
 * @since   2.0
 */
@Alias("fileLogBean")
@SuppressWarnings("serial")
public class FileLogBean extends BaseListBean {
    
    /** 파일_일련번호 */
    private Integer fileSeq;
    /** 파일_아이디 */
    private String fileId;
    /** 작업자_아이디 */
    private String workerId;
    /** 작업자_명 */
    private String workerNm;
    /** 다운로드_건수 */
    private Integer downCnt;
    /** 등록_일시 */
    private String regDt;
    
    
    public Integer getFileSeq() {
        return fileSeq;
    }
    public void setFileSeq(Integer fileSeq) {
        this.fileSeq = fileSeq;
    }
    public String getFileId() {
        return fileId;
    }
    public void setFileId(String fileId) {
        this.fileId = fileId;
    }
    public String getWorkerId() {
        return workerId;
    }
    public void setWorkerId(String workerId) {
        this.workerId = workerId;
    }
    public String getWorkerNm() {
        return workerNm;
    }
    public void setWorkerNm(String workerNm) {
        this.workerNm = workerNm;
    }
    public Integer getDownCnt() {
        return downCnt;
    }
    public void setDownCnt(Integer downCnt) {
        this.downCnt = downCnt;
    }
    public String getRegDt() {
        return regDt;
    }
    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }
}
