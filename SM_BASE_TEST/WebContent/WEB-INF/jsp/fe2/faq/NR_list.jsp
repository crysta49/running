<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>자주하는 질문</title>
    <script type="text/javascript" src="<c:url value="/resources/front/FE2/js/faq.js"/>"></script>
    <style type="text/css">
        .highlight {font-weight:bold; color:#395cb3; cursor: pointer;}
    </style>
    <script type="text/javascript">
        $().ready(function(){

             $("dl > dd").hide();
             
             if ( "${param.seq != null }") {
        		 $('#on').show();
        	 }
        	 
        	 location.hash='#on';
             
             $("dl > dt").click(function(){
                 if ( $(this).next().css("display") == "none" ){
                     $("dl > dd").hide();
                     $(this).next().show();
                 } else {
                     $("dl > dd").hide();
                 }
             });
             
             if ('${smp.seq}' != "") {
                 $('#faq_q_${smp.seq}').trigger('click');
             }

            // 검색글 하이라이터
            $('.search_hirigthArea').highlight($('#searchVal').val());

        });

    </script>
</head>

<body>

<form name="dataForm" method="get" action="NR_list.do" onsubmit="return FAQ.search();">
    <input type="hidden" name="currentPage" value="${smp.currentPage}" />
    <input type="hidden" name="rowPerPage" value="${smp.rowPerPage}" />
    <input type="hidden" name="ctgCd" value="${smp.ctgCd}" />

        <div id="faq">
        <!--질문검색-->
        <div class="faq_search">
            <label class="search_tit" for="searchQ"><img src="<c:url value="/resources/front/FE2/images/faq/tit_faq_search.gif"/>" alt="질문검색" id="searchQ"/></label>
            <span class="faq_search_form">
                <!-- 제목 + 내용 검색 -->
                <input type="hidden" name="searchKey" id="searchKey" value="4000" />
                <input type="text" name="searchVal" id="searchVal" value="${smp.searchVal}" title="검색어" />
            </span>
            <span class="faq_search_bt"><input type="image" src="<c:url value="/resources/front/FE2/images/faq/bt_faq_search.gif"/>" style="padding:0; width:60px; height: 40px;"/></span>
        </div>

        <!--질문분류-->
        <div class="faq_category">
            <div class="category_tit">
                <p class="timg">질문분류</p>
                <p>&nbsp;</p>
                <p class="cate_more"><img src="<c:url value="/resources/front/FE2/images/faq/faq_more.gif"/>" onclick="FAQ.ctgSearch(''); return false;" class="cl" alt="전체" /></p>
            </div>

            <div class="category_list">
                <ul>
                    <c:forEach items="${ctgList }" var="item">
                    <li <c:if test="${smp.ctgCd == item.ctgCd }">class="sel"</c:if>><a href="#" onclick="FAQ.ctgSearch('${item.ctgCd}'); return false;" >${item.ctgNm }</a></li>
                    </c:forEach>
                </ul>
             </div>
        </div>

        <h3 class="hide">자주하는 질문 목록</h3>
        <div class="faq_line"></div>

        <!--질문답변리스트-->
        <c:forEach items="${pagerBean.list}" var="item">
        <dl>
            <dt class="faq_q" id="faq_q_${item.seq}" onclick="FAQ.view('${item.seq}'); return false;" title="${item.title}">
                <span class="faq_cate">[ ${item.ctgNm} ]</span>
                <span class="search_hirigthArea"><sm:fix-length src="${item.title}" limit="140"/></span>
            </dt>
            
            <dd class="faq_a" id="faq_a_${item.seq}">
                <div class="faq_con"></div>
                <div class="faq_smile">
                    <span>답변이 도움이 되셨나요?</span>
                    <ul class="smile">
                        <li onclick="FAQ.recomAction('${item.seq}'); return false;" class="hov cl"><a href="#"><img src="<c:url value="/resources/front/FE2/images/faq/icon_smile.gif"/>" alt="예" /> 예</a></li>
                        <li onclick="FAQ.decomAction('${item.seq}'); return false;" class="hov cl"><a href="#"><img src="<c:url value="/resources/front/FE2/images/faq/icon_angry.gif"/>" alt="아니오" /> 아니오</a></li>
                    </ul>
                </div>
                <a href="#" onclick="FAQ.close('faq_a_${item.seq}'); return false;" class="faq_close" id="tt"><img src="<c:url value="/resources/front/FE2/images/faq/bt_faq_close.gif"/>" alt="접기" /></a>
            </dd>
        </dl>
        </c:forEach>

        <c:if test="${empty pagerBean.list}">
        <dl>
            <dt class="no-data"><span>데이터가 존재하지 않습니다.</span></dt>
        </dl>
        </c:if>
        <!--//질문답변리스트-->


       <!--페이징-->
       <div id="page">
           <sm:pager pagerBean="${pagerBean}" script="FAQ" page="ui/incPagerFE2.jsp"/>
       </div>

    </div>
    <!--//자주하는 질문-->
</form>

</body>
</html>