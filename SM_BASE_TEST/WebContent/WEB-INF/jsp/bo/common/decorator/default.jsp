<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>
<c:set var="mgrSession" value="${sessionScope[CONSTANT.MGR_SESSION_KEY]}" />

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
    <meta charset="utf-8"/>
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible"/>
    <title><sitemesh:write property="title"/> : ${CONSTANT.SYSTEM_NM}</title>
    <meta name="robots" content="noindex, nofollow" />
    <%-- <meta http-equiv="expires" content="-1">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache"> --%>
    <sm:css names="extjs, bootstrap, salmon, qtip2" />
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <c:if test="${CONSTANT.IS_DEV_MODE}">
        <sm:js names="jsencrypt"/>
    </c:if>
        <sm:js names="core, jquery, extjs, bootstrap, salmon, qtip2" />
    <sitemesh:write property="head"/>
</head>

<body class="srm">

<div class="row sr-top f-11">
    <div class="container sr-container">
        <div class="row">
            <div class="col-xs-8">
                <span style="color: #fff" data-toggle="tooltip" data-placement="bottom"
                    title="<c:forEach items="${mgrSession.authList}" var="item" varStatus="status">${item.authNm}${status.last ? '' : ', '} </c:forEach>">
                    ${mgrSession.mgrNm}(${mgrSession.mgrId})
                </span>님 접속중

                <c:if test="${not empty mgrSession.mgrAbsenceBean}">&nbsp;
                    <span class="label label-danger">${mgrSession.mgrAbsenceBean.agencyNm}님이 대리 접속</span>
                </c:if>

                <c:if test="${not empty mgrSession.handOverList}">
                    <div class="handover-link">
                        <span class="handover-menu"><i class="glyphicon glyphicon-bell"></i> 대리업무가 있습니다</span>
                        <div id="handover-pop">
                            <div class="content">
                                <p>
                                    ${mgrSession.mgrNm}님을 업무대리인으로 지정한 직원이 있습니다.
                                    <br/>아래 직원명을 클릭하시면 해당 직원으로 로그인 후 대리해서 업무처리를 진행할 수 있습니다.
                                </p>
                                <c:forEach items="${mgrSession.handOverList}" var="item">
                                    <a href="#" onclick="js_handOverLogin('${item.mgrId}', '${item.mgrNm}'); return false;"><span class="label label-primary">${item.mgrNm}</span></a>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
            <div class="col-xs-4 sr-qmenu">
                <c:if test="${empty mgrSession.mgrAbsenceBean}">
                    <div class="mypage-link">
                        <a href="#"><i class="glyphicon glyphicon-user"></i> 마이페이지</a>
                        <div id="mypage-pop">
                            <div class="title">${mgrSession.mgrNm}님 안녕하세요.</div>
                            <div class="content">
                                <img src="<c:url value="${mgrSession.photo}"/>" class="photo" />
                                <ul>
                                    <c:forEach items="${mpList}" var="item">
                                        <li class="${curMenuBean.menuCd == item.menuCd ? 'active' : ''}">
                                            <a href="<c:url value="${item.menuUrl}"/>">${item.menuNm}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </c:if>
                <div>
                    <a href="<c:url value="/bo/base/login/NR_logoutAction.do"/>"><i class="glyphicon glyphicon-log-out"></i> 로그아웃</a>
                </div>
                <div class="tot-menu-link">
                    <a href="#"><i class="glyphicon glyphicon-menu-hamburger"></i> 전체메뉴</a>
                    <div id="tot-menu-pop">
                        <div class="title"><i class="glyphicon glyphicon-menu-hamburger"></i> 전체메뉴</div>
                        <div class="content" style="width: ${fn:length(topList)*165}px;">
                            <c:forEach items="${topList}" var="item" varStatus="status">
                                <%-- 1 Depth --%>
                                    <ul class="lvl01">
                                    <c:if test="${empty item.children}">
                                        <li class="gnb_${item.menuCd} status_${status.count} text-overflow">
                                            <a href="<c:url value="${item.menuUrl}"/>">${item.menuNm}</a>
                                        </li>
                                    </c:if>
                                    <c:if test="${not empty item.children}">
                                        <%-- 2 Depth --%>
                                        <li class="gnb_${item.menuCd} status_${status.count} text-overflow">
                                            <a class="">${item.menuNm}</a>
                                            <ul class="lvl02">
                                                <c:forEach items="${item.children}" var="subItem">
                                                    <c:if test="${empty subItem.children}">
                                                        <li class="gnb_${subItem.menuCd}">
                                                            <a href="<c:url value="${subItem.menuUrl}"/>">${subItem.menuNm}</a>
                                                        </li>
                                                    </c:if>
                                                    <c:if test="${not empty subItem.children}">
                                                        <%-- 3 Depth --%>
                                                        <li class="gnb_${subItem.menuCd} text-overflow">
                                                            <a class="">${subItem.menuNm}</a>
                                                            <ul class="">
                                                                <c:forEach items="${subItem.children}" var="finalItem">
                                                                    <li class="gnb_${finalItem.menuCd} text-overflow">
                                                                        <a href="<c:url value="${finalItem.menuUrl}"/>">${finalItem.menuNm}</a>
                                                                    </li>
                                                                </c:forEach>
                                                            </ul>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                    </c:if>
                                    </ul>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row sr-top sr-nav">
    <div class="container sr-container">
        <div class="row">
            <div class="col-xs-9">
                <div class="sr-logo">
                    <a href="<c:url value="/explorer"/>"><img src="<c:url value="/resources/common/logo.png"/>" /></a>
                </div>
                <ul class="tmenu f-14">
                    <c:forEach items="${topList}" var="item">
                        <%-- 1 Depth --%>
                        <c:if test="${empty item.children}">
                            <li class="gnb_${item.menuCd}">
                                <a href="<c:url value="${item.menuUrl}"/>">${item.menuNm}</a>
                            </li>
                        </c:if>
                        <c:if test="${not empty item.children}">
                            <%-- 2 Depth --%>
                            <li class="dropdown gnb_${item.menuCd}">
                                <a class="dropdown-toggle" data-toggle="dropdown"
                                   aria-expanded="false">${item.menuNm} <span class="caret"></span></a>
                                <ul class="dropdown-menu f-12">
                                    <c:set var="childMenuSize" value="${fn:length(item.children)}"/>
                                    <c:forEach items="${item.children}" var="subItem" varStatus="status">
                                        <c:if test="${empty subItem.children}">
                                            <li class="gnb_${subItem.menuCd}">
                                                <a href="<c:url value="${subItem.menuUrl}"/>">${subItem.menuNm}</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${not empty subItem.children}">
                                            <%-- 3 Depth --%>
                                            <li class="dropdown-submenu gnb_${subItem.menuCd}">
                                                <a class="">${subItem.menuNm} <span class="caret"></span></a>
                                                <ul class="dropdown-menu dropdown-final f-12">
                                                    <c:forEach items="${subItem.children}" var="finalItem">
                                                        <li class="gnb_${finalItem.menuCd}">
                                                            <a href="<c:url value="${finalItem.menuUrl}"/>">${finalItem.menuNm}</a>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </li>
                                        </c:if>
                                        <c:if test="${status.count < childMenuSize and subItem.dividerYn == 'Y'}"><li class="divider"></li></c:if>
                                    </c:forEach>
                                </ul>
                            </li>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</div>

