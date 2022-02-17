<%@ page pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="Constant" clazz="com.srpost.salmon.constant.Constant"/>
<c:set var="userSession" value="${sessionScope[Constant.USER_SESSION_KEY]}"/>

<!-- 스킵네비 -->
<div id="skipnav">
    <a href="#content">본문바로가기</a>
</div>

<!-- 전체메뉴 보기 레이어 -->
<div id="boxes">
    <div id="dialog" class="window">
        <div class="tit">
            <p class="pop_close"><a href="#" class="close"><img src="<c:url value="/resources/front/FE2/images/all_pop_close.gif"/>" alt="전체메뉴닫기" /></a></p>
            <img src="<c:url value="/resources/front/FE2/images/all_pop.gif"/>" alt="전체메뉴보기" />
        </div>
        <div class="allbox">
            <ul>
                <li class="tit"><a href="#" onclick="SM.link('voc1'); return false;">질의응답 VOC</a></li>
                <li><a href="#" onclick="SM.link('voc1'); return false;">질의응답 목록</a></li>
                <li><a href="#" onclick="SM.link('voc_1'); return false;">질의응답 접수</a></li>
            </ul>
            <ul>
                <li class="tit"><a href="#" onclick="SM.link('voc2'); return false;">불평불만신고</a></li>
                <li><a href="#" onclick="SM.link('voc2'); return false;">불평불만 목록</a></li>
                <li><a href="#" onclick="SM.link('voc_2'); return false;">불평불만 접수</a></li>
            </ul>
            <ul>
                <li class="tit"><a href="#" onclick="SM.link('voc3'); return false;">부정비리신고</a></li>
                <li><a href="#" onclick="SM.link('voc3'); return false;">부정비리 목록</a></li>
                <li><a href="#" onclick="SM.link('voc_3'); return false;">부정비리 접수</a></li>
            </ul>
            <ul>
                <li class="tit"><a href="#" onclick="SM.link('faq'); return false;">자주묻는 질문</a></li>
                <li><a href="#" onclick="SM.link('faq'); return false;">질문/답변</a></li>
            </ul>
            <ul>
                <li class="tit"><a href="#" onclick="SM.link('voc4'); return false;">고객제안</a></li>
                <li><a href="#" onclick="SM.link('voc4'); return false;">고객제안 목록</a></li>
                <li><a href="#" onclick="SM.link('voc_4'); return false;">고객제안 접수</a></li>
            </ul>
            <ul>
                <li class="tit"><a href="#" onclick="SM.link('bbs3'); return false;">칭찬격려</a></li>
                <li><a href="#" onclick="SM.link('bbs3'); return false;">칭찬격려 목록</a></li>
                <li><a href="#" onclick="SM.link('bbs_3'); return false;">칭찬격려 접수</a></li>
            </ul>
            <ul>
                <li class="tit"><a href="#" onclick="SM.link('myvoc'); return false;">나의소리함</a></li>
            </ul>
            <ul>
                <li class="tit"><a href="#" onclick="SM.link('info'); return false;">이용안내</a></li>
            </ul>
            <ul>
                <li class="tit"><a href="#" onclick="SM.link('bbs2'); return false;">공지사항</a></li>
            </ul>
        </div>
    </div>
    <!-- BG 마스크 영역 -->
    <div id="mask"></div>
</div>  

<!-- 최상단 -->
<div id="head">
    <p class="allmenu_bt"><a href="#dialog" name="modal"><img src="<c:url value="/resources/front/FE2/images/top_allmenu.gif"/>" alt="전체메뉴보기" /></a></p>
    <!-- 헤드메뉴 -->
    <ul class="thead">
        <li class="b"><a href="http://www.srpost.co.kr/" title="SRPOST 홈페이지로 이동" target="_blank">SRPOST 홈</a></li>
        <li><a href="#" onclick="SM.link('home'); return false;" title="고객의소리 홈으로 이동">고객의 소리 홈</a></li>
        <li>글자크기 <span><a href="#" onclick="SM.zoomin();"><img src="<c:url value="/resources/front/FE2/images/page_plus.gif"/>" alt="글자포인트크게" /></a></span> 
        <span><a href="#" onclick="SM.zoomre();"><img src="<c:url value="/resources/front/FE2/images/page_reflash.gif"/>" alt="원래대로" /></a></span> 
        <span><a href="#" onclick="SM.zoomout();"><img src="<c:url value="/resources/front/FE2/images/page_minus.gif"/>" alt="글자포인트작게" /></a></span></li>
    </ul>
</div>

<!-- 상단 -->
<div id="top">
    <c:if test="${not empty userSession}">
        <div id="countdown"><span class="cont_tit">본인인증 만료시간</span></div>
    </c:if>
    <div>
        <h1><a href="#" onclick="SM.link('home');" title="고객의소리 홈으로 이동"><img src="<c:url value="/resources/front/FE2/images/header_logo_sr.gif"/>" alt="고객의소리, SRPOST" /></a></h1>
        
        <!-- 통합검색 -->
        <div class="total_search">
            <fieldset>
            <label for="search">검색어를 입력해주세요.</label>
            <input name="search" id="search" type="text" class="total_input" 
                style="background:url('<c:url value="/resources/front/FE2/images/total_txtbg.gif"/>') no-repeat;" 
                onkeypress="if(event.keyCode==13){return SM.totalSearch('-1');}" 
                onfocus="if(this.value=='') this.style.backgroundImage='';" />
            <span><a href="#" onclick="SM.totalSearch('-1');"><img src="<c:url value="/resources/front/FE2/images/top_search_bt.gif"/>" alt="검색" /></a></span>
            </fieldset>
        </div>
                
        <ul class="top_mymenu">
            <li><a href="#" onclick="SM.link('myvoc');" title="나의소리함으로이동"><img src="<c:url value="/resources/front/FE2/images/head_mysori.gif"/>" alt="나의소리함" /></a></li>
            <c:choose>
                <c:when test="${empty userSession}">
                    <li><a href="#" onclick="SM.link('login');" title="본인인증으로이동"><img src="<c:url value="/resources/front/FE2/images/head_my.gif"/>" alt="본인인증" /></a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="#" onclick="SM.link('logout');" title="본인인증해제"><img src="<c:url value="/resources/front/FE2/images/head_myout.gif"/>" alt="본인인증해제" /></a></li>
                </c:otherwise>
            </c:choose>
        </ul> 
        
        <!--gnb-->
        <div id="gnb">
            <div class="gnb01">
                <ul>
                    <li><a href="#" onclick="SM.link('voc1'); return false;" title="질의응답 VOC">질의응답 VOC</a></li>
                    <li><a href="#" onclick="SM.link('voc2'); return false;" title="불평불만신고">불평불만신고</a></li>
                    <li class="end"><a href="#" onclick="SM.link('voc3'); return false;" title="부정비리신고">부정비리신고</a></li>
                </ul>
            </div>
            <div class="gnb02">
                <ul>
                    <li><a href="#" onclick="SM.link('faq'); return false;" title="자주하는 질문">자주하는 질문</a></li>
                    <li><a href="#" onclick="SM.link('voc4'); return false;" title="고객제안">고객제안</a></li>
                    <li class="end"><a href="#" onclick="SM.link('bbs3'); return false;" title="칭찬격려">칭찬격려</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
