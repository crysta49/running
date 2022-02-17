<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

${dataBean.contents}

<c:if test="${not empty dataBean.fileList}">
<ul class="faq_file">
    <c:forEach items="${dataBean.fileList}" var="item">
    <li>
        <span class="tit">첨부파일</span><img src="<c:url value="/resources/front/FE2/images/board/icon_file.gif"/>" class="fileImg_r" alt="" />
        <a href="<c:url value="/common/file/NR_download.do"/>?id=${item.fileId}">${item.orgFileNm}</a>
    </li>
    </c:forEach>
</ul>
</c:if>