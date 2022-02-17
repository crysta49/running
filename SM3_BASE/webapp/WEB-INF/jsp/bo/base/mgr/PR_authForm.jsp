<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>직원 권한할당</title>
    <style type="text/css">
        input[type=checkbox], input[type=radio], label { margin: 0; }
    </style>
</head>
 
<body>

<form:form id="csrfForm" name="csrfForm"></form:form>

<table class="tbl-header">
    <tr>
        <th>
            <span class="title-big"><c:out value="${smp.mgrNm}"/>님, 할당 대상 권한그룹 선택</span>
        </th>
    </tr>
</table>
<table class="tbl-view">
    <colgroup>
        <col style="width: 30px">
        <col>
    </colgroup>
    <c:forEach items="${dataList}" var="item">
        <tr>
            <th class="text-center">
                <input type="checkbox" name="authCds" id="id_${item.authCd}" value="${item.authCd}^Y" 
                    ${item.checked == 'Y' ? 'checked="checked"' : ''} class="smf-checkbox" />
            </th>
            <td><label for="id_${item.authCd}">${item.authNm}</label></td>
            <c:if test="${item.authCd == '2001' && item.checked == 'Y'}">
                <c:set var="isReceiver" value="Y"/>
            </c:if>
        </tr>
    </c:forEach>
</table>

<sm:button-layout align="both">
    <div class="col-xs-6">
        <input type="checkbox" id="checkAll" class="smf-checkbox" /> <label for="checkAll">전체선택</label>
    </div>
    <div class="col-xs-6 text-right">
        <sm:button value="저장" glyph="saved" onclick="js_saveAction(this);" />
    </div>
</sm:button-layout>


<script type="text/javascript">

    Ext.onReady(function(){
        
        $("#checkAll").click(function() {
            var checked = this.checked;
            $("input[name=authCds]").each(function() {
                this.checked = checked;
            });
        });
    });

    var js_saveAction = function(e) {
        var authCds = [];
        $("input[name=authCds]:checked").each(function (i) {
            authCds.push($(this).val());
        });

        if ( authCds.length == 0 ) {
            if (!confirm("선택된 권한그룹이 없습니다.\n\n그래도 계속 진행하시겠습니까?")) {
                return false; 
            }
        }
        
        SM.submit(e, {
            url: "TR_updateAuthAssignAction.do",
            data: {
                mgrId: "${smp.mgrId}",
                authCds: authCds,
                CSRFToken: $("#csrfForm input[name=CSRFToken]").val()
            }
        }, function(messages, xhr) {
            if (messages.code == 200) {
                SM.modalClose();
            }
        });
    };
    
</script>

</body>
</html>