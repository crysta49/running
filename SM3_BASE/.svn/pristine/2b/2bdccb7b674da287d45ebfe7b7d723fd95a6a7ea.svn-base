<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pagez" value="${pager.pages}"/>

<c:if test="${pager.totalPage >= 1}">
    <div aria-label="Page navigation" class="text-center">
        <ul class="pagination">
            <c:if test="${!pager.startPagePart}">
                <li><a href="#" aria-label="Previous" onclick="${script}.move(${pager.previousPartLastPage}); return false;" title="이전 페이지"><span aria-hidden="true"><i class="glyphicon glyphicon-menu-left"></i></span></a></li>
            </c:if>
            <c:if test="${pager.startPagePart}">
                <li class="disabled"><span title="이전 페이지"><span aria-hidden="true"><i class="glyphicon glyphicon-menu-left"></i></span></span></li>
            </c:if>
            
            <c:forEach items="${pagez}" var="item">
                <c:if test="${item eq pager.currPage}">
                    <li class="active"><a title="현재 페이지">${item}</a></li>
                </c:if>
                <c:if test="${item ne pager.currPage}">
                    <li><a href="#" onclick="${script}.move(${item}); return false;" title="${item} 페이지">${item}</a></li>
                </c:if>
            </c:forEach>
            
            <c:if test="${!pager.lastPagePart}">
                <li><a href="#" aria-label="Next" onclick="${script}.move(${pager.nextPartFirstPage}); return false;" class="next" title="다음 페이지"><span aria-hidden="true"><i class="glyphicon glyphicon-menu-right"></i></span></a></li>
            </c:if>
            <c:if test="${pager.lastPagePart}">
                <li class="disabled"><span title="다음 페이지"><span aria-hidden="true"><i class="glyphicon glyphicon-menu-right"></i></span></span></li>
            </c:if>
        </ul>
    </div>
</c:if>
