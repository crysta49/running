<%@ page contentType="text/html;charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>
<c:set var="mgrSession" value="${sessionScope[CONSTANT.MGR_SESSION_KEY]}" />

<c:forEach items="${__items__}" var="item">
    <c:choose>
        
        <c:when test="${item == 'nanum-gothic'}">
            <link rel="stylesheet" type="text/css" href="<c:url value="/resources/spi/nanum-gothic/nanumgothic.css"/>" />
        </c:when>
        
        <c:when test="${item == 'extjs'}">
            <link rel="stylesheet" type="text/css" href="<c:url value="/resources/spi/extjs/packages/"/>ext-theme-${CONSTANT.EXTJS_THEME}/build/resources/ext-theme-${CONSTANT.EXTJS_THEME}-all.css">
        </c:when>
        
        <c:when test="${item == 'bootstrap'}">
            <link rel="stylesheet" href="<c:url value="/resources/spi/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>" />
        </c:when>
        
        <c:when test="${item == 'salmon'}">
            <link rel="stylesheet" type="text/css" href="<c:url value="/resources/spi/nanum-gothic/nanumgothic.css"/>" />
            <link rel="stylesheet" type="text/css" href="<c:url value="/resources/spi/jquery/nprogress/nprogress.css"/>" />
            <link rel="stylesheet" type="text/css" href="<c:url value="/resources/spi/jquery/ui.tabs/jquery-ui.min.css"/>" />
            <link rel="stylesheet" type="text/css" href="<c:url value="/resources/base/css/fm.css"/>" />
            <%--
            <link rel="stylesheet" type="text/css" href="<c:url value="/resources/base/css/global.css"/>" />
            <link rel="stylesheet" type="text/css" href="<c:url value="/resources/base/css/main/main.css"/>" />
            <link rel="stylesheet" type="text/css" href="<c:url value="/resources/base/css/main/menu-icon.css"/>" />
            <link rel="stylesheet" type="text/css" href="<c:url value="/resources/base/theme/${empty mgrSession.theme ? CONSTANT.THEME : mgrSession.theme}/main.css"/>" />
            --%>
        </c:when>
        
        <c:when test="${item == 'font-awesome'}">
            <link rel="stylesheet" type="text/css" href="<c:url value="/resources/spi/font-awesome/css/font-awesome.min.css"/>" />
        </c:when>
        
        <c:when test="${item == 'qtip2'}">
            <link rel="stylesheet" type="text/css" href="<c:url value="/resources/spi/jquery/qtip2/jquery.qtip.css"/>" />
        </c:when>
        
        <c:when test="${item == 'syntaxhighlighter'}">
            <link rel="stylesheet" type="text/css" href="<c:url value="/resources/spi/syntax-highlighter/Styles/SyntaxHighlighter.css"/>" />
        </c:when>
    </c:choose>
</c:forEach>
