<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<table class="tbl-view">
    <colgroup>
        <col class="th">
        <col>
    </colgroup>
    <tr>
        <th>Method</th><td>${pageContext.request.method}</td>
    </tr><tr>
        <th>Protocol</th><td>${pageContext.request.protocol}</td>
    </tr><tr>
        <th>CharacterEncoding</th><td>${pageContext.request.characterEncoding}</td>
    </tr><tr>
        <th>ContentType</th><td>${pageContext.request.contentType}</td>
    </tr><tr>
        <th>RequestURI</th><td>${pageContext.request.requestURI}</td>
    </tr><tr>
        <th>ServletPath</th><td>${pageContext.request.servletPath}</td>
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
    </tr><tr>
        <th>ContextPath</th><td>${pageContext.request.contextPath}</td>
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
</table>

<salmon:button-layout>
    <salmon:button value="다시읽기" icon="bi-reload" onclick="jsReloadTab();"/>
</salmon:button-layout>

<p>&nbsp;</p>

<div id="infoDiv">
    <div class="fr">
        <label id="toggleSession" class="arrow-show" onclick="jsToggle($('#toggleSession'), $('#sessionDl'));">보기</label>
    </div>
    <strong class="br-green">세션 정보</strong> 
    <div id="sessionDl" style="max-height:250px; overflow: auto;" class="sm-info-div-line">
        <dl>
        <c:forEach var="item" items="${sessionScope}">
            <dt>${item.key}</dt>
            <dd>${item.value}</dd>
        </c:forEach>
        </dl>
    </div>        
</div>

<p>&nbsp;</p>

<div id="infoDiv">
    <div class="fr">
        <label id="toggleHeader" class="arrow-show" onclick="jsToggle($('#toggleHeader'), $('#headerDl'));">보기</label>
    </div>
    <strong class="br-green">헤더 정보</strong> 
    <div id="headerDl" style="max-height:250px; overflow: auto;" class="sm-info-div-line">
        <dl>
        <c:forEach var="item" items="${header}">
            <c:if test="${item.key != 'cookie'}">
                <dt>${item.key}</dt>
                <dd>${item.value}</dd>
            </c:if>
        </c:forEach>
        </dl>
    </div>        
</div>

<p>&nbsp;</p>

<div id="infoDiv">
    <div class="fr">
        <label id="toggleCookie" class="arrow-show" onclick="jsToggle($('#toggleCookie'), $('#cookieDl'));">보기</label>
    </div>
    <strong class="br-green">쿠키 정보</strong>  
    <div id="cookieDl" style="max-height:250px; overflow: auto;" class="sm-info-div-line">
        <dl>
        <c:forEach var="item" items="${cookie}">
            <dt>${item.key}</dt>
            <dd>${item.value}</dd>
        </c:forEach>
        </dl>
    </div>        
</div>
