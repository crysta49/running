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
    <sm:css names="font-awesome, salmon, syntaxhighlighter" />
</head>

<body>

<c:choose>
    <c:when test="${__lostSession__}">
    
        <script type="text/javascript">
            alert("<spring:message code="${MESSAGE.BASE_LOGIN_REQUIRE_KEY}" />\n\n※ ${__timeout__}분 동안 요청이 없을 경우 자동 소멸됩니다.");
            top.location.href = "<c:url value="/login"/>";
        </script>
        
    </c:when>
    <c:otherwise>

        <div class="contents">
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
                    <div class="err-title"><sm:xss value="${__title__}"/></div>
                    <div class="err-title-small">본 장애는 서버단에서 요청을 처리하는 도중 발생한 장애 입니다.</div>
                    
                    <c:if test="${not empty requestScope[CONSTANT.GLOBAL_EXCEPTION_KEY]}">
                        <%-- TODO : 알수없는 에러 발생 시 에러 객체 --%>
                        <div class="emphasis"><sm:xss value="${requestScope[CONSTANT.GLOBAL_EXCEPTION_KEY]}"/></div>
                    </c:if>
                    
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
                        <%--
                        <c:if test="${not empty __error_info__}">
                            <tr>
                                <th>추가정보</th><td>${__error_info__}</td>
                            </tr>
                        </c:if> --%>
                        <c:if test="${not empty __exception__}">
                            <tr>
                                <th>장애제목</th><td><sm:xss value="${__exception__}"/></td>
                            </tr>
                        </c:if>
                    </table>
                    
                    <div class="blank"></div>
                    
                    <c:if test="${CONSTANT.IS_STACK_TRACE and not empty __stackTrace__}">
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
                                        <c:if test="${fn:length(__stackTrace__) <= 13000}">
                                            <pre name="code" class="java"><sm:xss value="${__stackTrace__}" /></pre>
                                        </c:if>
                                        <c:if test="${fn:length(__stackTrace__) > 13000}">
                                            <div style="padding: 6px; height: 280px; overflow: auto;">
                                                <span class="emphasis">에러 내용의 크기가 커서 코드 색상변환(Highlight) 없이 내용만 출력합니다.</span>
                                                <pre><sm:xss value="${__stackTrace__}" /></pre>
                                            </div>
                                        </c:if>
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
        
    </c:otherwise>
</c:choose>

</body>
</html>