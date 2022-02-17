<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<form:form commandName="dataBean" id="listForm" name="listForm" action="index.do" method="get">
    <form:hidden path="bbsCd" id="_bbsCd"/>
    <form:hidden path="bbsSeq" id="_bbsSeq"/>
    <form:hidden path="currentPage" id="_currentPage"/>
    <form:hidden path="rowPerPage" id="_rowPerPage"/>
    <form:hidden path="searchKey" id="_searchKey"/>
    <form:hidden path="searchVal" id="_searchVal"/>
    <form:hidden path="ctgCd" id="_ctgCd"/>
</form:form>

<form:form commandName="dataBean" id="dataForm" name="dataForm" autocomplete="off">
    <form:hidden path="bbsCd"/>
    <form:hidden path="bbsSeq"/>
    <c:if test="${confBean.htmlYn == 'Y'}">
        <input type="hidden" name="${CONSTANT.GLOBAL_EXCL_XSS_KEY}" value="question"/>
    </c:if>
    
    <table class="tbl-header">
        <tr>
            <th><span class="title-big">댓글 등록</span></th>
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
                <textarea name="question" id="question" class="smf-ta smeditor" rows="8"></textarea>
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
                    </div>
                </th>
                <td colspan="3">
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
        <c:if test="${confBean.openYn == 'Y'}">
            <tr>
                <th>공개여부<em>&nbsp;</em>
                    <span class="t3-help smtip">&nbsp;</span>
                    <div class="hidden">
                        <div class="smtip-title">공개여부</div>
                        <div class="smtip-text">
                            <div>비공개 선택 시 해당 글은 고객단 화면에 표시되지 않습니다.</div>
                        </div>
                    </div>
                </th>
                <td colspan="3">
                    <form:radiobutton path="openYn" value="Y" label="공개" cssClass="smf-radio" />
                    <form:radiobutton path="openYn" value="N" label="비공개" cssClass="smf-radio" />
                </td>
            </tr>
        </c:if>
        <%-- 
        * 사용자 테이블 사용 시 샘플 코드
        <tr>
            <th>VIEW_OPTION</th>
            <td>
                <input type="text" name="VIEW_OPTION" size="1" maxlength="1" value="${dataBean.extMap.VIEW_OPTION}"/>
            </td>
            <th>SRC</th>
            <td>
                <input type="text" name="SRC" value="${dataBean.extMap.SRC}"/>
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

        $("#dataForm").validate({
            rules: {
                ctgCd : { required: ${confBean.ctgYn == 'Y' ? 'true' : 'false'} },
                title  : { required: true, maxlength: 120 },
                question  : { required: true }
            }, 
            submitHandler: function(form) {
                
                <c:if test="${confBean.htmlYn == 'Y'}">
                    if ($("#question").val() == "") {
                        alert("내용을 입력하세요."); return;
                    }
                </c:if>
                
                SM.submit(form, {
                    url: "TR_insertAction.do"
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        BBS.list();
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
        
        <c:if test="${confBean.htmlYn == 'Y'}">
    	    $("textarea.smeditor").ckeditor(CKEDITOR_CONFIG);
        </c:if>
        
        $(".multifile").MultiFile();
    });
</script>
