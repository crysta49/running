<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>직원 권한할당 이력</title>
</head>
 
<body>

<table class="tbl-header">
    <tr>
        <th style="width: 70%;">
            <span class="title-big"><c:out value="${smp.mgrNm}" />님, 권한할당 이력</span>
        </th>
        <td class="tr">전체 <b>${fn:length(dataList)}</b>건</td>
    </tr>
</table>
<table class="tbl-view">
    <colgroup>
        <col style="width: 140px">
        <col>
    </colgroup>
    <c:forEach items="${dataList}" var="item">
        <tr>
            <td>${item.regDt}</td>
            <td>${item.logContents}</td>
        </tr>
    </c:forEach>
    <c:if test="${empty dataList}">
        <sm:no-data dataBean="${dataList}" colspan="2"/>
    </c:if>
</table>
</body>
</html>