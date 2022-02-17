<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>
<c:set var="mgrSession" value="${sessionScope[CONSTANT.MGR_SESSION_KEY]}" />

<form:form commandName="bbsBean" id="listForm" name="listForm" action="NR_index.do" method="get">
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
        <input type="hidden" name="${CONSTANT.GLOBAL_EXCL_XSS_KEY}" value="reply"/>
    </c:if>
    
    <table class="tbl-header">
        <tr>
            <th><span class="title-big">답변 등록</span></th>
            <td class="tr"><span class="required">표시는 필수입력 항목입니다.</span></td>
        </tr>
    </table>

    <table class="tbl-view">
        <colgroup>
            <col class="th">
            <col>
        </colgroup>
        <tr>
            <th>제목</th>
            <td>
                <c:if test="${confBean.ctgYn == 'Y'}">
                    <span>[${dataBean.ctgNm}]</span>
                </c:if>
                <strong>${dataBean.title}</strong>
            </td>
        </tr>
        <tr>
            <th>내용</th>
            <td class="contents-view">
                <c:if test="${dataBean.htmlYn == 'Y'}">
                    ${dataBean.question}
                </c:if>
                <c:if test="${dataBean.htmlYn == 'N'}">
                    <sm:br data="${dataBean.question}"/>
                </c:if>
            </td>
        </tr>
        <tr>
            <th>답변<em>&nbsp;</em></th>
            <td>
                <form:textarea path="reply" rows="8" cssClass="smf-ta smeditor"/>
            </td>
        </tr>
        <tr>
            <th>처리상태</th>
            <td>
                ${dataBean.statusNm}
            </td>
        </tr>
    </table>
    
    <sm:button-layout>
        <sm:button value="취소" glyph="" cssClass="btn-link" onclick="history.back();" />
        <sm:button type="submit" value="저장" glyph="saved"/>
    </sm:button-layout>
    
</form:form>

<sm:js names="validation, multifile, ckeditor" />
<script type="text/javascript" src="<c:url value="/resources/fm/js/bbs.js"/>"></script>
<script type="text/javascript">

    Ext.onReady(function() {
        
        SM.generateViewFrame( $(".contents-view") );

        $("#dataForm").validate({
            rules: {
                reply  : { required: true }
            }, 
            submitHandler: function(form) {

                <c:if test="${confBean.htmlYn == 'Y'}">
                    if ($("#reply").val() == "") {
                        alert("답변을 입력하세요."); return;
                    }
                </c:if>
                
                SM.submit(form, {
                    url: "TR_insertAction.do"
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        BBS.view('${dataBean.bbsSeq}');
                    }
                });
            }
        });
        
        <c:if test="${confBean.htmlYn == 'Y'}">
            $("textarea.smeditor").ckeditor(CKEDITOR_CONFIG);
        </c:if>
    });
</script>

        
        