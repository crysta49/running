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
    <%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
    <%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>
    <%@ page import="org.apache.commons.lang3.exception.ExceptionUtils"%>
    
    <sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>
    
    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
    <head>
        <title>서버에서 장애가 발생했습니다.</title>
        <meta charset="utf-8"/>
        <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible"/>
        <sm:css names="salmon" />
    </head>
    
    <body>

        <div class="contents">
    
            <c:set var="__exception__" value="${requestScope['javax.servlet.error.exception']}" scope="request" />
    
            <div class="smd-err-box">
                <div class="err-icon">
                    <div class="err-image">
                        <c:if test="${CONSTANT.IS_STACK_TRACE}">
                            <div class="btn-div" style="margin: 140px 0 0 20px;">
                                <sm:button value="자세히 보기" onclick="$('#stackDiv').toggle();"/>
                            </div>
                        </c:if>
                    </div>
                </div>
                <div class="err-view">
                    <div class="err-title">JSP 파일에 문제가 있습니다.</div>
                    <div class="err-title-small">본 장애는 JSP 파일의 형식이나 문법에 문제가 있을 경우 발생하는 장애입니다.</div>
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

                    <div class="blank"></div>
                    
                    <c:if test="${CONSTANT.IS_STACK_TRACE and not empty __exception__}">
                        <%-- {__exception__} --%>
                        <div id="stackDiv" class="hidden">
                            <table class="tbl-header">
                                <tr>
                                    <th><span class="title-big">장애 상세정보</span></th>
                                    <td class="tr"></td>
                                </tr>
                            </table>
                            <table class="tbl-view">
                                <tr>
                                    <td class="stack">
                                        <pre name="code" class="java"><%= ExceptionUtils.getStackTrace((Throwable)request.getAttribute("__exception__")) %></pre>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </c:if>
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

        <sm:js names="jquery, syntaxhighlighter" />
        <script type="text/javascript">
            $().ready(function() {
                dp.SyntaxHighlighter.HighlightAll("code", false, false, false, false);
                $(".dp-highlighter").height(300);
            });
        </script>
    
    </body>
    </html>
<% } %>