package com.srpost.salmon.web.tag.ui;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import com.srpost.salmon.bean.BaseFileBean;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.lang.UTF8Util;
import com.srpost.salmon.web.tag.SalmonTagSupport;

import static com.srpost.salmon.constant.StringPool.*;

/**
 * Salmon 첨부파일 목록 표시용 taglib
 *
 * @author  finkle
 * @date    2014-11-18
 * @since   2.0
 */
public class FileListTag extends SalmonTagSupport {

    /** 첨부파일 목록 */
    private List<BaseFileBean> list;
    /** 체크박스 표시 여부 (수정폼에서 첨부파일 삭제용) */
    private boolean checkbox = false;
    /** 내려받은 수 표시 여부 */
    private boolean downCnt = true;
    /** 파일 크기 표시 여부 */
    private boolean fileSize = true;
    /** 파일 유형 표시 여부 */
    private boolean fileType = true;
    /** 다운로드 로그 링크 표시 여부 */
    private boolean fileLog = true;
    /** 파일 없음 라벨 표시 여부 */
    private boolean noData = false;
    /** 전체 파일 ZIP 다운로드 여부 */
    private boolean useZip = true;
    /** 전체 파일 ZIP 다운로드 텍스트 */
    private String zipText = "압축(ZIP) 파일로 모두 내려받기";
    
    
    public void doTag() throws JspException, IOException {

        JspWriter writer = getJspContext().getOut();
        
        StringBuilder html = new StringBuilder();
        
        if ( StringUtil.isEmpty(list) ) {
            if ( noData ) {
                html.append("<div class='file-list'><span class='no-data'>없음</span></div>");
            }
        }
        else {
            String downloadUrl = getContextPath() + "/common/file/NR_download.do";
            String zipDownloadUrl = getContextPath() + "/common/file/NR_downloadAll.do";
            Integer fileSeq = 0;
            
            html.append("<div class='file-list'>\n");
            
            for (BaseFileBean item : list) {
                String sOrgName = StringUtil.xss(item.getOrgFileNm());
                String sFileName = StringUtil.xss(UTF8Util.fixLength(item.getOrgFileNm(), 35));
                String sFileType = StringUtil.xss(UTF8Util.fixLength(item.getFileType(), 25));

                html.append("<div class='file-item'>");
                if ( checkbox ) {
                    html.append("<input type='checkbox' name='fileIds' value='" + item.getFileId() + "' class='smf-checkbox'/>\n");
                }
                
                html.append("<span class='t3-download file-name'><a title='" + sOrgName + "' href='" + downloadUrl + "?id=" + item.getFileId() + "'>" + sFileName + "</a></span>\n");
                
                if ( fileSize || fileType || downCnt ) html.append(" (");
                    
                if ( fileSize )
                    html.append("<span class='file-size'>" + item.getFileSize() + "</span>\n");
                if ( fileType )
                    html.append("<span class='file-type'>" + sFileType + "</span>\n");
                
                if ( downCnt ) {
                    if ( fileLog ) {
                        html.append("<a href='#' onclick=\"SM.fileLogPop('" + 
                                item.getFileSeq() + "', '" + item.getFileId() + "'); return false;\">");
                        html.append("<span class='down-cnt'><strong>" + item.getDownCnt() + "</strong> 회 내려받음</span></a>\n");
                    }
                    else
                        html.append("<span class='down-cnt'><strong>" + item.getDownCnt() + "</strong> 회 내려받음</span>\n");
                }
                
                if ( fileSize || fileType || downCnt ) html.append(")");

                html.append("</div>\n");
                
                fileSeq = item.getFileSeq();
            }
            
            if (list.size() > ONE && StringUtil.isNotEmpty(fileSeq) && fileSeq != MINUS_ONE) {
                if (!checkbox && useZip) {
                    html.append("<div class='zip-item'>\n");
                    html.append("<span class='t3-zipfile file-name'><a href='" + zipDownloadUrl + "?fileSeq=" + fileSeq + "'>" + zipText + "</a></span>\n");
                    html.append("</div>\n");
                }
            }
            
            html.append("</div>\n");
        }
        
        writer.write(html.toString());
    }

    
    private String getContextPath() {
        return getRequest().getContextPath();
    }
    
    public void setList(List<BaseFileBean> list) {
        this.list = list;
    }
    public void setCheckbox(boolean checkbox) {
        this.checkbox = checkbox;
    }
    public void setDownCnt(boolean downCnt) {
        this.downCnt = downCnt;
    }
    public void setFileSize(boolean fileSize) {
        this.fileSize = fileSize;
    }
    public void setFileType(boolean fileType) {
        this.fileType = fileType;
    }
    public void setFileLog(boolean fileLog) {
        this.fileLog = fileLog;
    }
    public void setNoData(boolean noData) {
        this.noData = noData;
    }
    public void setUseZip(boolean useZip) {
        this.useZip = useZip;
    }
    public void setZipText(String zipText) {
        this.zipText = zipText;
    }
}
