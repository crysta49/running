<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>고객 개인정보 조회 이력</title>
</head>
 
<body>

<table class="tbl-header">
    <tr>
        <th><span class="title-big"><c:out value="${smp.userNm}" />, 개인정보 조회 이력</span></th>
        <td class="tr"></td>
    </tr>
</table>

<div class="smd-box" style="height: 300px; overflow: auto;">
    <table class="tbl-view">
        <colgroup>
            <col style="width: 140px">
            <col>
            <col style="width: 80px">
        </colgroup>
        <c:forEach items="${dataList}" var="item">
            <tr>
                <td>${item.regDt}</td>
                <td>${item.logContents}</td>
                <td>${item.mgrNm}</td>
            </tr>
        </c:forEach>
        <c:if test="${empty dataList}">
            <tr>
                <td colspan="3">
                    <div class="tc"><span class="t3-exclamation text-warning">표시할 자료가 없습니다.</span></div>
                </td>
            </tr>
        </c:if>
    </table>
</div>

</body>
</html>