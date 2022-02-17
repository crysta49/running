<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>회원 로그인</title>
</head>

<body>

<h2>회원 로그인</h2>

<form:form commandName="dataBean" id="loginForm" name="loginForm" 
    action="TR_loginAction.do" method="post">
    
    <table>
        <tr>
            <th>아이디</th>
            <td>
                <form:input path="userKey" size="30" data-label="아이디"/>
            </td>
        </tr>
        <tr>
            <th>비밀번호</th>
            <td>
                <form:password path="userEncPwd" size="30" data-label="비밀번호"/>
            </td>
        </tr>
    </table>
    <sm:button-layout align="left">
        <sm:button type="submit" value="로그인" />
    </sm:button-layout>
</form:form>

<sm:js names="validation"/>
<script type="text/javascript">

    $().ready(function() {

        $("#loginForm").validate({
            rules: {
                userKey : { required: true },
                userEncPwd : { required: true }
            },
            submitHandler: function(form) {

                $(form).ajaxSubmit({
                    url      : "TR_loginAction.do",
                    type     : "POST",
                    success  : function(response) {
                        if ( response == "200" ) {
                            jsRedirectAfterLogin();
                        }
                        else {
                            alert(response)
                        }
                    }
                });
            }
        });
        
        $("#userKey")[0].focus();
        
        $("#userKey, #userEncPwd").val("user1");
    });
    
    var jsRedirectAfterLogin = function() {
        if ( "${RETURN_URI}" == "" ) {
            self.location.href = "<c:url value="/front"/>";
        }
        else {
            self.location.href = "${RETURN_URI}";
        }
    };
</script>

</body>
</html>