<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="VocConstant" clazz="com.srpost.cm.bo.fm.voc.core.VocConstant"/>
<sm:static var="Constant" clazz="com.srpost.salmon.constant.Constant"/>
<c:set var="userSession" value="${sessionScope[Constant.USER_SESSION_KEY]}"/>

<html>
<head>
    <title>통합검색</title>
    <script type="text/javascript" src="<c:url value="/resources/front/FE2/js/faq.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/front/FE2/js/voc.js"/>"></script>
    <script type="text/javascript">
    $().ready(function(){
    	
    	$('.category > ul > li:last-child').addClass("end");		// 마지막 카테고리 css처리
    	
		// 검색글 하이라이터            
       var searchVal = "${baseListBean.searchVal}";
        $(".search_hirigthArea").highlight(searchVal); 
   });
    </script>
</head>

<body>
    <!-- 검색결과 유무 체크 변수 -->
    <c:set var="search_none" value="0" />
    
    <form name="dataForm" method="get" action="" onsubmit="return SM.searchList(${baseListBean.searchKey});">
        <input type="hidden" name="searchKey" value="${baseListBean.searchKey }" />
        <input type="hidden" name="currentPage" value="${baseListBean.currentPage}" />
        <input type="hidden" name="_m" value="search" />
    
    <!--통합검색-->
    <div id="searchArea">
        <!--검색창-->
        <div class="total_search">
            <label class="search_tit" for="searchVal"></label>
            <span class="faq_search_form"><input name="searchVal" id="searchVal" type="text" value="${baseListBean.searchVal}" title="검색어" /></span>
            <span class="faq_search_bt"><a href="#" onclick="SM.searchList('${baseListBean.searchKey}'); return false;"><img src="<c:url value="/resources/front/FE2/images/faq/bt_faq_search.gif"/>" alt="검색" /></a></span>
        </div>
        <!--//검색창-->
       
       <!--검색카테고리-->
       <c:set var="_totalCount" value="${faqPagerBean.totalNum}"/>
       <c:forEach items="${vocConfBean }" var="_bean">
            <c:set var="_totalCount" value="${_totalCount + _bean.exceedCnt}"/>
       </c:forEach>
       
       <div class="category">
        <ul>
            <li <c:if test="${baseListBean.searchKey == '-1'}"> class="on"</c:if>>
                <a href="#" onclick="SM.searchList('-1'); return false;">전체(${_totalCount })</a>
            </li>
            <li <c:if test="${baseListBean.searchKey == '0'}"> class="on"</c:if>>
                <a href="#" onclick="SM.searchList('0'); return false;">자주하는 질문 (${faqPagerBean.totalNum })</a>
            </li>
            <c:if test="${not empty vocConfBean }">
                <c:forEach items="${vocConfBean }" var="_bean" varStatus="status">
                    <li <c:if test="${baseListBean.searchKey == _bean.vocCd}"> class="on"</c:if>>
                    <a href="#" onclick="SM.searchList(${_bean.vocCd}); return false;">${_bean.vocNm}(${_bean.exceedCnt})</a>
                    </li>
                </c:forEach>
            </c:if>
        </ul>
      </div>
       <!--//검색카테고리-->
       
       <div class="search_list">
       
           <!-- FAQ검색결과 -->
           <c:if test="${not empty faqPagerBean.list && baseListBean.searchKey < 1}">
                <c:set var="search_none" value="${search_none + faqPagerBean.totalNum }" />
                
                <h3 class="cate_tit">
                    <span class="tit">자주하는 질문 [${faqPagerBean.totalNum }건]</span> 
                    <c:if test="${baseListBean.searchKey !='0' }">
                        <span class="more"><a href="#" onclick="SM.searchList('0'); return false;">+ 결과 더보기</a></span>
                    </c:if>
                </h3>
                <ul>
                    <c:forEach items="${faqPagerBean.list}" var="_bean" varStatus="status">    
                        <li class="search_hirigthArea">
                            <p class="search_tit"><a href="#" onclick="SM.searchView('0', '${_bean.seq }'); return false;" title="${_bean.title}"><sm:fix-length src="${_bean.title}" limit="160"/></a></p>
                            <a href="#" class="search_con" onclick="SM.searchView('0', '${_bean.seq }'); return false;"><sm:fix-length src="${_bean.contents}" limit="560"/></a>
                            <span class="date">&nbsp;&nbsp;[ ${_bean.regDt} ]</span>
                            <p class="search_cate"><span class="search_check">▶ 자주하는 질문</span> <c:if test="${not empty _bean.ctgNm }"> &gt; ${_bean.ctgNm }</c:if></p>
                        </li>
                    </c:forEach>                                
                </ul>
                <!--페이징-->
                <c:if test="${baseListBean.searchKey =='0' }">
                    <div id="page">
                        <sm:pager pagerBean="${faqPagerBean}" script="FAQ" page="ui/incPagerFE2.jsp"/>
                    </div>
                </c:if>
                        
           </c:if>
           <!-- //FAQ검색결과 -->
           
           <!-- VOC검색결과 -->
            <!-- 전체 VOC목록 -->
            <c:if test="${baseListBean.searchKey < 0 || baseListBean.searchKey == ''}">
                
                <c:forEach items="${vocPagerBean }" var="_vocBean" varStatus="status">
                    <c:if test="${fn:length(_vocBean) > 0 }">
                        <c:set var="search_none" value="${search_none + (fn:length(_vocBean)) }" />
                        <h3 class="cate_tit">
                        <c:forEach items="${vocConfBean }" var="_vocConfBean" varStatus="confStatus">
                            <c:if test="${status.index == confStatus.index }">
                                <span class="tit">${_vocConfBean.vocNm } [${_vocConfBean.exceedCnt }건]</span>
                                <span class="more"><a href="#"onclick="SM.searchList('${_vocConfBean.vocCd}'); return false;">+ 결과 더보기</a></span>
                            </c:if>
                        </c:forEach>
                        </h3>
                        
                        <ul>
                        <c:forEach items="${_vocBean }" var="_bean">
                            <li class="search_hirigthArea">
                                <p class="search_tit"><a href="#" onclick="SM.searchView('${_bean.vocCd}', '${_bean.vocSeq }'); return false;" title="${_bean.title}"><sm:fix-length src="${_bean.title}" limit="160"/></a></p>
                                <a href="#" class="search_con" onclick="SM.searchView('${_bean.vocCd}', '${_bean.vocSeq }'); return false;"><sm:fix-length src="${_bean.question}" limit="560"/></a>
                                <span class="date">&nbsp;&nbsp;[ ${_bean.regDt} ]</span>
                                <p class="search_cate">
                                    <span class="search_check">▶ ${_bean.vocNm}</span>
                                </p>
                            </li>
                        </c:forEach>
                        </ul>
                    </c:if>
                </c:forEach>
        </c:if>
        <!-- //전체 VOC목록 -->
        
        <!-- 선택된 VOC목록 -->
        <c:if test="${baseListBean.searchKey > 0 && vocPagerBean.totalNum > 0 }">
            <h3 class="cate_tit">
            <c:forEach items="${vocConfBean }" var="_vocConfBean" varStatus="status">
                <c:if test="${_vocConfBean.vocCd == baseListBean.searchKey }">
                    <c:set var="search_none" value="${search_none + vocPagerBean.totalNum }" />
                    <span class="tit">${_vocConfBean.vocNm } [${vocPagerBean.totalNum }건]</span>
                </c:if>
            </c:forEach>
            </h3>
                        
            <ul>
            <c:forEach items="${vocPagerBean.list }" var="_bean" varStatus="status">
                <li class="search_hirigthArea">
                    <p class="search_tit"><a href="#" onclick="SM.searchView('${_bean.vocCd}', '${_bean.vocSeq }'); return false;" title="${_bean.title}"><sm:fix-length src="${_bean.title}" limit="160"/></a></p>
                    <a href="#" class="search_con" onclick="SM.searchView('${_bean.vocCd}', '${_bean.vocSeq }'); return false;"><sm:fix-length src="${_bean.question}" limit="560"/></a>
                    <span class="date">&nbsp;&nbsp;[ ${_bean.regDt} ]</span>
                    <p class="search_cate">
                        <span class="search_check">▶ ${_bean.vocNm}</span>
                    </p>
                </li>
            </c:forEach>
            </ul>
            
            <!--페이징-->
            <div id="page">
               <sm:pager pagerBean="${vocPagerBean}" script="VOC" page="ui/incPagerFE2.jsp"/>
            </div>
        </c:if>
        <!-- //선택된 VOC목록 -->
        <!-- //VOC검색결과 -->
           
       </div>
       
       <!-- 검색결과가 없을때 -->
       <c:if test="${search_none == 0 }"   >
            <div class="search_none">
                <p class="none_img"><img src="<c:url value="/resources/front/FE2/images/search/search_noneimg.gif"/>" /></p>
                <p class="tit">검색 결과가 없습니다.</p>
                <ul>
                    <li>단어의 철자 및 띄어쓰기가 정확한지 확인해 보세요.</li>
                    <li>한글을 영어로 혹은 영어를 한글로 입력했는지 확인해 보세요.</li>
                    <li>검색어의 단어 수를 줄이거나, 보다 일반적인 검색어로 다시 검색해 보세요.</li>
                    <li>특수문자를 제외하고 입력해 보세요.</li>
                </ul>
            </div>
        </c:if>
        <!-- //검색결과가 없을때 -->

    </div>
    <!--//통합검색-->
    </form>
</body>
</html>