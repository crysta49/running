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
    <%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>
    
    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
    <head>
        <title>페이지를 찾을 수 없습니다.</title>
        <meta charset="utf-8"/>
        <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/resources/front/FE/css/style.css"/>" />
        <style type="text/css">
            html { background: none; }
        </style>
    </head>
    
    <body>

        <div id="error">
            <h1>페이지를 찾을 수 없습니다.</h1>
            <c:if test="${not empty requestScope['javax.servlet.forward.request_uri']}">
                <h2><sm:xss value="${requestScope['javax.servlet.forward.request_uri']}"/></h2>
            </c:if>
            <h3>본 장애는 요청하신 페이지가 서버에 존재하지 않을 경우 발생한 장애 입니다.</h3>
            
            <h1>※ 본 에러 페이지를 납품하는 사이트 디자인에 맞게 수정하세요.</h1>
        </div>
    
    </body>
    </html>
<% } %>