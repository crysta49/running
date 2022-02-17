<%
if ( com.srpost.salmon.lang.WebUtil.isAjaxRequest(request) ) {
    
    response.setContentType("text/plain;charset=utf-8");
    
    out.println("파일을 찾을 수 없습니다.");
    out.println(request.getAttribute("javax.servlet.forward.request_uri"));
    
    return;
}
else {
%>
    <%@ page contentType="text/html;charset=utf-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

    <c:set var="isPopup" value="${fn:indexOf(requestScope['javax.servlet.forward.request_uri'], 'p_') != -1}" />
    
    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
    <head>
        <title>페이지를 찾을 수 없습니다.</title>
        <meta charset="utf-8"/>
        <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible"/>
        <sm:css names="bootstrap, salmon" />
        <link rel="stylesheet" type="text/css" href="<c:url value="/resources/base/css/error.css"/>" />
        <sm:js names="jquery" />
    </head>
    
    <body style="margin: 0;">
    
        <div class="container ${isPopup ? 'container-popup' : ''} align-middle">
            <div class="jumbotron ${isPopup ? 'jumbotron-popup' : ''}">
                <h2>페이지를 찾을 수 없습니다.</h2>
                <p class="text-info">해당 페이지의 경로가 변경되었거나, 서버에 존재하지 않습니다.</p>
                <p class="text-info">파일의 경로가 정확한지 URL주소를 바르게 입력했는지 확인해주세요.</p>
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

    </body>
    </html>
<% } %>