<%--
<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>
${curMenuBean}

<div>
    <!-- 현재 위치 표시 -->
    <c:if test="${not empty locList}">
        <div class="breadcrumb-navbar">
            <div class="container">
                <ol class="breadcrumb">
                    <li><a href="<c:url value="/explorer"/>">HOME</a></li>
                    <c:forEach items="${locList}" var="item">
                        <c:if test="${curMenuBean.menuCd != item.menuCd}">
                            <li><a href="${empty item.menuUrl ? '#' : item.menuUrl}">${item.menuNm}</a></li>
                        </c:if>
                        <c:if test="${curMenuBean.menuCd == item.menuCd}">
                            <li class="active">${item.menuNm}</li>
                        </c:if>
                    </c:forEach>
                </ol>
            </div>
        </div>
    </c:if>
</div>

<c:import url="/WEB-INF/jsp/bo/common/include/incAuth.jsp" charEncoding="UTF-8"/>

<c:import url="/WEB-INF/jsp/bo/common/include/incDebug.jsp" charEncoding="UTF-8"/> --%>

<div class="container ct-container">

    <%-- 서브 메뉴 탭 표시 --%>
    <c:if test="${not empty subList}">
        <div class="row">
            <div class="col-xs-2 sr-left-area">
                <c:forEach items="${locList}" var="item" varStatus="status">
                    <c:if test="${status.count == 1}">
                        <c:set var="topMenuBean" value="${item}" />
                    </c:if>
                </c:forEach>
                <div class="smenu-top text-overflow f-bold f-18">
                    <span>${topMenuBean.menuNm}</span>
                </div>
                <ul class="nav nav-pills nav-stacked smenu">
                    <c:forEach items="${subList}" var="item">

                        <c:if test="${empty item.children}">
                            <li class="gnb_${item.menuCd} f-14">
                                <a href="<c:url value="${item.menuUrl}"/>">${item.menuNm}</a>
                            </li>
                        </c:if>
                        <c:if test="${not empty item.children}">
                            <li class="dropdown gnb_${item.menuCd} f-14">
                                <a class="dropdown-toggle" data-toggle="dropdown">${item.menuNm} <span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <c:forEach items="${item.children}" var="subItem">
                                        <li class="gnb_${subItem.menuCd} f-14">
                                            <a href="<c:url value="${subItem.menuUrl}"/>">${subItem.menuNm}</a>
                                        </li>
                                        <!-- <li role="separator" class="divider"></li> -->
                                    </c:forEach>
                                </ul>
                            </li>
                        </c:if>
                    </c:forEach>
                </ul>

                <c:if test="${topMenuBean.menuCd != 7}">
                    <div class="sr-short-box">
                        <div class="row">
                            <div class="col-xs-8 s-title f-bold f-15">최근 등록 FAQ</div>
                            <div class="col-xs-4 text-right more f-11"><a href="<c:url value="/bo/base/faq/core/NR_index.do"/>">더보기 &nbsp;<i class="glyphicon glyphicon-plus"></i></a></div>
                        </div>
                        <div class="sr-short-list">
                            <ul id="faqList">
                            </ul>
                        </div>
                    </div>
                </c:if>
            </div>
            <div class="col-xs-10 sr-main-area">
                <div class="page-header f-serif">
                    <h2><sitemesh:write property="title"/> <small class="f-14"><sitemesh:write property="meta.title"/></small></h2>
                    <!-- 현재 위치 표시 -->
                    <c:if test="${not empty locList}">
                        <ol class="breadcrumb">
                            <li><i class="glyphicon glyphicon-home"></i></li>
                            <c:forEach items="${locList}" var="item">
                                <c:if test="${curMenuBean.menuCd != item.menuCd}">
                                    <li>${item.menuNm}</li>
                                </c:if>
                                <c:if test="${curMenuBean.menuCd == item.menuCd}">
                                    <li class="active">${item.menuNm}</li>
                                </c:if>
                            </c:forEach>
                        </ol>
                        <div class="clearfix"></div>
                    </c:if>
                </div>
                <!-- 데코레이션 대상 컨텐츠 표시 -->
                <sitemesh:write property="body"/>
            </div>
        </div>
    </c:if>
    <c:if test="${empty subList}">
        <!-- 데코레이션 대상 컨텐츠 표시 -->
        <sitemesh:write property="body"/>
    </c:if>
