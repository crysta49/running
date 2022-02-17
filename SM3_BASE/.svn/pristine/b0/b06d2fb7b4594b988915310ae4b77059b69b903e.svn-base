<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>
<c:set var="userSession" value="${sessionScope[CONSTANT.USER_SESSION_KEY]}"/>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
    <title>VOC 메인 화면 - ${CONSTANT.CLIENT_NM}</title>
    <meta charset="utf-8"/>
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible"/>
    <meta name="robots" content="noindex, nofollow">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/front/FE2/css/style.css"/>" />
    <sm:js names="core, jquery" />
    <script type="text/javascript" src="<c:url value="/resources/front/FE2/js/jquery.modal.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/front/FE2/js/jquery.slides.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/front/FE2/js/jquery.countdown.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/front/FE2/js/countdown.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/front/FE2/js/front.js"/>"></script>
</head>

<body>
<div id="wrap">

    <c:import url="/WEB-INF/jsp/fe2/common/decorator/incHeader.jsp" charEncoding="UTF-8"/>
    
    <!-- 비주얼 -->
    <div id="visual">
        <div id="slides">
          <img src="<c:url value="/resources/front/FE2/images/main/visual_01.png"/>" height="195" alt="SRPOST의 고객사랑, 다섯 가지 C/S 약속으로부터 시작합니다. 우리는, 항상 공손하고 진실한 마음으로 고객님의 의견과 충고를 경청하겠습니다." />
          <img src="<c:url value="/resources/front/FE2/images/main/visual_02.png"/>" height="195" alt="SRPOST의 고객사랑, 다섯 가지 C/S 약속으로부터 시작합니다. 우리는, 최고의 서비스를 제공하기 위해 창의적인 마인드와 전문적인 능력을 갖추도록 노력하겠습니다." />
          <img src="<c:url value="/resources/front/FE2/images/main/visual_03.png"/>" height="195" alt="SRPOST의 고객사랑, 다섯 가지 C/S 약속으로부터 시작합니다. 우리는, 고객님께서 만족하고 칭찬하실 때까지 항상 웃는 얼굴로 서비스 하겠습니다." />
          <img src="<c:url value="/resources/front/FE2/images/main/visual_04.png"/>" height="195" alt="SRPOST의 고객사랑, 다섯 가지 C/S 약속으로부터 시작합니다. 우리는, 고객님과의 업무를 항상 완벽하고 빠르게 처리하겠습니다." />
          <img src="<c:url value="/resources/front/FE2/images/main/visual_05.png"/>" height="195" alt="SRPOST의 고객사랑, 다섯 가지 C/S 약속으로부터 시작합니다. 우리는, 모든 업무를 항상 투명하고 올바르게 처리하겠습니다." />
        </div>
    </div>
    
    <!-- 메인컨텐츠 -->
    <div id="main_content">
        <!-- 자주하는 질문 -->
        <div class="main_faq">
            <h2><img src="<c:url value="/resources/front/FE2/images/main/tit_faq.gif"/>" alt="한국에너지기술평가원 자주하는질문 베스트" /></h2>
            <ul>
                <c:forEach items="${faqList}" var="_bean" varStatus="status">
                    <li>
                        <span><img src="<c:url value="/resources/front/FE2/images/main/faq_${status.index +1}.gif"/>" alt="${status.index +1}" /></span>
                        <a href="<c:url value="/fe2/faq/NR_list.do"/>?seq=${_bean.seq}&amp;_m=faq"><sm:fix-length src="${_bean.title}" limit="62"/></a>
                    </li>
                </c:forEach>
                <c:if test="${empty faqList}">
                    <li>데이타가 존재하지 않습니다.</li>
                </c:if>
            </ul>
            <p class="faq_more"><a href="#" onclick="SM.link('faq'); return false;" title="자주하는질문전체보기"><img src="<c:url value="/resources/front/FE2/images/main/faq_all.gif"/>" alt="전체보기" /></a></p>
        </div>
        
        <!-- 바로가기 배너 -->
        <div class="main_banner">
            <ul class="banner_01">
                <li>
                    <p class="icon"><img src="<c:url value="/resources/front/FE2/images/main/icon_01.gif"/>" alt="" /></p>
                    <p class="tit">질의응답 VOC</p>
                    <p class="cont">상담이나 궁금하신 사항을<br />접수해 주시면 신속하게<br />답변 드리겠습니다.</p>
                    <p class="more_bt"><a href="#" onclick="SM.link('voc1'); return false;" title="질의응답 VOC 바로가기"><img src="<c:url value="/resources/front/FE2/images/main/bt_link.gif"/>" alt="바로가기" /></a></p>
                </li>
                <li>
                    <p class="icon"><img src="<c:url value="/resources/front/FE2/images/main/icon_02.gif"/>" alt="" /></p>
                    <p class="tit">불평불만신고</p>
                    <p class="cont">고객의 소리에서는<br />기업고객님을 위한 별도의<br />상담창구를 마련하였습니다. </p>
                    <p class="more_bt"><a href="#" onclick="SM.link('voc2'); return false;" title="불평불만신고 바로가기"><img src="<c:url value="/resources/front/FE2/images/main/bt_link.gif"/>" alt="바로가기" /></a></p>
                </li>
                <li class="end">
                    <p class="icon"><img src="<c:url value="/resources/front/FE2/images/main/icon_03.gif"/>" alt="" /></p>
                    <p class="tit">부정비리신고</p>
                    <p class="cont">방문상담을 예약한 기업을<br />대상으로 찾아가는<br />서비스를 제공합니다. </p>
                    <p class="more_bt"><a href="#" onclick="SM.link('voc3'); return false;" title="부정비리신고 바로가기"><img src="<c:url value="/resources/front/FE2/images/main/bt_link.gif"/>" alt="바로가기" /></a></p>
                </li>
            </ul>
            <ul class="banner_02">
                <li>
                    <p class="tit">나의소리함</p>
                    <p class="img"><img src="<c:url value="/resources/front/FE2/images/main/icon_04.gif"/>" alt="" /></p>
                    <p class="link"><a href="#" onclick="SM.link('myvoc'); return false;" title="나의소리함 바로가기">바로가기</a></p>
                </li>
                <li>
                    <p class="tit">고객제안</p>
                    <p class="img"><img src="<c:url value="/resources/front/FE2/images/main/icon_05.gif"/>" alt="" /></p>
                    <p class="link"><a href="#"  onclick="SM.link('voc4'); return false;" title="고객제안 바로가기">바로가기</a></p>
                </li>
                <li class="end">
                    <p class="tit">칭찬격려</p>
                    <p class="img"><img src="<c:url value="/resources/front/FE2/images/main/icon_06.gif"/>" alt="" /></p>
                    <p class="link"><a href="#" onclick="SM.link('bbs3'); return false;" title="칭찬격려 바로가기">바로가기</a></p>
                </li>
            </ul>
        </div>
        
        <!-- 공지사항 -->
        <div class="mnotice">
            <h3>공지사항 <span><a href="#" onclick="SM.link('bbs2'); return false;" title="공지사항 더보기"><img src="<c:url value="/resources/front/FE2/images/page_plus.gif"/>" alt="더보기" /></a></span></h3>
            <ul>
                <c:forEach items="${noticeList}" var="_bean" varStatus="status">
                <li>
                <a href="<c:url value="/fe2/bbs/NR_view.do"/>?bbsCd=2&amp;bbsSeq=${_bean.bbsSeq}&amp;_m=bbs2"><sm:fix-length src="${_bean.title}" limit="52"/></a>
                </li>
                </c:forEach>
                <c:if test="${empty noticeList}">
                <li>
                데이타가 존재하지 않습니다.
                </li>
                </c:if>
            </ul>
        </div>
        
        <!-- 이용안내 배너 -->
        <div class="mservice">
            <ul>
                <li class="s01"><a href="#" onclick="SM.link('info'); return false;" title="이용안내">이용안내</a></li>
                <li class="s02"><a href="#" onclick="SM.link('myvoc'); return false;" title="나의소리함">나의소리함</a></li>
                <li class="s03"><a href="#" onclick="return false;" title="클린신고센터">클린신고센터</a></li>
            </ul>
        </div>
        
        <!-- ARS 콜센터 -->
        <div class="mars">
            <h3>ARS콜 센터 안내</h3>
            <dl>
                <dt><img src="<c:url value="/resources/front/FE2/images/main/banner_call.gif"/>" alt="ARS 콜센터" /></dt>
                <dd>
                    <ul>
                        <li><span>일반문의</span> <i>1588-0000</i></li>
                        <li><span>기업고객전용</span> <i>1588-0001</i></li>
                    </ul>
                    <p class="time">평일 09:00~18:00 / 점심시간 12:00~13:00</p>
                </dd>
            </dl>
        </div>
        
    </div>
    
    <c:import url="/WEB-INF/jsp/fe2/common/decorator/incFooter.jsp" charEncoding="UTF-8"/>
    
</div>

<script type="text/javascript">
    $(function() {
        $('#slides').slidesjs({
            width: 990,
            height: 195,
            play: {
                active: true,
                auto: true,
                interval: 4000,
                swap: true
            }
        });
        
        <c:if test="${not empty userSession}">
        setTimeout("SM.goHome();",  1000 * 60 * 30);
        </c:if>
    }); 
</script>
</body>
</html>