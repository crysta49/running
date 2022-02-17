<%
if ( com.srpost.salmon.lang.WebUtil.isAjaxRequest(request) ) {
    
    response.setContentType("text/plain;charset=utf-8");
    
    String message = (String)request.getAttribute(com.srpost.salmon.constant.Constant.GLOBAL_MSG_KEY);
    if ( com.srpost.salmon.lang.StringUtil.isNotEmpty(message) ) {
        out.println(message);
    }
    else {
        out.println("알 수 없는 예외가 발생했습니다.");
    }
    
    return;
}
else {
%>
    <%@ page contentType="text/html;charset=utf-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>
    
    <sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>
    
    <html>
    <head>
        <title></title>
        <script type="text/javascript">
        
            window.onload = function() {
                <c:if test="${not empty requestScope[CONSTANT.GLOBAL_MSG_KEY]}">
                    alert("${requestScope[CONSTANT.GLOBAL_MSG_KEY]}");
                </c:if>
                <c:if test="${not empty requestScope[CONSTANT.GLOBAL_FORWARD_KEY]}">
                    <c:if test="${empty requestScope[CONSTANT.GLOBAL_FORM_MAP_KEY]}">
                        self.location.href = "<c:url value="${requestScope[CONSTANT.GLOBAL_FORWARD_KEY]}"/>";
                    </c:if>
                    <c:if test="${not empty requestScope[CONSTANT.GLOBAL_FORM_MAP_KEY]}">
                        document.forwardForm.submit();
                    </c:if>
                </c:if>
                <c:if test="${empty requestScope[CONSTANT.GLOBAL_FORWARD_KEY]}">
                    alert("포워딩을 위한 URL 정보가 없습니다.");
                </c:if>
            };
        </script>
    </head>
    
    <body>
    
    <c:if test="${not empty requestScope[CONSTANT.GLOBAL_FORM_MAP_KEY]}">
        <form name="forwardForm" action="<c:url value="${requestScope[CONSTANT.GLOBAL_FORWARD_KEY]}"/>" method="post">
            <c:forEach items="${requestScope[CONSTANT.GLOBAL_FORM_MAP_KEY]}" var="item">
                <input type="hidden" name="${item.key}" value="${item.value}" />
            </c:forEach>
        </form>
    </c:if>
    
    </body>
    
    </html>
<% } %>