<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
    <title>로그인 - ${CONSTANT.SYSTEM_NM}</title>
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible"/>
    <meta name="robots" content="noindex, nofollow">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/base/css/login/login.css"/>" />    
    <sm:js names="jquery"/>
</head>
 
<body>
    
<c:set var="mgrSession" value="${sessionScope[CONSTANT.MGR_SESSION_KEY]}" />

<c:if test="${not empty mgrSession}">
    <script type="text/javascript">
        $().ready(function() {
            self.location.href = "<c:url value="/explorer" />";
        });
    </script>
</c:if>
<c:if test="${empty mgrSession}">

    <div class="wrap">
        <div class="box_f box1 pat30">
            <div class="loginBox">
                <img class="img" src="<c:url value="/resources/base/images/base/login/login_fla.png" />" alt="Flamingo 3.0" />

                <div class="login">
                    <form:form name="dataForm" method="post" class="login-form" autocomplete="off"
                        action="NR_loginAction.do" onsubmit="return js_loginAction();">
                        <input type="hidden" name="mgrId" id="mgrId" />
                        <input type="hidden" name="mgrEncPwd" id="mgrEncPwd" />
                        
                        <div class="tit">
                            USER <strong>LOGIN</strong>
                        </div>
                        <div class="id_box">
                            <ul>
                                <li><span class="bfont">아이디</span>
                                    <input type="text" name="_mgrId" id="_mgrId" title="아이디" class="input1" 
                                        value="<c:out value="${cookieMgrId}" />" placeholder="ID를_입력하세요"/>
                                </li>
                                <li><span class="bfont">비밀번호</span>
                                    <input type="password" name="_mgrEncPwd" id="_mgrEncPwd" title="비밀번호" class="input1" value="" placeholder="비밀번호를_입력하세요"  />
                                </li>
                            </ul>
                        </div>
                        <input type="submit" class="btn" value="접속하기" />
                    </form:form>
                    <div id="publicKey" style="display: none;"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="footer">
        &nbsp;<strong>${CONSTANT.CLIENT_NM}</strong> ${CONSTANT.SYSTEM_NM}
        <span class="right">
            Copyright @2007 <a href="http://www.srpost.co.kr" target="_blank">SR-POST</a>, 
            ${CONSTANT.APP_NAME} version ${CONSTANT.APP_VERSION} (Build ${CONSTANT.APP_BUILD})&nbsp;&nbsp;
        </span>
    </div>
    
    <%-- 임시 : 빠른 로그인 --%>
    <c:if test="${CONSTANT.IS_DEV_MODE}">
	    <div style="position: absolute; top: 10px; right: 10px;">
	        <c:import url="/WEB-INF/jsp/bo/common/include/incQuickLogin.jsp" charEncoding="UTF-8">
	            <c:param name="size">12</c:param>
	        </c:import>
	    </div>
    </c:if>
    
    <c:if test="${CONSTANT.IS_DEV_MODE}">    
        <div style="position: absolute; top: 10px; left: 10px;">
            <span style="color: #CA4A4A; font-weight: bold; font-size: 24px;">DEVELOPMENT MODE</span>
        </div>
    </c:if>

    <sm:js names="jsencrypt"/>
    <script type="text/javascript">
        $().ready(function() {
            <%--
            <c:if test="${isLogout}">
            	alert("성공적으로 로그아웃 되었습니다.");
            </c:if> --%>
            <c:if test="${not empty message}">
                alert("${message}");
            </c:if>
            
            $.ajax({
                url: "<c:url value='/bo/base/login/TR_publicKey.do'/>",
                type: "GET",
                xhrFields: {
                    withCredentials: true
                },
                success: function (result) {
                    $("#publicKey").text(result);
                },
                error: function (xhr, status, error) {
                    alert("Status: " + status + "\nResponse: " + xhr.responseText + "\nError: " + error);
                }
            });
        });
        
        var js_loginAction = function() {
        	
            var mgrId = $("form[name=dataForm] #_mgrId");
            var mgrEncPwd = $("form[name=dataForm] #_mgrEncPwd");
            if (mgrId.val() == "") {
                alert("ID를_입력하세요"); mgrId.focus(); return false;
            }
            if (mgrEncPwd.val() == "") {
                alert("비밀번호를_입력하세요"); mgrEncPwd.focus(); return false;
            }
    		
            mgrId.attr("readonly", true);
            mgrEncPwd.attr("readonly", true);
            
            var jsEncrypt = new JSEncrypt();
            jsEncrypt.setPublicKey($("#publicKey").text());

            $("form[name=dataForm] #mgrId").val(jsEncrypt.encrypt(mgrId.val()));
            $("form[name=dataForm] #mgrEncPwd").val(jsEncrypt.encrypt(mgrEncPwd.val()));

            $("form[name=dataForm]").attr("action", "<c:url value="/bo/base/login/NR_loginAction.do"/>");
    		
            return true;
        };
    </script>
</c:if>

</body>
</html>