<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pagez" value="${pager.pages}"/>

<c:if test="${pager.totalPage >= 1}">
    <div class="pagenation">
        <c:if test="${!pager.startPagePart}">
            <span><a href="#" onclick="${script}.move(${pager.previousPartLastPage}); return false;" class="prev" title="이전 페이지"><img src="<c:url value="/resources/front/FE2/images/board/arrow_prev.gif"/>" alt="이전" /></a></span>
        </c:if>
        
        <c:forEach items="${pagez}" var="item">
            <c:if test="${item eq pager.currPage}">
                <a class="numov" title="현재 페이지">${item}</a>
            </c:if>
            <c:if test="${item ne pager.currPage}">
                <a href="#" onclick="${script}.move(${item}); return false;" title="${item} 페이지">${item}</a>
            </c:if>
        </c:forEach>
        
        <c:if test="${!pager.lastPagePart}">
            <span><a href="#" onclick="${script}.move(${pager.nextPartFirstPage}); return false;" class="next" title="다음 페이지"><img src="<c:url value="/resources/front/FE2/images/board/arrow_next.gif"/>" alt="다음" /></a></span>
        </c:if>
    </div>
</c:if>
<c:if test="${pager.totalPage < 1}">
    <div class="pagenation">&nbsp;</div>
</c:if>
