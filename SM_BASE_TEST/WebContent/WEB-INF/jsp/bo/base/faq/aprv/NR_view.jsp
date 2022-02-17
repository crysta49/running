<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>${curMenuBean.menuNm}</title>
    <meta name="title" content="상세정보" />
</head>
 
<body>

<form:form commandName="faqBean" id="listForm" name="listForm" action="index.do" method="get">
    <form:hidden path="seq" />
    <form:hidden path="currentPage" />
    <form:hidden path="rowPerPage" />
    <form:hidden path="searchKey" />
    <form:hidden path="searchVal" />
    <form:hidden path="ctgCd" />
</form:form>

<table class="tbl-header">
    <tr>
        <th><span class="title-big">${curMenuBean.menuNm} 상세정보</span></th>
    </tr>
</table>

<table class="tbl-view">
    <colgroup>
        <col class="th">
        <col>
        <col class="th">
        <col>
    </colgroup>
    <tr>
        <th>제목</th>
        <td colspan="3">
            <span class="label label-primary">${dataBean.ctgNm}</span>
            <b>${dataBean.title}</b> <sm:new-icon date="${dataBean.regDt}"/>
        </td>
    </tr>
    <tr>
        <th>내용</th>
        <td colspan="3">
            <div class="cnt-body word-over">
                ${dataBean.contents}
            </div>
        </td> 
    </tr>
    <tr>
        <th>첨부파일</th>
        <td colspan="3">
            <sm:file-list list="${dataBean.fileList}" />
        </td>
    </tr>
    <tr>
        <th>작성자</th>
        <td colspan="3">
            <span data-toggle="popover" data-popover-id="${dataBean.mgrId}" title="${dataBean.mgrNm}"><a href="#" onclick="return false;">${dataBean.mgrNm}</a></span>
        </td>
    </tr>
    <tr>
        <th>등록일</th>
        <td>${dataBean.regDt}</td>
        <th>최종 수정일</th>
        <td>${dataBean.modiDt}</td>
    </tr>
</table>

<sm:button-layout group="true">
    <c:if test="true">
        <sm:button value="삭제" glyph="remove" onclick="FAQ.deleteOneAction(this, '${dataBean.seq}');" />
        <sm:button value="수정" glyph="edit" onclick="FAQ.updateForm('${dataBean.seq}');" />
    </c:if>
    <sm:button value="목록" glyph="th-list" onclick="FAQ.list();"/>
</sm:button-layout>

<%--
<div class="left">
    <c:if test="${empty dataBean.ctgNm}">
        <span class="t3-exclamation text-warning">지식 분류정보가 없습니다. 분류정보를 수정하세요.</span>
    </c:if>
    <c:if test="${not empty dataBean.ctgNm}">
        <c:if test="${dataBean.aprvYn == 'Y'}"><sm:button value="승인취소" icon="check" onclick="js_aprvAction(this, '${dataBean.seq}', 'N');"/></c:if>
        <c:if test="${dataBean.aprvYn == 'N'}"><sm:button value="승인" icon="b3-tick" onclick="js_aprvAction(this, '${dataBean.seq}', 'Y');"/></c:if>
    </c:if>
</div> --%>

<script type="text/javascript" src="<c:url value="/resources/fm/js/faq-mng.js"/>"></script>
<script type="text/javascript">

    Ext.onReady(function() {
        
    });
</script>

</body>
</html>