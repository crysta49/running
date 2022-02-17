<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>
<c:set var="userSession" value="${sessionScope[CONSTANT.USER_SESSION_KEY]}" />

<sm:static var="BBS_CONF_UTIL" clazz="com.srpost.cm.bo.base.bbs.conf.BbsConfUtil"/>

<html>
<head>
    <title>${confBean.bbsNm} 상세조회</title>
</head>

<body>

<form:form commandName="bbsBean" id="listForm" name="listForm" action="NR_list.do" method="get">
    <form:hidden path="bbsCd" />
    <form:hidden path="bbsSeq" />
    <form:hidden path="currentPage" />
    <form:hidden path="rowPerPage" />
    <form:hidden path="searchKey" />
    <form:hidden path="searchVal" />
    <form:hidden path="ctgCd" />
</form:form>

<table>
    <c:if test="${confBean.ctgYn == 'Y'}">
        <tr>
            <th>분류</th>
            <td colspan="3">
                ${dataBean.ctgNm}
            </td>
        </tr>
    </c:if>
    <tr>
        <th>제목</th>
        <td colspan="3">
            <c:if test="${dataBean.delYn == 'Y'}"><span class="emphasis">삭제된 게시글 입니다.</span></c:if>
            <c:if test="${dataBean.delYn != 'Y'}"><strong>${dataBean.title}</strong></c:if>
            <sm:new-icon date="${dataBean.regDt}"/>
        </td>
    </tr>
    <tr>
        <td colspan="4" class="contents-view">
            <c:if test="${dataBean.htmlYn == 'Y'}">
                <div id="contents-desc" style="display: none;">${dataBean.question}</div>
                <div id="contents-frame"></div>
            </c:if>
            <c:if test="${dataBean.htmlYn == 'N'}">
                <sm:br data="${dataBean.question}"/>
            </c:if>
            <sm:image fileList="${dataBean.fileList}" />
        </td>
    </tr>
    <c:if test="${confBean.typeCd == BBS_CONF_UTIL.QNA}">
        <tr>
            <th>답변</th>
            <td colspan="3">
                <sm:br data="${dataBean.reply}"/>
            </td>
        </tr>
        <tr>
            <th>회신유형</th>
            <td>
                ${dataBean.alertNms}
            </td>
            <th>처리상태</th>
            <td>
                ${dataBean.statusNm}
            </td>
        </tr>
    </c:if>
    <c:if test="${confBean.fileYn == 'Y'}">
        <tr>
            <th>첨부파일</th>
            <td colspan="3">
                <sm:file-list list="${dataBean.fileList}" noData="true" downCnt="false" fileType="false"/>
            </td>
        </tr>
    </c:if>
    <tr>
        <th>등록일</th>
            <td colspan="3">
            ${dataBean.regDt}
            <c:if test="${not empty dataBean.modiDt}">
            (최종 수정 : ${dataBean.modiDt})
            </c:if> by 
            <sm:mask-word word="${dataBean.writerNm}"/>
        </td>
    </tr>
</table>

<sm:button-layout>
    <sm:button value="목록" onclick="BBS.list();"/>
    <c:if test="${not empty userSession and userSession.userKey == dataBean.userKey}">
        <c:if test="${confBean.typeCd == BBS_CONF_UTIL.QNA}">
            <c:if test="${dataBean.statusCd != BBS_CONF_UTIL.COMPLETE}">
                <sm:button value="수정" onclick="BBS.updateForm();"/>
            </c:if>
            <c:if test="${dataBean.statusCd == BBS_CONF_UTIL.RECEIVE}">
                <sm:button value="삭제" onclick="BBS.deleteAction('${bbsBean.bbsCd}', '${bbsBean.bbsSeq}');"/>
            </c:if>
        </c:if>
        <c:if test="${confBean.typeCd != BBS_CONF_UTIL.QNA}">
            <sm:button value="수정" onclick="BBS.updateForm();"/>
            <sm:button value="삭제" onclick="BBS.deleteAction('${bbsBean.bbsCd}', '${bbsBean.bbsSeq}');"/>
        </c:if>
    </c:if>
</sm:button-layout>

<%--
<table class="tbl-view">
    <c:if test="${not empty dataBean.nextBean}">
    <tr>
        <th>윗글</th>
        <td title="${dataBean.nextBean.title}" class="tl">
            <a href="#content" onclick="jsView('${dataBean.nextBean.bbsSeq}'); return false;">${dataBean.nextBean.title}</a>
        </td>
    </tr>
    </c:if>
    <c:if test="${not empty dataBean.prevBean}">
    <tr>
        <th>아래글</th>
        <td title="${dataBean.prevBean.title}" class="tl">
            <a href="#content" onclick="jsView('${dataBean.prevBean.bbsSeq}'); return false;">${dataBean.prevBean.title}</a>
        </td>
    </tr>
    </c:if>
</table> --%>

<div class="blank"></div>

<table>
    <tr>
        <td>
            <c:if test="${not empty dataBean.prevNextBean.nextKey}">
                <span class="prev">◀</span>&nbsp;
                <a href="#" title="이전 : ${dataBean.prevNextBean.nextTitle}" 
                    onclick="BBS.view('${dataBean.prevNextBean.nextKey}'); return false;"><sm:fix-length src="${dataBean.prevNextBean.nextTitle}" limit="40"/></a>
            </c:if>
        </td>
        <td class="tr">
            <c:if test="${not empty dataBean.prevNextBean.prevKey}">
                <a href="#" title="다음 : ${dataBean.prevNextBean.prevTitle}" 
                    onclick="BBS.view('${dataBean.prevNextBean.prevKey}'); return false;"><sm:fix-length src="${dataBean.prevNextBean.prevTitle}" limit="40"/></a>
                &nbsp;<span class="next">▶</span>
            </c:if>
        </td>
    </tr>
</table>

<div class="blank"></div>

<div id="commentDiv"></div>

<sm:js names="validation" />
<script type="text/javascript" src="<c:url value="/resources/front/FE/js/bbs.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/spi/jquery/wordcount/jquery.wordcount.js"/>"></script>
<script type="text/javascript">

    $().ready(function(){
        <c:if test="${confBean.cmtYn == 'Y'}">
            BBS.loadComment("${dataBean.bbsCd}", "${dataBean.bbsSeq}");
        </c:if>
        
        <c:if test="${dataBean.htmlYn == 'Y'}">
            SM.generateViewFrame( $(".contents-view") );
        </c:if>
    });
</script>

</body>
</html>