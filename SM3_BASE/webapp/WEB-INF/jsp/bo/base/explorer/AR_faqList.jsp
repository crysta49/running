<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<c:forEach items="${faqList}" var="item">
    <li class="text-overflow"><b>ㆍ</b> <a href="<c:url value="/bo/base/faq/core/NR_index.do?seq="/>${item.seq}" title="${item.title}">${item.title}</a></li>
</c:forEach>
<c:if test="${empty faqList}">
    <li class="text-overflow"><b>ㆍ</b> 등록된 자료가 없습니다.</li>
</c:if>
