<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
    <head>
    <title>${curMenuBean.menuNm}</title>
    <meta name="title" content="FAQ 정보를 조회합니다." />
    </head>
<body>

<div class="bg-box bg-info text-info">
    검색을 이용하시면 보다 빠르게 원하시는 지식정보를 찾으실 수 있습니다.
</div>

<div class="blank"></div>

<table class="tbl-header">
    <tr>
        <th style="width: 35%;">
            <span class="title-big">전체 ${pagerBean.totalNum}건 (${pagerBean.currPage}/${pagerBean.lastPage} pages)</span>
        </th>
        <td class="tr">
            <form:form name="listForm" id="listForm" method="get" action="index.do" onsubmit="return FAQ.search();">
                <input type="hidden" name="seq" value="" />
                <input type="hidden" name="currentPage" value="${faqBean.currentPage}" />
                <input type="hidden" name="rowPerPage" value="${faqBean.rowPerPage}" />
    
                <select name="ctgCd" id="ctgCd" class="smf-select" onchange="FAQ.autoSearch();">
                    <option value="">-- 분류 --</option>
                    <c:forEach items="${ctgList}" var="item">
                        <option value="${item.ctgCd}" ${smp.ctgCd == item.ctgCd ? 'selected=selected' : ''}>${fn:replace(item.ctgNm, '^', '&nbsp;')}</option>
                    </c:forEach>
                </select>
                <select name="searchKey" id="searchKey" class="smf-select">
                    <option value="1000" ${smp.searchKey == '1000' ? 'selected=selected' : ''}>제목</option>
                    <option value="2000" ${smp.searchKey == '2000' ? 'selected=selected' : ''}>내용</option>
                </select>
                <input type="text" name="searchVal" id="searchVal" value="${faqBean.searchVal}" class="smf-text"/>
                <sm:button type="submit" cssClass="btn-default" glyph="search" value="검색" />
                <c:if test="${not empty faqBean.searchVal  or not empty smp.ctgCd}">
                    <sm:button value="해제" cssClass="btn-default" onclick="FAQ.resetSearch();" />
                </c:if>
            </form:form>
        </td>
    </tr>
</table>

<div class="blank"></div>

<div class="faq-list">
    <c:forEach items="${pagerBean.list}" var="item" varStatus="status">
        <div class="row faq-list-row">
            <div class="faq-hover-row" onclick="FAQ.view('${item.seq}'); return false;">
                <div class="col-xs-1">
                    <span class="mark f-bold">Q</span>
                </div>
                <div class="col-xs-11">
                    <span class="label label-info">${item.ctgNm}</span>&nbsp;
                    <span class="f-14">${item.title}</span>                
                    <sm:new-icon date="${item.regDt}"/>
                </div>
            </div>
            <div class="col-xs-12" id="viewDiv_${item.seq}"></div>
            <div class="col-xs-1">
            </div>
            <div class="col-xs-11 meta-info f-11">
                <div class="col-xs-6">
                    <i></i> 등록일 : <span class="">${item.regDt}</span>
                </div>
                <div class="col-xs-6 text-right">
                    <i class="glyphicon glyphicon-eye-open"></i> 조회 <span class="cnt">${item.readCnt}</span> &nbsp;
                    <i class="glyphicon glyphicon-floppy-disk"></i> 파일 <span class="cnt">${item.fileCnt}</span> &nbsp;
                    <i class="glyphicon glyphicon-thumbs-up"></i> 추천  <span id="recom-cnt_${item.seq}" class="cnt">${item.recomCnt - item.oppCnt}</span>
                </div>
            </div>
        </div>
    </c:forEach>
    <sm:no-data dataBean="${pagerBean.list}" />
</div>

<sm:pager pagerBean="${pagerBean}" script="FAQ"/>

<script type="text/javascript" src="<c:url value="/resources/fm/js/faq.js"/>"></script>
<script type="text/javascript">
    $(document).ready(function(){
        <c:if test="${not empty smp.seq}">
            FAQ.view('${smp.seq}');
        </c:if>
    });
</script>

</body>
</html>