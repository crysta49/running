<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
    <head>
    <title>${curMenuBean.menuNm}</title>
    <meta name="title" content="FAQ 정보를 관리합니다." />
    </head>
<body>

<table class="tbl-header">
    <tr>
        <th style="width: 35%;">
            <span class="title-big">전체 ${pagerBean.totalNum}건 (${pagerBean.currPage}/${pagerBean.lastPage} pages)</span>
        </th>
        <td class="tr">
            <form name="listForm" method="get" onsubmit="return FAQ.search();">
                <input type="hidden" name="seq" value="" />
                <input type="hidden" name="currentPage" value="${faqBean.currentPage}" />
                <input type="hidden" name="rowPerPage" value="${faqBean.rowPerPage}" />
    
                <select name="ctgCd" id="ctgCd" class="smf-select" onchange="FAQ.autoSearch();">
                    <option value="">-- 분류 --</option>
                    <c:forEach items="${ctgList}" var="item">
                        <option value="${item.ctgCd}" ${smp.ctgCd == item.ctgCd ? 'selected=selected' : ''}>${fn:replace(item.ctgNm, '^', '&nbsp;')}</option>
                    </c:forEach>
                </select>
                <select name="searchKey" id="searchKey" class="smf-select">
                    <option value="1000" ${smp.searchKey == '1000' ? 'selected=selected' : ''}>제목</option>
                    <option value="2000" ${smp.searchKey == '2000' ? 'selected=selected' : ''}>내용</option>
                </select>
                <input type="text" name="searchVal" id="searchVal" value="${faqBean.searchVal}" class="smf-text"/>
                <sm:button type="submit" cssClass="btn-default" glyph="search" value="검색" />
                <c:if test="${not empty faqBean.searchVal  or not empty smp.ctgCd}">
                    <sm:button value="해제" cssClass="btn-default" onclick="FAQ.resetSearch();" />
                </c:if>
            </form>
        </td>
    </tr>
</table>

<div class="blank"></div>

<table class="tbl-list">
    <colgroup>
        <col style="width: 8%">
        <col>
        <col style="width: 12%">
    </colgroup>
    <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>등록일</th>
        </tr>
    </thead>
    <tbody>
    <c:set var="index" value="${pagerBean.indexNo}"/>
    <c:forEach items="${pagerBean.list}" var="item" varStatus="status">
        <tr>
            <td>${index-status.index}</td>
            <td class="tl text-overflow">
                <a href="#" onclick="FAQ.view('${item.seq}'); return false;">${item.title}</a>
                
                <sm:new-icon date="${item.regDt}"/>
                
                <c:if test="${item.fileCnt > 0}">
                    <span class="t3-file" title="첨부파일 ${item.fileCnt}개">${item.fileCnt}</span>
                </c:if>
            </td>
            <td>${item.regDt}</td>
        </tr>
    </c:forEach>
    <sm:no-data dataBean="${pagerBean.list}" colspan="3"/>
    </tbody>
</table>

<sm:button-layout group="true">
    <sm:button value="엑셀" glyph="floppy-save" onclick="js_excelAction(this);"/>
    <sm:button value="등록" glyph="plus" onclick="FAQ.insertForm();"/>
</sm:button-layout>

<sm:pager pagerBean="${pagerBean}" script="FAQ"/>

<script type="text/javascript" src="<c:url value="/resources/fm/js/faq-mng.js"/>"></script>
<script type="text/javascript">
    $(document).ready(function(){
    });
    
    var js_excelAction = function() {

        SM.modal({
            title: "엑셀 변환 옵션 선택",
            width: 550,
            height: 450,
            loadUrl: "PR_excelForm.do"
        });
    };
</script>

</body>
</html>