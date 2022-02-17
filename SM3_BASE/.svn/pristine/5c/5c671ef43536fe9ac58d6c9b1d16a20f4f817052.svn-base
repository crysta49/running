<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<div class="panel-body panel-env">
    <fieldset>
        <legend>WAS(Web Application Server) 정보</legend>
        <div>
            <dl class="dl-horizontal">
                <dt>JAVA 버전</dt>
                <dd>${dataMap.javaInfo}</dd>
                
                <dt>JAVA 배포사</dt>
                <dd>${dataMap.javaVendor}</dd>
                
                <dt>JAVA HOME</dt>
                <dd>${dataMap.javaHome}</dd>
                
                <dt>실행 인자</dt>
                <dd>
                    <c:forEach items="${dataMap.inputArgs}" var="item">
                        ${item}<br/>
                    </c:forEach>
                </dd>
                
                <dt>구동시간</dt>
                <dd>${dataMap.startTime} (${dataMap.upTime})</dd>
                
                <dt>웹루트</dt>
                <dd>${CONSTANT.WEB_APP_ROOT}</dd>
                
                <dt>컨텍스트</dt>
                <dd>${pageContext.request.contextPath}</dd>
                
                <dt>J2EE 버전</dt>
                <dd>${pageContext.servletContext.majorVersion}.${pageContext.servletContext.minorVersion}</dd>
            </dl>
        </div>
        <div class="text-center" style="position: absolute; top: 30px; right: 25px;">
            <img src="<c:url value="/resources/base/images/base/env/${dataMap.wasImage}.png"/>" /><br/>
            <strong>${dataMap.wasName}</strong>
        </div>
        <%--
        <sm:button-layout>
            <sm:button value="web.xml 조회"/>
        </sm:button-layout> --%>
    </fieldset>
</div>

<div class="blank"></div>

<%--
                <tr>
                    <th>Method</th>
                    <td>${pageContext.request.method}</td>
                </tr>
                <tr>
                    <th>Protocol</th>
                    <td>${pageContext.request.protocol}</td>
                </tr>
                <tr>
                    <th>CharacterEncoding</th>
                    <td>${pageContext.request.characterEncoding}</td>
                </tr>
                <tr>
                    <th>RequestURI</th>
                    <td>${pageContext.request.requestURI}</td>
                </tr>
                <tr>
                    <th>ServletPath</th>
                    <td>${pageContext.request.servletPath}</td>
                </tr>
                
<table class="tbl-view">
    <colgroup>
        <col class="th">
        <col>
    </colgroup>
    <tr>
        <th>ContentType</th><td>${pageContext.request.contentType}</td>
    </tr><tr>
        <th>PathInfo</th><td>${pageContext.request.pathInfo}</td>
    </tr><tr>
        <th>PathTranslated</th><td>${pageContext.request.pathTranslated}</td>
    </tr><tr>
        <th>ServerName</th><td>${pageContext.request.serverName}</td>
    </tr><tr>    
        <th>ServerPort</th><td>${pageContext.request.serverPort}</td>
    </tr><tr>
        <th>RemoteUser</th><td>${pageContext.request.remoteUser}</td>
    </tr><tr>
        <th>RemoteAddr</th><td>${pageContext.request.remoteAddr}</td>
    </tr><tr>
        <th>RemoteHost</th><td>${pageContext.request.remoteHost}</td>
    </tr><tr>
        <th>AuthType</th><td>${pageContext.request.authType}</td>
    </tr>
    <tr>
        <th>SessionId</th><td>${pageContext.request.session.id}</td>
    </tr>
    <tr>
        <th>SessionCrTime()</th><td>${creationTime}</td>
    </tr>
    <tr>
        <th>SessionLaTime()</th><td>${lastAccessTime}</td>
    </tr>
    <tr>
        <th>SessionTracking</th><td>${sessionTracking}</td>
    </tr>
</table> --%>
