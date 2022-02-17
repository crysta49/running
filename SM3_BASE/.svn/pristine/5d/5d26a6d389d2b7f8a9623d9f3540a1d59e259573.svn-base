<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>FAQ</title>
    <script type="text/javascript" src="<c:url value="/resources/front/FE/js/faq.js"/>"></script>
</head>

<body>

<form:form name="dataForm" id="dataForm" method="get" action="NR_list.do" onsubmit="return FAQ.search();">
    <input type="hidden" name="currentPage" value="${smp.currentPage}" />
    <input type="hidden" name="rowPerPage" value="${smp.rowPerPage}" />

    <div>
        <select name="ctgCd" id="ctgCd" onchange="FAQ.ctgSearch(this.value);">
            <option value="">-- 분류전체 --</option>
            <c:forEach items="${ctgList}" var="item">
                <option value="${item.ctgCd}" <c:if test="${smp.ctgCd == item.ctgCd}">selected="selected"</c:if>>${item.ctgNm}</option>
            </c:forEach>
        </select>        
        &nbsp;
        <input type="hidden" name="searchKey" id="searchKey" value="4000" />
        <input type="text" name="searchVal" id="searchVal" value="${smp.searchVal}" />
        <sm:button type="submit" value="검색" />
        <c:if test="${not empty smp.searchKey and not empty smp.searchVal}">
            <sm:button value="검색 해제" onclick="FAQ.resetSearch();"/>
        </c:if>
    </div>
</form:form>

<div class="blank"></div>

<div>
    <span>전체 ${pagerBean.totalNum}건 (${pagerBean.currPage}/${pagerBean.lastPage} pages)</span>
</div>

<c:forEach items="${pagerBean.list}" var="item">
    <div style="margin: 12px 0;">
        <b>[${item.ctgNm}] <a href="#" title="${item.title}" onclick="FAQ.view('${item.seq}'); return false;">
            <sm:fix-length src="${item.title}" limit="140"/></a></b>
        
        <div id="faqDesc${item.seq}" style="display: none; line-height: 24px;"></div>
    </div>
</c:forEach>

<c:if test="${empty pagerBean.list}">
<dl>
    <dt class="no-data"><span>데이터가 존재하지 않습니다.</span></dt>
</dl>
</c:if>

<sm:pager pagerBean="${pagerBean}" script="FAQ" />

<script type="text/javascript">
    $().ready(function(){
		
        /*
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
        } */
    });

</script>

</body>
</html>