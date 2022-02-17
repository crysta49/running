<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>
<sm:static var="BBS_CONF_UTIL" clazz="com.srpost.cm.bo.base.bbs.conf.BbsConfUtil"/>

<c:set var="exist" value="${not empty dataBean.bbsSeq}" />

<html>
<head>
    <title>${confBean.bbsNm}</title>
</head>
 
<body>

<form:form commandName="bbsBean" id="listForm" name="listForm" action="NR_index.do" method="get">
    <form:hidden path="bbsCd" id="_bbsCd"/>
    <form:hidden path="bbsSeq" id="_bbsSeq"/>
    <form:hidden path="currentPage" id="_currentPage"/>
    <form:hidden path="rowPerPage" id="_rowPerPage"/>
    <form:hidden path="searchKey" id="_searchKey"/>
    <form:hidden path="searchVal" id="_searchVal"/>
    <form:hidden path="ctgCd" id="_ctgCd"/>
</form:form>

<form:form commandName="dataBean" id="dataForm" name="dataForm" autocomplete="off"
    method="post" enctype="multipart/form-data">
    <form:hidden path="bbsCd"/>
    <form:hidden path="bbsSeq"/>
    <form:hidden path="fileSeq"/>
    <c:choose>
        <c:when test="${confBean.htmlYn == 'Y' and dataBean.htmlYn == 'Y'}">
            <input type="hidden" name="${CONSTANT.GLOBAL_EXCL_XSS_KEY}" value="question, reply"/>
        </c:when>
        <c:when test="${confBean.htmlYn == 'Y' and dataBean.htmlYn == 'N'}">
            <input type="hidden" name="${CONSTANT.GLOBAL_EXCL_XSS_KEY}" value="reply"/>
        </c:when>
        <c:when test="${confBean.htmlYn == 'N' and dataBean.htmlYn == 'Y'}">
            <input type="hidden" name="${CONSTANT.GLOBAL_EXCL_XSS_KEY}" value="question"/>
        </c:when>
    </c:choose>
    
    <table class="tbl-header">
        <tr>
            <th><span class="title-big">${curMenuBean.menuNm} ${exist ? "수정" : "등록"}</span></th>
            <td class="tr"><span class="required">표시는 필수입력 항목입니다.</span></td>
        </tr>
    </table>

    <table class="tbl-view tbl-form">
        <colgroup>
            <col class="th">
            <col>
            <col class="th">
            <col>
        </colgroup>
        <tr>
            <th>제목<em>&nbsp;</em></th>
            <td colspan="3">
                <c:if test="${confBean.ctgYn == 'Y'}">
                    <select name="ctgCd" id="ctgCd" class="smf-select">
                        <option value="">-- 선택하세요 --</option>
                    <c:forEach items="${confBean.ctgList}" var="item">
                        <option value="${item.ctgCd}" ${item.ctgCd == dataBean.ctgCd ? 'selected=\'selected\'' : ''}>${item.ctgNm}</option>
                    </c:forEach>
                    </select>
                </c:if>
                <form:input path="title" cssClass="smf-text" size="80"/>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <form:textarea path="question" rows="8" cssClass="smf-ta smeditor"/>
            </td>
        </tr>
        <c:if test="${confBean.fileYn == 'Y'}">
            <tr>
                <th>첨부파일
                    <span class="t3-help smtip">&nbsp;</span>
                    <div class="sr-hidden">
                        <div class="smtip-title">첨부파일</div>
                        <div class="smtip-text">
                            <div>최대 <strong>${confBean.fileCnt}</strong>개까지 업로드 가능합니다.<br/>첨부 가능한 파일 확장자는 <strong>${CONSTANT.PERMIT_EXTENSIONS_STRING}</strong> 입니다.<br/>
                            첨부하는 파일의 총 용량은 <strong>${CONSTANT.MAX_UPLOAD_SIZE} KB</strong>를 초과할 수 없습니다.</div>
                        </div>
                    </div><br/>
                </th>
                <td colspan="3">
                    <sm:file-list list="${dataBean.fileList}" checkbox="true" downCnt="false"/>
                    <div class="input-group input-file">
                        <input type="text" id="dummy-file" class="smf-text form-control" readonly="readonly" />
                        <label class="input-group-btn">
                            <span class="btn btn-sm btn-plain">찾아보기&hellip; 
                                <input type="file" name="files" multiple="multiple" class="multifile" />
                            </span>
                        </label>
                    </div>
                    <div class="selected-file"></div>
                    <input type="hidden" name="${CONSTANT.UPLOAD_FOLDER_PARAM_KEY}" value="bbs" />
                </td>
            </tr>
        </c:if>
        <c:if test="${confBean.typeCd == BBS_CONF_UTIL.QNA}">
            <tr>
                <th>상태</th>
                <td colspan="3">
                    <sm:code id="statusCd" grpCd="BBS_STATUS" defaultLabel="-- 선택해주세요 --" defaultValues="${dataBean.statusCd}" excludeValues=""/>
                </td>
            </tr>
        </c:if>
        <c:if test="${exist}">
            <tr>
                <th>등록일</th>
                <td class="plain">
                    ${dataBean.regDt}
                </td>
                <th>최종 수정일</th>
                <td class="plain">
                    ${dataBean.modiDt}
                </td>
            </tr>
        </c:if>
        
        <%-- 
        * 사용자 테이블 사용 시 샘플 코드
        <tr>
            <th>VIEW_OPTION</th>
            <td>
                <input type="text" name="VIEW_OPTION" class="smf-text" value="${dataBean.extMap.VIEW_OPTION}"/>
            </td>
            <th>SRC</th>
            <td>
                <input type="text" name="SRC" class="smf-text" value="${dataBean.extMap.SRC}"/>
            </td>
        </tr>
        --%>
    </table>

    <sm:button-layout>
        <sm:button value="취소" glyph="" cssClass="btn-link" onclick="history.back();" />
        <sm:button type="submit" glyph="saved" value="저장" />
    </sm:button-layout>
    
