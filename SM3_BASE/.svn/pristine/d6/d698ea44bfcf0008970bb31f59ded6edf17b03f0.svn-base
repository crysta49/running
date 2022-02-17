<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<fmt:parseDate value="${calendar.PLAN_DAY}" pattern="yyyyMMdd" var="PLAN_DAY"/>
<fmt:formatDate value="${PLAN_DAY}" pattern="yyyy년 MM월" var="pDay"/>
<fmt:formatDate value="${PLAN_DAY}" pattern="dd" var="pDd"/>
<fmt:formatDate value="${PLAN_DAY}" pattern="E요일" var="pDow"/>

<c:set var="todayCnt" value="0"/>
<c:forEach items="${planList}" var="item">
    <c:if test="${item.DD eq pDd}"><c:set var="todayCnt" value="${todayCnt +1}"/></c:if>
</c:forEach>
<div class="ds-tright-data">
    <c:forEach items="${planList}" var="item" varStatus="index">
        <c:if test="${todayCnt > 0 && index.first}">
            <div class="today">
        </c:if>
        <c:if test="${todayCnt eq 0 && index.first}">
            <div class="today">
                <span class="f-bold">${pDd}일</span> <span>등록된 일정이 없습니다.</span>
            </div>
        </c:if>
        <div class="${item.DD eq pDd ? '' : 'orday '}text-overflow">
            <span class="f-bold">
                ${item.DD}일
            </span> 
            <a href="<c:url value="/bo/sr/plan/index.do?date=${item.START_DD}&seq=${item.SEQ}"/>">${item.TITLE}</a>
        </div>
        <c:if test="${todayCnt eq index.count}">
            </div>
        </c:if>
    </c:forEach>
    <c:if test="${empty planList}">
        <div class="today text-overflow"><span class="f-bold"></span>등록된 일정이 없습니다.</div>
    </c:if>
</div>

<script type="text/javascript">

    Ext.onReady(function() {
        $("#planYearMonth").text("${pDay}");
        $("#planPrevDay").html("<a href=\"#\" onclick=\"js_planList('${calendar.PREV_DAY}');\">◀</a>");
        $("#planDay").text("${pDd}");
        $("#planDow").text("(${pDow})");
        $("#planNextDay").html("<a href=\"#\" onclick=\"js_planList('${calendar.NEXT_DAY}');\">▶</a>");
    });
</script>