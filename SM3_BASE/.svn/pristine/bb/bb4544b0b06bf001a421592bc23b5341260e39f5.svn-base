<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>공지글 상세조회</title>
</head>

<body>

<table>
    <tr>
        <th>제목</th>
        <td colspan="3">
            <strong>${dataBean.title}</strong>
            <sm:new-icon date="${dataBean.regDt}"/>
        </td>
    </tr>
    <tr>
        <th>내용</th>
        <td colspan="3">
            <div id="contents-desc" style="display: none;">${dataBean.contents}</div>
            <div id="contents-frame"></div>
            <%-- <sm:image fileList="${dataBean.fileList}" /> --%>
        </td>
    </tr>
    <tr>
        <th>첨부파일</th>
        <td colspan="3">
            <sm:file-list list="${dataBean.fileList}" noData="true" downCnt="false" fileType="false"/>
        </td>
    </tr>
    <tr>
        <th>등록일</th>
            <td colspan="3">
            ${dataBean.regDt}
            <c:if test="${not empty dataBean.modiDt}">
            (최종 수정 : ${dataBean.modiDt})
            </c:if>
        </td>
    </tr>
</table>

<sm:button-layout>
    <sm:button value="목록" onclick="history.back();"/>
</sm:button-layout>

<script type="text/javascript" src="<c:url value="/resources/front/FE/js/bbs.js"/>"></script>
<script type="text/javascript">

    $().ready(function(){

        var iframe = $('<iframe frameborder="0"></iframe>').css({
            "width": "100%", "height": $(".contents-view").height()
        }).load(function(){
            $(this).contents().find("body").css("font-size", "12px").html( $("#contents-desc").html() );
            $(this).height( $(this).contents().height()+20 );
        });
        
        $("#contents-frame").append(iframe);
    });
</script>

</body>
</html>