<%@ page contentType="text/html;charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<div id="debugInfoDiv" class="hidden">
    <table class="tbl-header">
        <tr>
            <th><span class="title-big">디버그정보 조회</span></th>
            <td class="tr"><sm:button value="닫기" onclick="$('#debugInfoDiv').hide();"/></td>
        </tr>
    </table>
    <table class="tbl-view">
        <colgroup>
            <col class="th">
            <col>
        </colgroup>
        <tr>
            <th>어트리뷰트</th>
            <td><div>
                <dl>
                <c:forEach var="item" items="${pageContext.request.attributeNames}">
                    <c:if test="${!fn:contains(item, 'ConversionService') and !fn:contains(item, 'HandlerMapping')}">
                        <dt>${item}</dt>
                        <dd>${requestScope[item]}</dd>
                    </c:if>
                </c:forEach>
                </dl></div>
            </td>
        </tr>
        <tr>
            <th>세션</th>
            <td><div>
                <dl>
                <c:forEach var="item" items="${sessionScope}">
                    <dt>${item.key}</dt>
                    <dd>${item.value}</dd>
                </c:forEach>
                </dl></div>
            </td>
        </tr>
        <tr>
            <th>헤더</th>
            <td><div>
                <dl>
                <c:forEach var="item" items="${header}">
                    <c:if test="${item.key != 'cookie'}">
                        <dt>${item.key}</dt>
                        <dd>${item.value}</dd>
                    </c:if>
                </c:forEach>
                </dl></div>
            </td>
        </tr>
        <tr>
            <th>쿠키</th>
            <td><div>
                <dl>
                <c:forEach var="item" items="${cookie}">
                    <dt>${item.key}</dt>
                    <dd>${item.value.value}</dd>
                </c:forEach>
                </dl></div>
            </td>
        </tr>
    </table>
    <div class="blank"></div>
</div>