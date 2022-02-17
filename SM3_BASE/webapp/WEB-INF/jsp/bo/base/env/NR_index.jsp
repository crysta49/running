<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>${curMenuBean.menuNm}</title>
    <meta name="title" content="서버, 메모리, 환경변수, 로그정보 등의 시스템 환경정보를 조회합니다." />
</head>
 
<body>

<form:form id="csrfForm" name="csrfForm"></form:form>

<ul class="nav nav-tabs">
    <li class="active"><a href="AR_server.do">서버 정보</a></li>
    <li><a href="AR_was.do">WAS 정보</a></li>
    <li><a href="AR_property.do">환경 변수</a></li>
    <li><a href="AR_classpath.do">클래스 경로</a></li>
    <li><a href="AR_dualServerInfo.do">이중화 설정 정보</a></li>
    <li><a href="AR_log.do">로그파일 정보</a></li>
    <li><a href="AR_license.do">라이센스 정보</a></li>
</ul>

<div class="blank-2x"></div>

<div id="viewDiv"></div>

<sm:css names="syntaxhighlighter" />
<sm:js names="smgrid, syntaxhighlighter" />
<script type="text/javascript">
    Ext.onReady(function () {
        $("#viewDiv").SM_LOAD("AR_server.do");
        
        $(".nav-tabs > li > a").click(function(e) {
            var $this = $(this),
                loadurl = $this.attr('href'),
                targ = $this.attr('data-target');
        
            $("#viewDiv").SM_LOAD(loadurl);
        
            $this.tab("show");
            return false;
        });
    });
    
    var js_findClassAction = function() {
        var clazz = $("#clazz").val();
        if (clazz == "") {
            alert("대상 클래스 경로를 입력하세요."); $("#clazz").focus(); return false;
        }
        $("#jarPathDiv").SM_LOAD("TR_findClassAction.do", {
            clazz: $("#clazz").val(),
            CSRFToken: $("#csrfForm input[name=CSRFToken]").val()
        }, function() {
            $("#jarPathDiv").show();
        });  
    };
    
    var js_logDownload = function(file) {
        
        self.location.href = CTX_PATH + "/common/file/NR_logDownload.do?fn=" + file;
    };
</script>

</body>
</html>