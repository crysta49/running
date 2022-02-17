<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>스케줄러 실행</title>
</head>

<body>

<form:form id="csrfForm" name="csrfForm"></form:form>

<table class="tbl-header">
    <tr>
        <th>
            <span class="title-big">스케줄러 실행</span>
            <span class="title-small">시스템에 등록된 스케줄러를 수동으로 실행합니다.</span>
        </th>
    </tr>
</table>
<div class="panel panel-default">
    <div class="panel-body">
        <fieldset>
            <legend>캐시 정보</legend>
            <ul class="bullet">
                <li>스케줄러 실행은 시스템에 민감한 영향을 줄 수 있으므로, 운영팀(유지보수팀) 업무 담당자만 실행해야 합니다.</li>
            </ul>
            <div class="blank"></div>
            <div>
                <select name="schdNm" id="schdNm" class="smf-select">
                    <option value="">-- 스케줄러 선택 --</option>
                    <option value="multipleCacheReloadScheduler">MultipleCacheReloadScheduler</option>
                    <option value="mgrAbsenceCheckScheduler">MgrAbsenceCheckScheduler</option>
                    <option value="taScheduler">TaScheduler</option>
                    <option value="searchRealTimeScheduler">SearchRealTimeScheduler</option>
                </select>&nbsp;
                <sm:button value="실행" glyph="saved" onclick="js_executeAction(this);"/>
            </div>
        </fieldset>
    </div>
</div>
    
<div class="blank-2x"></div>

<script type="text/javascript">

    Ext.onReady(function() {

    });
    
    var js_executeAction = function(e) {
        
        var schdNm = $("#schdNm").val();
        if (schdNm == "") {
            alert("스케줄러를 선택하세요."); $("#schdNm").focus(); return false;
        }
        
        SM.submit(e, {
            url: "TR_executeAction.do",
            data: { 
                schdNm: schdNm,
                CSRFToken: $("#csrfForm input[name=CSRFToken]").val()
            }
        }, function(messages, xhr) {
            if (messages.code == 200) {
            }
        });
    };
</script>
    
</body>
</html>