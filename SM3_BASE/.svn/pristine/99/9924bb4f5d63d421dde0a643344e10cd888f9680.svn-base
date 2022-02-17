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
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
    <%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>
    
    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
    <head>
        <title>페이지를 찾을 수 없습니다.</title>
        <meta charset="utf-8"/>
        <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible"/>
        <sm:css names="font-awesome, salmon" />
    </head>
    
    <body>

        <div class="contents">
    
            <div class="smd-err-box">
                <div class="err-icon">
                    <div class="err-image"></div>
                </div>
                <div class="err-view">
                    <div class="err-title">페이지를 찾을 수 없습니다.</div>
                    <div class="err-title-small">본 장애는 요청하신 페이지가 서버에 존재하지 않을 경우 발생한 장애 입니다.</div>
                    <table class="tbl-view">
                        <colgroup>
                            <col class="th">
                            <col>
                        </colgroup>
                        <c:if test="${not empty requestScope['javax.servlet.forward.request_uri']}">
                            <tr>
                                <th>요청주소</th><td><sm:xss value="${requestScope['javax.servlet.forward.request_uri']}"/></td>
                            </tr>
                        </c:if>
                        <c:if test="${not empty requestScope['javax.servlet.forward.query_string']}">
                            <tr>
                                <th>요청인자</th><td><sm:xss value="${requestScope['javax.servlet.forward.query_string']}"/></td>
                            </tr>
                        </c:if>
                    </table>
                    <div>
                        <ul class="bullet">
                            <li>해당 페이지는 경로가 변경되었거나, 서버에 존재하지 않습니다.</li>
                            <li>파일의 경로가 정확한지 URL주소를 바르게 입력했는지 확인해주세요.</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        
        <%--
        <hr/>
        
        <ul>
            <c:forEach var="name" items="${pageContext.request.attributeNames}">
                <li><span class='bold'>${name}</span> : <span class='emphasis'>${requestScope[name]}</span></li>
            </c:forEach>
        </ul> --%>
    
    </body>
    </html>
<% } %>