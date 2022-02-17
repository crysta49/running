<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>${curMenuBean.menuNm}</title>
    <meta name="title" content="시스템 캐시 정보를 조회, 변경 시 다시읽기 등을 수행합니다." />
    <sm:css names="syntaxhighlighter" />
</head>

<body>

<form:form id="csrfForm" name="csrfForm"></form:form>

<table class="tbl-header">
    <tr>
        <th>
            <span class="title-big">캐시 관리</span>
            <span class="title-small">대상 캐시정보를 선택한 후 다시 읽기 버튼을 클릭하세요.</span>
        </th>
    </tr>
</table>

<div class="panel panel-default">
    <div class="panel-body">
        <fieldset>
            <legend>캐시 정보</legend>
            <ul class="bullet">
                <li>캐시정보는 자주 사용하는 정보를 빠르게 조회하기 위해 미리 데이타베이스에서 메모리에 로드한 정보입니다.</li>
                <li>해당 정보가 변경되었다면 캐시 다시 읽기를 통해 변경된 정보를 메모리에 다시 로드해야 합니다.</li>
                <c:if test="${fn:length(serverList) <= 1}">
                    <li>현재 <strong>단일 서버</strong> 환경으로 설정되어 있습니다.</li>
                </c:if>
                <c:if test="${fn:length(serverList) > 1}">
                    <li>현재 <strong>다중 서버</strong> 환경으로 설정되어 있습니다.<br/>대상서버 : 
                        <c:forEach items="${serverList}" var="value" varStatus="status">
                            ${value}<c:if test="${!status.last}">, </c:if>
                        </c:forEach>
                    </li>
                </c:if>
            </ul>
        </fieldset>
        
        <div class="blank"></div>
        
        <fieldset>
            <legend>캐시 목록</legend>
            <div>
                <select id="cacheClass" class="smf-select">
                    <option value="">-- 선택하세요. --</option>
                <c:forEach items="${cacheList}" var="item">
                    <c:if test="${item.id != 'MenuFrontCache' }">
                        <option value="${item.id}">${item.name}</option>
                    </c:if>
                </c:forEach>
                </select>&nbsp;
                <sm:button value="다시 읽기" cssClass="btn-warning" glyph="repeat" onclick="js_reloadAction(this);"/>
            </div>
        </fieldset>
        
        <div class="blank"></div>
        
        <div id="viewDiv"></div>
    </div>        
</div>

<sm:js names="syntaxhighlighter" />
<script type="text/javascript">

    Ext.onReady(function() {
        $("#cacheClass").change(function() {
            if (this.value != "") {
                $("#viewDiv").SM_LOAD("AR_view.do", {
                    id: this.value
                });
            }
        });
    });
    
    var js_reloadAction = function(e) {
        
        var cacheClass = $("#cacheClass").val();
        if (cacheClass != "") {
            SM.submit(e, {
                url: "TR_reloadAction.do",
                data: { 
                    id: cacheClass,
                    CSRFToken: $("#csrfForm input[name=CSRFToken]").val()
                }
            }, function(messages, xhr) {
                if (messages.code == 200) {
                    $("#viewDiv").SM_LOAD("AR_view.do", {
                        id: cacheClass
                    });
                }
            });
        }
    };
</script>
    
</body>
</html>