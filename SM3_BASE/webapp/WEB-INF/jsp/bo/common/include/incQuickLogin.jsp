<%@ page contentType="text/html;charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<select onchange="js_quickLoginAction(this.value);" size="${empty param.size ? '1' : param.size}" class="smf-select">
    <option value="">---- 빠른 로그인 ----</option>
    <optgroup label="운영자">
        <option value="manager">운영자</option>
    </optgroup>
    <optgroup label="접수자">
        <option value="receiver1">총무접수</option>
        <option value="receiver2">인사접수</option>
        <option value="receiver3">감사접수</option>
    </optgroup>
    <optgroup label="분배자">
        <option value="divider1">총무분배</option>
        <option value="divider4">총무분배2</option>
        <option value="divider2">인사분배</option>
        <option value="divider3">감사분배</option>
    </optgroup>
    <optgroup label="처리자">
        <option value="dealer1">총무처리</option>
        <option value="dealer4">총무처리2</option>
        <option value="dealer2">인사처리</option>
        <option value="dealer3">감사처리</option>
    </optgroup>
    <optgroup label="결재자">
        <option value="sancer1">총무결재1</option>
        <option value="sancer2">총무결재2</option>
        <option value="sancer3">인사결재1</option>
        <option value="sancer4">인사결재2</option>
    </optgroup>
</select>

<form:form name="quickLoginForm" id="quickLoginForm" method="post" 
    style="display: none;" target="_top">
    <input type="hidden" name="isQuickLogin" value="true" />
    <input type="hidden" name="mgrId" />
    <input type="hidden" name="mgrEncPwd" />
</form:form>

<script type="text/javascript">

    var js_quickLoginAction = function(mgrId) {
        if (mgrId == "") return;

        var jsEncrypt = new JSEncrypt();
        jsEncrypt.setPublicKey($("#publicKey").text());

        $("form[name=quickLoginForm] input[name=mgrId]").val(jsEncrypt.encrypt(mgrId));
        $("form[name=quickLoginForm] input[name=mgrEncPwd]").val(jsEncrypt.encrypt("gnwlqlfeld"));
        
        $("form[name=quickLoginForm]").attr("action", "<c:url value="/bo/base/login/NR_loginAction.do"/>").submit();
    };
</script>