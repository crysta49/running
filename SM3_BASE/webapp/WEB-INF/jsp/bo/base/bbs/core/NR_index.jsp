<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>
<sm:static var="BBS_CONF_UTIL" clazz="com.srpost.cm.bo.base.bbs.conf.BbsConfUtil"/>

<html>
<head>
    <title>${curMenuBean.menuNm}</title>
    <meta name="title" content="${curMenuBean.menuNm} 내용을 확인합니다." />
</head>
 
<body>

<form:form id="csrfForm" name="csrfForm"></form:form>

<table class="tbl-header">
    <tr>
        <th style="width: 35%;">
            <span class="title-big">전체 ${pagerBean.totalNum}건 (${pagerBean.currPage}/${pagerBean.lastPage} pages)</span>
        </th>
        <td class="tr">
            <form name="listForm" method="get" onsubmit="return BBS.search();">
                <input type="hidden" name="bbsCd" value="${bbsBean.bbsCd}" />
                <input type="hidden" name="bbsSeq" value="" />
                <input type="hidden" name="currentPage" value="${bbsBean.currentPage}" />
                <input type="hidden" name="rowPerPage" value="${bbsBean.rowPerPage}" />
    
                <c:if test="${confBean.typeCd == BBS_CONF_UTIL.QNA}">
                    <sm:code id="statusCd" grpCd="BBS_STATUS" defaultLabel="-- 상태 --" defaultValues="${smp.statusCd}" onchange="BBS.autoSearch();"/>
                </c:if>
                <c:if test="${confBean.ctgYn == 'Y'}">
                    <select name="ctgCd" id="ctgCd" class="smf-select" onchange="BBS.autoSearch();">
                        <option value="">-- 분류 --</option>
                        <c:forEach items="${confBean.ctgList}" var="item">
                            <option value="${item.ctgCd}" <c:if test="${smp.ctgCd == item.ctgCd}">selected="selected"</c:if>>${item.ctgNm}</option>
                        </c:forEach>
                    </select>
                </c:if>
                <select name="searchKey" id="searchKey" class="smf-select">
                    <option value="1000" <c:if test="${smp.searchKey eq '1000' }">selected="selected"</c:if>>제목</option>
                    <option value="2000" <c:if test="${smp.searchKey eq '2000' }">selected="selected"</c:if>>내용</option>
                    <option value="4000" <c:if test="${smp.searchKey eq '4000' }">selected="selected"</c:if>>작성자</option>
                </select>
                <input type="text" name="searchVal" id="searchVal" value="${bbsBean.searchVal}" class="smf-text"/>
                <sm:button type="submit" cssClass="btn-default" glyph="search" value="검색" />
                <c:if test="${not empty bbsBean.searchKey and not empty bbsBean.searchVal}">
                    <sm:button value="해제" cssClass="btn-default" onclick="BBS.resetSearch();" />
                </c:if>
            </form>
        </td>
    </tr>
</table>

<div class="blank"></div>

<table class="tbl-list">
    <colgroup>
        <col style="width: 8%">
        <c:if test="${confBean.typeCd == BBS_CONF_UTIL.QNA}">
            <col style="width: 90px">
        </c:if>
        <c:if test="${confBean.ctgYn == 'Y'}">
            <col style="width: 100px">
        </c:if>
        <col>
        <col style="width: 12%">
    </colgroup>
    <thead>
        <tr>
            <th>번호</th>
            <c:if test="${confBean.typeCd == BBS_CONF_UTIL.QNA}">
                <th>상태</th>
            </c:if>
            <c:if test="${confBean.ctgYn == 'Y'}">
                <th>분류</th>
            </c:if>
            <th>제목</th>
            <th>등록일</th>
        </tr>
    </thead>
    <tbody>
    <c:set var="index" value="${pagerBean.indexNo}"/>
    <c:forEach items="${pagerBean.list}" var="item" varStatus="status">
        <tr>
            <td>${index-status.index}</td>
            <c:if test="${confBean.typeCd == BBS_CONF_UTIL.QNA}">
                <td>${item.statusNm}</td>
            </c:if>
            <c:if test="${confBean.ctgYn == 'Y'}">
                <td>${item.ctgNm}</td>
            </c:if>
            <td class="tl text-overflow">
                <c:if test="${item.depth > 0}">
                    <span class="t3-re" style="margin-left: ${item.depth*20}px;">&nbsp;</span>
                </c:if>
                <a href="#" onclick="BBS.view('${item.bbsSeq}'); return false;">${item.title}</a>
                
                <sm:new-icon date="${item.regDt}"/>
                
                <c:if test="${confBean.fileYn == 'Y' and item.fileCnt > 0}">
                    <span class="t3-file" title="첨부파일 ${item.fileCnt}개">${item.fileCnt}</span>
                </c:if>
                <c:if test="${confBean.cmtYn == 'Y' and item.commentCnt > 0}">
                    <span class="t3-comment" title="의견글 ${item.commentCnt}개">${item.commentCnt}</span>
                </c:if>
            </td>
            <td>${item.regDt}</td>
        </tr>
    </c:forEach>
    <sm:no-data dataBean="${pagerBean.list}" colspan="${confBean.ctgYn == 'Y' ? (confBean.typeCd == BBS_CONF_UTIL.QNA ? '5':'4') : (confBean.typeCd == BBS_CONF_UTIL.QNA ? '4':'3')}"/>
    </tbody>
</table>

<sm:button-layout group="true">
    <sm:button value="엑셀" glyph="floppy-save" onclick="js_excelAction(this);"/>
    <c:if test="${hasAuth}">
        <sm:button value="등록" glyph="plus" onclick="BBS.insertForm('${bbsBean.bbsCd}');"/>
    </c:if>
</sm:button-layout>

<sm:pager pagerBean="${pagerBean}" script="BBS"/>

<script type="text/javascript" src="<c:url value="/resources/fm/js/bbs.js"/>"></script>
<script type="text/javascript">

    Ext.onReady(function() {
    });
    
    var js_excelAction = function() {

        SM.modal({
            title: "엑셀 변환 옵션 선택",
            width: 550,
            height: 450,
            loadUrl: "PR_excelForm.do?bbsCd=${smp.bbsCd}"
        });
    };
</script>
    
</body>
</html>