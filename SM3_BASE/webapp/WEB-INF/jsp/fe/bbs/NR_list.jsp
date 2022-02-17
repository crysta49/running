<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>
<c:set var="userSession" value="${sessionScope[CONSTANT.USER_SESSION_KEY]}" />

<sm:static var="BBS_CONF_UTIL" clazz="com.srpost.cm.bo.base.bbs.conf.BbsConfUtil"/>

<html>
<head>
    <title>${confBean.bbsNm} 목록</title>
</head>

<body>

<form name="listForm" method="get" onsubmit="return BBS.search();">
    <input type="hidden" name="bbsCd" value="${bbsBean.bbsCd}" />
    <input type="hidden" name="bbsSeq" value="" />
    <input type="hidden" name="currentPage" value="${bbsBean.currentPage}" />
    <input type="hidden" name="rowPerPage" value="${bbsBean.rowPerPage}" />

    <c:if test="${confBean.ctgYn == 'Y'}">
        <select name="ctgCd" id="ctgCd" onchange="BBS.autoSearch();">
            <option value="">-- 분류전체 --</option>
            <c:forEach items="${confBean.ctgList}" var="item">
            <option value="${item.ctgCd}" <c:if test="${bbsBean.ctgCd == item.ctgCd}">selected="selected"</c:if>>${item.ctgNm}</option>
            </c:forEach>
        </select>
    </c:if>

    <select name="searchKey" id="searchKey" style="width: 100px;">
        <option value="">-- 검색 조건 --</option>
        <option value="1001" <c:if test="${bbsBean.searchKey == '1000'}">selected="selected"</c:if>>제목</option>
        <option value="1002" <c:if test="${bbsBean.searchKey == '2000'}">selected="selected"</c:if>>내용</option>
        <c:if test="${confBean.typeCd == BBS_CONF_UTIL.QNA}">
            <option value="1004" <c:if test="${bbsBean.searchKey == '3000'}">selected="selected"</c:if>>답변</option>
        </c:if>
        <option value="1003" <c:if test="${bbsBean.searchKey == '4000'}">selected="selected"</c:if>>작성자</option>
    </select>
    <input type="text" name="searchVal" id="searchVal" value="${bbsBean.searchVal}" />
    <sm:button type="submit" value="검색" />
    <c:if test="${not empty bbsBean.searchKey and not empty bbsBean.searchVal}">
        <sm:button value="검색 해제" onclick="BBS.resetSearch();"/>
    </c:if>

</form>

<div class="blank"></div>

<div>
    <span>전체 ${pagerBean.totalNum}건 (${pagerBean.currPage}/${pagerBean.lastPage} pages)</span>
</div>
<table>
    <tr>
        <th style="width:60px;">순번</th>
        <c:if test="${confBean.ctgYn == 'Y'}"><th style="width:60px;">분류</th></c:if>
        <th style="width:auto;">제목</th>
        <th style="width:60px;">작성자</th>
        <c:if test="${confBean.typeCd == BBS_CONF_UTIL.QNA}"><th style="width:80px;">처리상태</th></c:if>
        <th style="width:50px;">조회</th>
        <th style="width:100px;">등록일</th>
    </tr>
    
    <!-- 공지글 -->
    <c:forEach items="${ntcList}" var="item">
        <tr>
            <td>#</td>
            <c:if test="${confBean.ctgYn == 'Y'}"><td></td></c:if>
            <td title="${item.title}" class="tl">
                <a href="#" onclick="BBS.ntcView('${bbsBean.bbsCd}', '${item.ntcSeq}'); return false;">
                    <sm:fix-length src="${item.title}" limit="${confBean.ctgYn == 'Y' ? '60' : '80'}"/>
                </a>
                <sm:new-icon date="${item.regDt}"/>
                <c:if test="${item.fileCnt > 0}">
                    &nbsp; <span class="icon-file" title="첨부파일 ${item.fileCnt}개">${item.fileCnt}</span>
                </c:if>
            </td>
            <td>${item.mgrNm}</td>
            <c:if test="${confBean.typeCd == BBS_CONF_UTIL.QNA}"><td></td></c:if>
            <td>${item.readCnt}</td>
            <td>${item.regDt}</td>
        </tr>
    </c:forEach>
    
    <!-- 게시글 -->
    <c:set var="index" value="${pagerBean.indexNo}"/>
    <c:forEach items="${pagerBean.list}" var="item" varStatus="status">
        <tr>
            <td>${index-status.index}</td>
            <c:if test="${confBean.ctgYn == 'Y'}"><td>${item.ctgNm}</td></c:if>
            <td title="${item.title}" class="tl">
                <c:if test="${item.depth > 0}">
                    <span style="margin-left: ${item.depth*20}px;">&nbsp;</span>
                </c:if>
            
                <span><a href="#" onclick="BBS.view('${item.bbsSeq}'); return false;">
                    <sm:fix-length src="${item.title}" limit="${confBean.ctgYn == 'Y' ? '60' : '80'}"/>
                </a></span>
                
                <sm:new-icon date="${item.regDt}"/>
                
                <c:if test="${confBean.fileYn == 'Y' and item.fileCnt > 0}">
                    <span class="icon-file" title="첨부파일 ${item.fileCnt}개">${item.fileCnt}</span>
                </c:if>
                <c:if test="${confBean.cmtYn == 'Y' and item.commentCnt > 0}">
                    <span class="icon-comment" title="의견글 ${item.commentCnt}개">${item.commentCnt}</span>
                </c:if>
            </td>
            <td>
                <sm:mask-word word="${item.writerNm}" />
            </td>
            <c:if test="${confBean.typeCd == BBS_CONF_UTIL.QNA}"><td>${item.statusNm}</td></c:if>
            <td>${item.readCnt}</td>
            <td>${item.regDt}</td>
        </tr>
    </c:forEach>
    
    <c:if test="${confBean.ctgYn == 'Y'}">
        <c:if test="${confBean.typeCd == BBS_CONF_UTIL.QNA}">
            <sm:no-data dataBean="${pagerBean}" colspan="7"/>
        </c:if>
        <c:if test="${confBean.typeCd != BBS_CONF_UTIL.QNA}">
            <sm:no-data dataBean="${pagerBean}" colspan="6"/>
        </c:if>
    </c:if>
    <c:if test="${confBean.ctgYn == 'N'}">
        <c:if test="${confBean.typeCd == BBS_CONF_UTIL.QNA}">
            <sm:no-data dataBean="${pagerBean}" colspan="6"/>
        </c:if>
        <c:if test="${confBean.typeCd != BBS_CONF_UTIL.QNA}">
            <sm:no-data dataBean="${pagerBean}" colspan="5"/>
        </c:if>
    </c:if>
    
</table>

<sm:pager pagerBean="${pagerBean}" script="BBS"/>

<c:if test="${not empty userSession and confBean.admYn eq 'N'}">
    <sm:button-layout>
        <sm:button value="신규 등록" onclick="BBS.insertForm('${bbsBean.bbsCd}');" />
    </sm:button-layout>
</c:if>

<script type="text/javascript" src="<c:url value="/resources/front/FE/js/bbs.js"/>"></script>
<script type="text/javascript">
    $().ready(function(){
        $("#searchKey").change(function(){
            $("#searchVal").focus();
        });
    });
</script>

</body>
</html>