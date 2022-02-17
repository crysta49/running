<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<html>
<head>
    <title>상세보기</title>
    <script type="text/javascript" src="<c:url value="/resources/front/FE2/js/bbs.js"/>"></script>
</head>

<body>

<form:form commandName="bbsBean" id="dataForm" name="dataForm" action="NR_list.do" method="get">
    <form:hidden path="bbsCd" />
    <form:hidden path="bbsSeq" />
    <form:hidden path="currentPage" />
    <form:hidden path="rowPerPage" />
    <form:hidden path="searchKey" />
    <form:hidden path="searchVal" />
    <form:hidden path="ctgCd" />
    <input type="hidden" name="_m" value="${smp._m}" />
</form:form>

<div id="board_view">
    <table class="view_top" summary="제목, 작성자, 작성일, 내용 등으로 구성">
        <caption>공지사항 글 내용</caption>
        <colgroup>
            <col style="width:*" />
            <col style="width:250px" />
        </colgroup>
        <tr>
            <th scope="col" colspan="2">${dataBean.title}</th>
        </tr>
        <tr>
            <td><span class="default">작성자</span> ${dataBean.writerNm}</td>
            <td><span class="default">작성일</span> ${dataBean.regDt}</td>
        </tr>          
        <c:if test="${confBean.fileYn == 'Y'}">
            <c:if test="${not empty dataBean.fileList}">
            <tr>
                <td colspan="2">
                    <span class="default">첨부파일</span> 
                    <ul class="file_list">
                    <c:forEach items="${dataBean.fileList}" var="item">
                        <li><img src="<c:url value="/resources/front/FE2/images/board/icon_file.gif"/>" class="fileImg" alt="" /> 
                        <a href="<c:url value="/common/file/NR_download.do"/>?id=${item.fileId}">${item.orgFileNm} ( ${item.fileSize} )</a></li> 
                    </c:forEach>
                    </ul>
                </td>
            </tr>
            </c:if>
        </c:if>  
        <tr>
            <td colspan="2" class="view_content"><sm:br data="${dataBean.question}" /></td>
        </tr>
    </table>
      
    <div class="view_bt">
        <p id="bt"><a href="#" onclick="BBS.list(); return false;"><img src="<c:url value="/resources/front/FE2/images/board/bt_list.gif"/>" class="cl" alt="목록으로" /></a></p>
    </div>
      
    <%--  
    <!-- 이전글, 다음글 -->
    <c:if test="${not empty dataBean.prevBean}">
        <dl class="prev_list" title="${dataBean.prevBean.title}">
            <dt>이전글</dt>
            <dd><a href="#content" onclick="jsView('${dataBean.prevBean.bbsSeq}'); return false;">${dataBean.prevBean.title}</a></dd>
        </dl>
    </c:if> 
    <c:if test="${not empty dataBean.nextBean}">   
        <dl class="next_list" title="${dataBean.nextBean.title}">
            <dt>다음글</dt>
            <dd><a href="#content" onclick="jsView('${dataBean.nextBean.bbsSeq}'); return false;">${dataBean.nextBean.title}</a></dd>
        </dl>
    </c:if> --%>
</div>

</body>
</html>