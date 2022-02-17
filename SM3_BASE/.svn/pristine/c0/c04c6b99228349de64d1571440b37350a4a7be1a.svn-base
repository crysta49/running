<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <style type="text/css">
        html { background: none; }
    </style>
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

        <div id="error">
            <h1>${__title__}</h1>
            <c:if test="${not empty requestScope['javax.servlet.forward.request_uri']}">
                <h2><sm:xss value="${requestScope['javax.servlet.forward.request_uri']}"/></h2>
            </c:if>
            <h3>본 장애는 서버단에서 요청을 처리하는 도중 발생한 장애 입니다.</h3>
        </div>
        
    </c:otherwise>
</c:choose>

</body>
</html>