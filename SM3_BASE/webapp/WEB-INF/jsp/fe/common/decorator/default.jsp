<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="Constant" clazz="com.srpost.salmon.constant.Constant"/>
<c:set var="userSession" value="${sessionScope[Constant.USER_SESSION_KEY]}"/>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
    <title><sitemesh:write property="title"/> : ${Constant.SYSTEM_NM}</title>
    <meta charset="utf-8"/>
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible"/>
    <meta name="robots" content="noindex, nofollow">
    <%-- <meta http-equiv="expires" content="-1">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache"> --%>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/front/FE/css/style.css"/>" />
    <sm:css names="qtip2" />
    <sm:js names="core, jquery, qtip2" />
    <script type="text/javascript" src="<c:url value="/resources/front/FE/js/jquery.salmon.front-3.0.js"/>"></script>
    <sitemesh:write property="head"/>
</head>

<body>

<%--
    1. 최상단 메뉴 목록   : topMenuList
    2. 전체 메뉴 목록      : allMenuList
    3. 현재 페이지 빈      : currentMenuBean
    4. 현재 위치             : locList
    5. 현재페이지 담당자 : currentMgrBean
--%>

<table>
    <tr>
        <td>
            <div id="gnbMenu">
                <%--  
                * 1레벨 메뉴 목록  
                --%>
                <c:if test="${not empty topMenuList}">
                    <div>
                        <ul style="list-style: none; margin: 0; padding: 13px; height: 16px;">
                            <li style="float: left; margin-right: 12px;">
                                <a href="<c:url value="/front"/>">HOME</a>
                            </li>
                        <c:forEach items="${topMenuList}" var="item">
                            <li style="float: left; margin-right: 12px;" class="<sm:loc locList="${locList}" menuCd="${item.menuCd}"/>">
                                <c:if test="${not empty item.menuUrl }">
                                    <a href="<c:url value="${item.menuUrl}"/>">${item.menuNm}</a>
                                </c:if>
                                <c:if test="${empty item.menuUrl }">
                                    ${item.menuNm}
                                </c:if>
                            </li>
                        </c:forEach>
                        </ul>
                    </div>
                </c:if>
                <c:if test="${empty topMenuList}">
                    <div>고객단 메뉴 정보를 등록하세요.</div>
                </c:if>
                
                <%--  
                * 2레벨 이하 메뉴 목록 설정 (top) 
                --%>
                <c:if test="${not empty allMenuList}">
                    <div id="subMenu" style="display: none; border: 1px solid #000; height: 66px; background-color: #fff;
                        padding: 8px; position: absolute; top: 50px; left: 20px">
                        <c:forEach items="${allMenuList}" var="item" varStatus="index">
                            <ul style="float: left; margin: 0; padding: 0; margin-left: 60px">
                            <c:forEach items="${item.children}" var="item2">
                                <li class="<sm:loc locList="${locList}" menuCd="${item2.menuCd}"/>">
                                    <c:if test="${not empty item2.menuUrl}">
                                        <a href="<c:url value="${item2.menuUrl}"/>">${item2.menuNm}</a>
                                    </c:if>
                                    <c:if test="${empty item2.menuUrl}">
                                        <span>${item2.menuNm}</span>
                                    </c:if>
                                </li>
                            </c:forEach>
                            </ul>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </td>
        <td style="text-align: right; width: 300px">
            <%--  
            * 로그인 정보 표시
            --%>
            <c:if test="${not empty userSession}">
                <span>${userSession.userNm}님 접속중</span> 
                <a href="<c:url value="/fe/login/NR_logoutAction.do"/>">로그아웃</a>
            </c:if>
            <c:if test="${empty userSession}">
                <a href="<c:url value="/fe/login/NR_index.do"/>">로그인</a>
            </c:if>
        </td>
    </tr>
</table>    
<table style="margin-top: 15px;">    
    <tr>
        <td colspan="2" style="text-align: right;">
            <%--  
            * 현재 위치 
            --%>
            <div style="">현재위치 : <a href="<c:url value="/front"/>">HOME</a> / 
                <c:if test="${empty locList}"><sitemesh:write property="title"/></c:if>
                <c:if test="${not empty locList}">
                    <c:forEach items="${locList}" var="item" varStatus="index">
                        <c:if test="${!index.last}">
                            <c:if test="${not empty item.menuUrl}">
                                <a href="<c:url value="${item.menuUrl}"/>">${item.menuNm}</a>
                            </c:if>
                            <c:if test="${empty item.menuUrl}">
                                ${item.menuNm}
                            </c:if> /
                        </c:if>
                        <c:if test="${index.last}">
                            <b>${item.menuNm}</b>
                        </c:if>
                    </c:forEach>
                </c:if>
            </div>
        </td>
    </tr>
</table>    
<table style="margin-top: 15px;">   
    <tr>
        <%-- 
        * 2레벨 이하 메뉴 목록 설정 (left) 
        --%>
        <td style="vertical-align: top; width: 180px;">
            <c:if test="${not empty allMenuList}">
                <c:forEach items="${allMenuList}" var="item1" varStatus="index">
                    <c:if test="${not empty item1.menuUrl }">
                        <div class="<sm:loc locList="${locList}" menuCd="${item1.menuCd}" />"><a href="<c:url value="${item1.menuUrl}"/>">${item1.menuNm}</a></div>
                    </c:if>
                    <c:if test="${empty item1.menuUrl }">
                        <div class="<sm:loc locList="${locList}" menuCd="${item1.menuCd}" />">${item1.menuNm}</div>
                    </c:if>
                    <ul style="">
                    <c:forEach items="${item1.children}" var="item2">
                        <li class="<sm:loc locList="${locList}" menuCd="${item2.menuCd}" />">
                            <c:if test="${not empty item2.menuUrl}">
                                <a href="<c:url value="${item2.menuUrl}"/>">${item2.menuNm}</a>
                            </c:if>
                            <c:if test="${empty item2.menuUrl}">
                                <span>${item2.menuNm}</span>
                            </c:if>
                            <ul>
                            <c:forEach items="${item2.children}" var="item3">
                                <li class="<sm:loc locList="${locList}" menuCd="${item3.menuCd}" />">
                                    <c:if test="${not empty item3.menuUrl}">
                                        <a href="<c:url value="${item3.menuUrl}"/>">${item3.menuNm}</a>
                                    </c:if>
                                    <c:if test="${empty item3.menuUrl}">
                                        <span>${item3.menuNm}</span>
                                    </c:if>
                                </li>
                            </c:forEach>
                            </ul>
                        </li>
                    </c:forEach>
                    </ul>
                </c:forEach>
            </c:if>
        </td>
        <td style="vertical-align: top; padding: 10px;">
            <sitemesh:write property="body"/>
        </td>
    </tr>
    <c:if test="${not empty currentMgrBean}">
        <tr>
            <td colspan="2" style="text-align: right;">
                <%-- 
                * 현재 페이지 담당자 정보 및 만족도 조사 
                --%>
                <div>페이지 담당자 : ${currentMgrBean.deptNm}/${currentMgrBean.mgrNm}</div>
            </td>
        </tr>
    </c:if>
</table>

<script type="text/javascript">
    $().ready(function() {
        
        $("#gnbMenu").hover(function() {
            $("#subMenu").show().css("z-index", 10);
        }, function() {
            $("#subMenu").hide().css("z-index", -1);
        });
    });
    
</script>

</body>
</html>
