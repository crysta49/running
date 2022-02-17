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
                <%--
                if ( $.fn.colorbox ) {
                	if (parent) parent.$.fn.colorbox.close();
                }
                else {
                    self.close();
                } --%>
                self.close();
            };
        </script>
    </head>
    
    <body>
    </body>
    
    </html>
<% } %>