</div>

<form:form name="agencyLoginForm" method="post" cssClass="sr-hidden" target="_top">
    <input type="hidden" name="mgrId" />
</form:form>

<%-- 임시 : 빠른 로그인 --%>
<c:if test="${CONSTANT.IS_DEV_MODE}">
    <div style="position: fixed; bottom: 0px; right: 0px; z-index: 10000;">
        <c:import url="/WEB-INF/jsp/bo/common/include/incQuickLogin.jsp" charEncoding="UTF-8"/>
    </div>
</c:if>

<script type="text/javascript">

    $(document).ready(function(){

        $(".dropdown, .dropdown-submenu").hover(function() {
            $(this).addClass("open");
        }, function() {
            $(this).removeClass("open");
        });

        $('[data-toggle="tooltip"]').tooltip({
            container: "body"
        });

        $(".handover-link").hover(function() {
            $(this).children(".handover-menu").addClass("active");
            $("#handover-pop").show();
        }, function(){
            $(this).children(".handover-menu").removeClass("active");
            $("#handover-pop").hide();
        });

        $(".mypage-link").hover(function() {
            $(this).addClass("active");
            $("#mypage-pop").show();
        }, function(){
            $(this).removeClass("active");
            $("#mypage-pop").hide();
        });

        $(".tot-menu-link").hover(function() {
            $(this).addClass("active");
            $("#tot-menu-pop").show();
        }, function(){
            $(this).removeClass("active");
            $("#tot-menu-pop").hide();
        });

        js_popover();

        <c:if test="${not empty subList}">
            $("#faqList").SM_LOAD(CTX_PATH + "/bo/base/explorer/AR_faqList.do");
        </c:if>

        <c:forEach items="${locList}" var="item">
            $(".gnb_${item.menuCd}").addClass("active");
        </c:forEach>
    });


    var js_handOverLogin = function(mgrId, mgrNm) {

        if (confirm(mgrNm + "님으로 접속해서 대리업무를 처리하시겠습니까?")) {
            $("input[name=mgrId]").val(mgrId);
            $("form[name=agencyLoginForm]").attr("action", "<c:url value="/bo/base/login/NR_agencyLoginAction.do"/>").submit();
        }
    };

    var js_popover = function() {

        $('[data-toggle="popover"]').popover({
            html : true,
            placement : "top",
            trigger: "click",
            content: function(){
                var mgrId = $(this).attr("data-popover-id");
                var cpmDivId = mgrId + $.now();
                $.ajax({
                    cache: true,
                    url: CTX_PATH + "/bo/base/mgr/AR_popover.do?mgrId=" + mgrId,
                    success: function(response){
                        $("#cpm_" + cpmDivId).html(response);
                    }
                });
                return '<div id="cpm_'+ cpmDivId +'" >Loading...</div>';
            }
        }).on('shown.bs.popover', function() {
            // var $popover = $('.popover');
            // $popover.find('.arrow').css('display', 'none');
        });
    }

    var js_dateConvert = function(date) {

        return date.getFullYear() + "-" + js_numberConvert(date.getMonth()+1) + "-" + js_numberConvert(date.getDate());
    }

    var js_numberConvert = function(num) {
        num = num + '';
        return num.length < 2 ? '0' + num : num;
    }
</script>

</body>
</html>
