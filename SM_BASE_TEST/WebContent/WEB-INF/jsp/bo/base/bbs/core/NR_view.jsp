<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>
<sm:static var="BBS_CONF_UTIL" clazz="com.srpost.cm.bo.base.bbs.conf.BbsConfUtil"/>
<c:set var="mgrSession" value="${sessionScope[CONSTANT.MGR_SESSION_KEY]}" />

<html>
    <head>
    <title>${curMenuBean.menuNm}</title>
    <meta name="title" content="상세정보" />
    </head>
<body>

<form:form commandName="bbsBean" id="listForm" name="listForm" action="index.do" method="get">
    <form:hidden path="bbsCd" />
    <form:hidden path="bbsSeq" />
    <form:hidden path="currentPage" />
    <form:hidden path="rowPerPage" />
    <form:hidden path="searchKey" />
    <form:hidden path="searchVal" />
    <form:hidden path="ctgCd" />
</form:form>

<table class="tbl-header">
    <tr>
        <th><span class="title-big">${curMenuBean.menuNm} 상세정보</span></th>
        <td class="tr"><span class="required">표시는 필수입력 항목입니다.</span></td>
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
            <c:if test="${confBean.ctgYn == 'Y'}">
                <span class="label label-primary">${dataBean.ctgNm}</span>
            </c:if>
            <b>${dataBean.title}</b> <sm:new-icon date="${dataBean.regDt}"/>
        </td>
    </tr>
    <tr>
        <th>내용</th>
        <td colspan="3">
            <div class="cnt-body word-over">
                <c:if test="${dataBean.htmlYn == 'Y'}">
                    ${dataBean.question}
                </c:if>
                <c:if test="${dataBean.htmlYn == 'N'}">
                    <sm:br data="${dataBean.question}"/>
                </c:if>
            </div>
        </td> 
    </tr>
    <c:if test="${confBean.typeCd == BBS_CONF_UTIL.QNA && not empty dataBean.reply}">
        <tr>
            <th>답변</th>
            <td colspan="3">
                <div class="cnt-body word-over">
                    <c:if test="${dataBean.htmlYn == 'Y'}">
                        ${dataBean.reply}
                    </c:if>
                    <c:if test="${dataBean.htmlYn == 'N'}">
                        <sm:br data="${dataBean.reply}"/>
                    </c:if>
                </div>
            </td> 
        </tr>
    </c:if>
    <c:if test="${confBean.fileYn == 'Y'}">
        <tr>
            <th>첨부파일</th>
            <td colspan="3">
                <sm:file-list list="${dataBean.fileList}" />
            </td>
        </tr>
    </c:if>
    <tr>
        <th>작성자</th>
        <td colspan="3">
            <span data-toggle="popover" data-popover-id="${dataBean.mgrId}" title="${dataBean.writerNm}"><a href="#" onclick="return false;">${dataBean.writerNm}</a></span>
        </td>
    </tr>
    <c:if test="${confBean.typeCd == BBS_CONF_UTIL.QNA}">
        <tr>
            <th>상태</th>
            <td>
                <span>${dataBean.statusNm}</span>
            </td>
            <th>답변자</th>
            <td>
                <span data-toggle="popover" data-popover-id="${dataBean.mgrId}" title="${dataBean.replyNm}"><a href="#" onclick="return false;">${dataBean.replyNm}</a></span>
            </td>
        </tr>
    </c:if>
    <tr>
        <th>등록일</th>
        <td>${dataBean.regDt}</td>
        <th>최종 수정일</th>
        <td>${dataBean.modiDt}</td>
    </tr>
</table>

<sm:button-layout group="true">
    <c:if test="${hasAuth}">
        <sm:button value="삭제" glyph="remove" onclick="BBS.deleteOneAction(this, '${dataBean.bbsCd}', '${dataBean.bbsSeq}');" />
        <sm:button value="수정" glyph="edit" onclick="BBS.updateForm('${dataBean.bbsSeq}');" />
    </c:if>
    <c:if test="${confBean.typeCd == BBS_CONF_UTIL.HIERARCHY}">
        <sm:button value="댓글" glyph="plus" onclick="BBS.replyForm('${dataBean.bbsSeq}');" />
    </c:if>
    <c:if test="${confBean.typeCd == BBS_CONF_UTIL.QNA and hasAuth}">
        <sm:button value="답변" glyph="plus" onclick="BBS.endReplyForm('${dataBean.bbsSeq}');" />
    </c:if>
    <sm:button value="목록" glyph="th-list" onclick="BBS.list();"/>
</sm:button-layout>

<div class="row prev-next">
    <div class="col-xs-6 prev">
        <c:if test="${not empty dataBean.prevNextBean.prevKey}">
            <i class="glyphicon glyphicon-menu-left"></i> <span>이전글</span> 
            <a href="#" title="${dataBean.prevNextBean.prevTitle}" 
                onclick="BBS.view('${dataBean.prevNextBean.prevKey}'); return false;">${dataBean.prevNextBean.prevTitle}</a>
        </c:if>
    </div>
    <div class="col-xs-6 next text-right">
        <c:if test="${not empty dataBean.prevNextBean.nextKey}">
            <a href="#" title="${dataBean.prevNextBean.nextTitle}" 
                onclick="BBS.view('${dataBean.prevNextBean.nextKey}'); return false;">${dataBean.prevNextBean.nextTitle}</a>
            <span>다음글</span>  <i class="glyphicon glyphicon-menu-right"></i>
        </c:if>
    </div>
</div>

<div id="cmdListView"></div>

<sm:js names="validation" />
<script type="text/javascript" src="<c:url value="/resources/spi/jquery/wordcount/jquery.wordcount.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/fm/js/bbs.js"/>"></script>
<script type="text/javascript">

    Ext.onReady(function() {
        <c:if test="${confBean.cmtYn == 'Y'}">
        BBS.loadComment("${dataBean.bbsCd}", "${dataBean.bbsSeq}");
        </c:if>
    });
</script>

</body>
</html>