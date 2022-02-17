<%
if ( com.srpost.salmon.lang.WebUtil.isAjaxRequest(request) ) {
    
    response.setContentType("text/plain;charset=utf-8");
    
    out.println("에러가 발생했습니다.");
    out.println(request.getAttribute("javax.servlet.error.exception"));
    
    return;
}
else {
%> 
    <%@ page contentType="text/html;charset=utf-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>
    
    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
    <head>
        <title>서버에서 장애가 발생했습니다.</title>
        <meta charset="utf-8"/>
        <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible"/>
        <style type="text/css">
            html { background: none; }
        </style>
    </head>
    
    <body>

        <div id="error">
            <h1>서버에서 장애가 발생했습니다.</h1>
            <c:if test="${not empty requestScope['javax.servlet.forward.request_uri']}">
                <h2><sm:xss value="${requestScope['javax.servlet.forward.request_uri']}"/></h2>
            </c:if>
            <h3>본 장애는 UI 파일의 형식이나 문법에 문제가 있을 경우 발생하는 장애입니다.</h3>
        </div>
    
    </body>
    </html>
<% } %>