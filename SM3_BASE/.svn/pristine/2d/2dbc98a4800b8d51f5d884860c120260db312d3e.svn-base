<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
    <title>중복 로그인 안내 - ${CONSTANT.SYSTEM_NM}</title>
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible"/>
    <meta name="robots" content="noindex, nofollow">
    <sm:js names="jquery"/>
</head>
 
<body>

<c:if test="${empty dataBean}">
    <script type="text/javascript">
        $().ready(function() {
            self.location.href = "<c:url value="/login" />";
        });
    </script>
</c:if>
<c:if test="${not empty dataBean}">
    <script type="text/javascript">
        $().ready(function() {
            
            var msg = "이전 접속 정보가 존재합니다.\n강제 접속 해지하시겠습니까?\n\n";
            msg += "[이전 접속 정보]\n";
            msg += "* 접속일시 : ${dataBean.loginDt}\n";
            msg += "* 접속IP : ${dataBean.loginIp}\n";
            msg += "* 접속장비 : ${dataBean.userAgent}\n\n";
            msg += "확인을 선택하시면 이전 접속 정보가 해지 후 로그인이 진행되며,\n취소를 선택하시면 로그인 과정이 중단됩니다.";
            
            if ( confirm(msg) ) {
                self.location.href = "<c:url value="/bo/base/login/NR_removeOldSessionAndMoveExplorer.do" />";
            }
            else {
                self.location.href = "<c:url value="/bo/base/login/NR_keepSessionAndMoveLogin.do" />";
            }
            
        });
    </script>
</c:if>

</body>
</html>