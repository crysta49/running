<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>
<sm:static var="MESSAGE" clazz="com.srpost.salmon.constant.Message"/>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
    <title>서버에서 장애가 발생했습니다.</title>
    <meta charset="utf-8"/>
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible"/>
    <sm:css names="bootstrap, salmon" />
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/base/css/error.css"/>" />
    <sm:js names="jquery" />
</head>

<body style="margin: 0;">

<c:choose>
    <c:when test="${__lostSession__}">
    
        <script type="text/javascript">
            alert("<spring:message code="${MESSAGE.BASE_LOGIN_REQUIRE_KEY}" />\n\n※ ${__timeout__}분 동안 요청이 없을 경우 자동 소멸됩니다.");
            top.location.href = "<c:url value="/login"/>";
        </script>
        
    </c:when>
    <c:otherwise>
        
        <c:set var="isPopup" value="${fn:indexOf(requestScope['javax.servlet.forward.request_uri'], 'p_') != -1}" />
        
        <div class="container ${isPopup ? 'container-popup' : ''} align-middle">
            <div class="jumbotron ${isPopup ? 'jumbotron-popup' : ''}">
                <h2>서버에서 장애가 발생했습니다.</h2>
                <p class="text-danger"><sm:xss value="${__title__}"/></p>
                <p class="text-info">서버단에서 요청을 처리하는 도중 발생한 장애 입니다.</p>
                <%--
                <ul class="bullet">
                    <c:if test="${not empty requestScope['javax.servlet.forward.request_uri']}">
                        <li><sm:xss value="${requestScope['javax.servlet.forward.request_uri']}"/></li>
                    </c:if>
                    <c:if test="${not empty requestScope['javax.servlet.forward.query_string']}">
                        <li><sm:xss value="${requestScope['javax.servlet.forward.query_string']}"/></li>
                    </c:if>
                </ul> --%>
                <div class="well"><span class="text-danger" id="timerText">5</span> 초 후 <strong>이전 페이지</strong>로 이동합니다.</div>
                <sm:button-layout align="center">
                    <sm:button value="이전 페이지로 이동" cssClass="btn-primary" btnSize="btn-md" onclick="js_back();" />
                </sm:button-layout>
            </div>
        </div>
    
        <script type="text/javascript">
            $(function() {
                var seconds = 5, done = false;
                
                function runTimer() {
                    if (done) return;
                    seconds--;
                    $("#timerText").text(seconds);
                    if (seconds < 1) {
                        done = true;
                        js_back();
                    }
                    setTimeout(runTimer, 1000);
                }
                
                runTimer();  
            });
            
            var js_back = function() {
                ${isPopup ? 'SM.modalClose();' : 'history.back();'}  
            };
        </script>
    </c:otherwise>
</c:choose>

</body>
</html>