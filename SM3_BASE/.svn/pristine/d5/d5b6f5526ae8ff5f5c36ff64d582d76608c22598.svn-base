<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<div class="panel-body panel-env">
    <fieldset>
        <legend>서버 이중화 설정 정보</legend>
        <div>
            <dl class="dl-horizontal">
                <dt>현재 서버 IP</dt>
                <dd><span class="bold">${serverIp}</span></dd>
                
                <dt>스케줄링 제외서버 목록</dt>
                <dd>
                    <c:forEach items="${excludeServerList}" var="value" varStatus="status">
                        <span class="label label-inverse">${value}</span>
                    </c:forEach>
                    <c:if test="${empty excludeServerList}"><span class="label label-default">없음</span></c:if>
                </dd>
                
                <dt>스케줄링 대상 여부</dt>
                <dd>
                    <c:if test="${isExcludeServer}"><span class="label label-success">스케줄링 미대상 서버</span></c:if>
                    <c:if test="${!isExcludeServer}"><span class="label label-danger">스케줄링 대상 서버</span></c:if>
                </dd>
                
                <dt>캐시 대상서버 목록</dt>
                <dd>
                    <c:forEach items="${cacheServerList}" var="value" varStatus="status">
                        <span class="label label-success">${value}</span>
                    </c:forEach>
                    <c:if test="${empty cacheServerList}"><span class="label label-default">없음</span></c:if>
                </dd>
            </dl>
        </div>
    </fieldset>
</div>