</form:form>

<sm:js names="validation, multifile, ckeditor" />
<script type="text/javascript" src="<c:url value="/resources/fm/js/bbs.js"/>"></script>
<script type="text/javascript">

    Ext.onReady(function() {

        $("input[name=title]").focus();
        
        $("#dataForm").validate({
            rules: {
                ctgCd : { required: ${confBean.ctgYn == 'Y' ? 'true' : 'false'} },
                title : { required: true, maxlength: 100 },
                question : { required: true }
            }, 
            submitHandler: function(form) {
                
                <c:if test="${dataBean.htmlYn == 'Y'}">
                    if ($("#question").val() == "") {
                        alert("내용을 입력하세요."); return;
                    }
                </c:if>
                
                SM.submit(form, {
                    url: "${exist ? 'TR_updateAction.do' : 'TR_insertAction.do'}"
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        <c:if test="${exist}">
                            BBS.view('${dataBean.bbsSeq}');
                        </c:if>
                        <c:if test="${!exist}">
                            BBS.resetSearch();
                        </c:if>
                    }
                });
            }
        });
        
        $(".smtip").each(function() {
            $(this).qtip({
                content: {
                    title: $(this).next().find(".smtip-title"),
                    text: $(this).next().find(".smtip-text")
                },
                position: {
                    my: "bottom left",
                    at: "top center"
                }
            });
        });
        
        <c:if test="${dataBean.htmlYn == 'Y'}">
            $("textarea.smeditor").ckeditor(CKEDITOR_CONFIG);
        </c:if>
        
        <c:if test="${confBean.fileYn == 'Y'}">
            $(".multifile").MultiFile({ max: "${confBean.fileCnt}" });
        </c:if>
    });
</script>

</body>
</html>
        