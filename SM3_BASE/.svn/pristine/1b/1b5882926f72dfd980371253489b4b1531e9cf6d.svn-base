<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<fieldset>
    <legend>캐시 정보</legend>
    <div style="height: 300px; overflow: auto;">
        <pre name="code" class="java"><sm:xss value="${dataBean}" /></pre>
    </div>    
</fieldset>

<script type="text/javascript">
    Ext.onReady(function() {
        dp.SyntaxHighlighter.HighlightAll("code", false, false, false, false);
    });
</script>
