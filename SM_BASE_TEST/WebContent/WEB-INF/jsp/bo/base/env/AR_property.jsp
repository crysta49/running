<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<div class="panel-body panel-env">
    <fieldset>
        <legend>시스템 프로퍼티</legend>
        <div>
            <dl class="dl-horizontal">
            <c:forEach items="${dataList}" var="item">
                <dt title="${item.key}">${item.key}</dt>
                <dd>${item.value}</dd>
            </c:forEach>
            </dl>
        </div>
    </fieldset>
</div>