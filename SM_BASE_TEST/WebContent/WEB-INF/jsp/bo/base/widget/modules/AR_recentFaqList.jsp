<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<%-- 최신 상담사례 --%>

<table class="tbl-list">
    <colgroup>
        <col />
        <col width="100" />
    </colgroup>
    <tr>
        <th>제목</th>
        <th class="tc">점수</th>
    </tr>
    <c:forEach items="${dataList}" var="item" varStatus="status">
    <tr>
        <td class="tl" title="${item.title}">
            <a href="#" onclick="js_link('faq', '?seq=${item.seq}&sortOrder=best&useYn=Y');">
                <sm:fix-length src="${item.title}" limit="50"/>
            </a>
        </td>
        <td class="tc" title="점수는 조회수 40%, 추천수 60%로 계산됩니다.">${item.scoreAvg}점</td>
    </tr>
    </c:forEach>
    
    <sm:no-data dataBean="${dataList}" colspan="2"/>
</table>

<div class="fr" style="margin-top: 4px;">
    <a href="#" onclick="js_link('faq', '?sortOrder=best&useYn=Y');"><span class="t3-more">&nbsp;</span></a>
</div>