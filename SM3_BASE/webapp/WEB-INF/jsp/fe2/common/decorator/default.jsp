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
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/front/FE2/css/style.css"/>" />
    <sm:js names="core, jquery, highlight" />
    <script type="text/javascript" src="<c:url value="/resources/front/FE2/js/jquery.modal.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/front/FE2/js/jquery.slides.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/front/FE2/js/jquery.countdown.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/front/FE2/js/countdown.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/front/FE2/js/jquery.printElement.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/front/FE2/js/jquery.mb.browser.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/front/FE2/js/jquery.highlight-4.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/front/FE2/js/front.js"/>"></script>
    <sitemesh:write property="head"/>
    <script type="text/javascript">
        function jsPrint(){
            $("#content").printElement({
                printMode: 'popup', 
                overrideElementCSS : [
                    '<c:url value="/resources/front/FE2/css/print.css"/>', 
                    {href: '<c:url value="/resources/front/FE2/css/print.css"/>', media: 'print'}                              
                ],
                leaveOpen: false // 인쇄 후 창닫기
            });
        };
    </script>
</head>
 
<body> 

<c:set var="isModal" value="${fn:indexOf(requestScope['javax.servlet.forward.request_uri'], 'PR_') != -1}" />

<div id="wrap" class="${isModal ? 'contents-modal' : 'contents'}">

    <c:import url="/WEB-INF/jsp/fe2/common/decorator/incHeader.jsp" charEncoding="UTF-8"/>
    
    <!--서브-->
   <div id="sub">

        <!--본문-->
        <div id="scontainer">
            <c:if test="${menuKey == 'faq'}">
                <c:set value="자주하는 질문" var="_subTitle"/>
                <c:set value="01" var="_imgName"/>
            </c:if>
            <c:if test="${menuKey == 'voc1' || menuKey == 'voc_1'}">
                <c:set value="질의응답 VOC" var="_subTitle"/>
                <c:set value="02" var="_imgName"/>
            </c:if>
            <c:if test="${menuKey == 'voc2' || menuKey == 'voc_2'}">
                <c:set value="불평불만신고" var="_subTitle"/>
                <c:set value="03" var="_imgName"/>
            </c:if>
            <c:if test="${menuKey == 'voc3' || menuKey == 'voc_3'}">
                <c:set value="부정비리신고" var="_subTitle"/>
                <c:set value="04" var="_imgName"/>
            </c:if>
            <c:if test="${menuKey == 'voc4' || menuKey == 'voc_4'}">
                <c:set value="고객제안" var="_subTitle"/>
                <c:set value="05" var="_imgName"/>
            </c:if>
            <c:if test="${menuKey == 'bbs3' || menuKey == 'bbs_3'}">
                <c:set value="칭찬격려" var="_subTitle"/>
                <c:set value="06" var="_imgName"/>
            </c:if>
            <c:if test="${menuKey == 'info'}">
                <c:set value="이용안내" var="_subTitle"/>
                <c:set value="01" var="_imgName"/>
            </c:if>
            <%-- <c:if test="${menuKey == 'service'}">
                <c:set value="찾아가는 서비스" var="_subTitle"/>
                <c:set value="중소기업상담" var="_subLocation"/>
                <c:set value="01" var="_imgName"/>
            </c:if> --%>
            <c:if test="${menuKey == 'bbs2'}">
                <c:set value="공지사항" var="_subTitle"/>
                <c:set value="01" var="_imgName"/>
            </c:if>
            <c:if test="${menuKey == 'myvoc'}">
                <c:set value="나의 소리함" var="_subTitle"/>
                <c:set value="01" var="_imgName"/>
            </c:if>
            <c:if test="${menuKey == 'login'}">
                <c:set value="본인인증" var="_subTitle"/>
                <c:set value="01" var="_imgName"/>
            </c:if>    
            <c:if test="${menuKey == 'search'}">
                <c:set value="통합검색" var="_subTitle"/>
                <c:set value="01" var="_imgName"/>
            </c:if>
            
            <h2 class="tit">${_subTitle}</h2>
            <p class="svisual"><img src="<c:url value="/resources/front/FE2/images/svisual_01.gif"/>" alt="" /></p>
            <p class="location">
                <span><img src="<c:url value="/resources/front/FE2/images/location_home.gif"/>" alt="홈" /></span>
                 홈 &gt; <c:if test="${menuKey == 'service'}">${_subLocation} &gt; </c:if>${_subTitle}
            </p>
            
            <p class="sub_print"><a href="#" onclick="jsPrint(); return false;"><img src="<c:url value="/resources/front/FE2/images/sub_bt_print.gif"/>" alt="프린트" /></a></p>
            
            <!--컨텐츠-->
            <div id="content">
                <sitemesh:write property="body"/>
            </div>
        </div>
        
        <!-- 오른쪽 고정 메뉴 -->
        <div class="sub_right">
            <ul class="right_banner">
                <li class="r1"><a href="#" onclick="SM.link('info'); return false;" title="이용안내">이용안내</a></li>
                <!-- <li class="r2"><a href="#" onclick="SM.link('service');" title="찾아가는 서비스">찾아가는 서비스</a></li> -->
                <li class="r3"><a href="#" onclick="SM.link('bbs2'); return false;" title="공지사항">공지사항</a></li>
            </ul>
            
            <!-- ARS 콜센터 -->
            <div class="right_call">
                <p class="ars_tit">ARS 콜센터</p>
                <ul>
                    <li class="ars_stit">일반문의</li>
                    <li class="tel">1588-0000</li>
                    <li class="ars_stit">기업고객전용</li>
                    <li class="tel">1588-0001</li>
                </ul>
                <p class="time">
                    평일 09:00~18:00<br />
                    점심 12:00~13:00
                </p>
            </div>
        </div>
        
    </div>

    <c:import url="/WEB-INF/jsp/fe2/common/decorator/incFooter.jsp" charEncoding="UTF-8"/>
    
</div>

<script type="text/javascript">
    $().ready(function() {
        
        <c:if test="${not empty userSession}">
        setTimeout("SM.goHome();",  1000 * 60 * 30);
        </c:if>
    });
    
</script>

</body>
</html>
