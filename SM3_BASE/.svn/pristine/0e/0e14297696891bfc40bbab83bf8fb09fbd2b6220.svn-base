<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>게시판</title>
    <script type="text/javascript" src="<c:url value="/resources/front/FE2/js/bbs.js"/>"></script>
</head>

<body>

<form name="dataForm" method="get" action="" onsubmit="return BBS.search();">
    <input type="hidden" name="bbsCd" value="${bbsBean.bbsCd}" />
    <input type="hidden" name="bbsSeq" value="" />
    <input type="hidden" name="currentPage" value="${bbsBean.currentPage}" />
    <input type="hidden" name="rowPerPage" value="${bbsBean.rowPerPage}" />
    <input type="hidden" name="_m" value="${smp._m}" />

    <!-- 검색 -->
    <div id="board_search">
        <p class="info">총 <span class="p1">${pagerBean.totalNum}</span> 건 (${pagerBean.currPage}/${pagerBean.lastPage} pages)</p>
        
        <c:if test="${confBean.ctgYn == 'Y'}">
            <select name="ctgCd" id="ctgCd" onchange="BBS.autoSearch();">
                <option value="">-- 분류전체 --</option>
                <c:forEach items="${confBean.ctgList}" var="_bean">
                    <option value="${_bean.ctgCd}" <c:if test="${smp.ctgCd == _bean.ctgCd}">selected="selected"</c:if>>${_bean.ctgNm}</option>
                </c:forEach>
            </select>
        </c:if>
        <select name="searchKey" id="searchKey" style="width:80px;" title="검색">
            <option value="">--선택--</option>
            <option value="1000" <c:if test="${bbsBean.searchKey == '1000'}">selected="selected"</c:if>>제목</option>
            <option value="2000" <c:if test="${bbsBean.searchKey == '2000'}">selected="selected"</c:if>>내용</option>
        </select>
        <input name="searchVal" id="searchVal" value="${bbsBean.searchVal}" type="text" class="text" title="검색박스" />
        <p class="bt"><input type="image" src="<c:url value="/resources/front/FE2/images/board/bt_search.gif"/>" style="width:51px; height: 28px;"/></p>
        
        <c:if test="${not empty bbsBean.searchKey and not empty bbsBean.searchVal}">
        <a href="#" onclick="BBS.searchReset(); return false;">초기화</a>
        </c:if>
    </div>
</form>

<div id="board">
    <table class="list" summary="번호, 제목, 첨부파일, 작성일, 조회수로 구성">
        <caption>공지사항 목록</caption>
        <colgroup>
            <col style="width:60px" />
            <col style="width:*" />
            <col style="width:60px" />
            <col style="width:100px" />
            <col style="width:80px" />
        </colgroup>
        <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col">제목</th>
                <th scope="col">첨부</th>
                <th scope="col">작성일</th>
                <th scope="col">조회수</th>
            </tr>
        </thead>
        <tbody>
        <%--
        <!-- 공지글 -->
        <c:set var="index" value="${fn:length(ntcList)}"/>
        <c:forEach items="${ntcList}" var="_bean" varStatus="status">
            <tr class="ntc">
                <td><span class="ico-notice-only">&nbsp;</span></td>
                <td title="${_bean.title}" class="td_subject">
                    <a href="#content" onclick="jsNtcUserView('${_bean.ntcSeq}'); return false;"><salmon:fix-length src="${_bean.title}" limit="60"/></a>
                </td>
                <td>
                    <c:if test="${_bean.fileCnt > 0}">
                        &nbsp;<span class="ico-file">&nbsp;</span>
                    </c:if> 
                </td>               
                <td>${_bean.regDt}</td>
                <td>${_bean.readCnt}</td>
            </tr>
        </c:forEach> --%>
        
        <!-- 게시글 -->
        <c:set var="index" value="${pagerBean.indexNo}"/>
        <c:forEach items="${pagerBean.list}" var="item" varStatus="status"> 
            <tr>
                <td>${index-status.index}</td>
                <td class="td_subject" title="${item.title}">
                    <a href="#" onclick="BBS.view('${item.bbsSeq}'); return false;"><sm:fix-length src="${item.title}" limit="90"/></a>
                </td>
                <td>
                    <c:if test="${item.fileCnt > 0}">
                        &nbsp;<span class="ico-file">&nbsp;</span>
                    </c:if> 
                </td>
                <td>${item.regDt}</td>
                <td>${item.readCnt}</td>
            </tr>
        </c:forEach>
        
        <sm:no-data dataBean="${pagerBean}" colspan="5"/>
        
        </tbody>
      </table>

      <!-- 페이징 -->
      <div id="page">
          <sm:pager pagerBean="${pagerBean}" script="BBS" page="ui/incPagerFE2.jsp"/>
      </div>
</div>

<script type="text/javascript">
    $(function() {
    });
</script>

</body>
</html>