<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<%-- 공지사항 --%>

<table class="tbl-list">
    <colgroup>
        <col />
        <col width="100" />
    </colgroup>
    <tr>
        <th>제목</th>
        <th class="tc">등록일</th>
    </tr>
    <c:forEach items="${dataList}" var="item" varStatus="status">
    <tr>
        <td class="tl" title="${item.title}">
            <a href="#" onclick="js_link('bbs1', '&bbsSeq=${item.bbsSeq}');">
                <sm:fix-length src="${item.title}" limit="50"/>
            </a>
            <%-- <sm:new-icon date="${item.regDt}"/> --%>
        </td>
        <td class="tc">${item.regDt}</td>
    </tr>
    </c:forEach>
    
    <sm:no-data dataBean="${dataList}" colspan="2"/>
</table>

<div class="fr" style="margin-top: 4px;">
    <a href="#" onclick="js_link('bbs1');"><span class="t3-more">&nbsp;</span></a>
</div>