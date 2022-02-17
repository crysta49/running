<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>
<c:set var="mgrSession" value="${sessionScope[CONSTANT.MGR_SESSION_KEY]}" />

<html>
<head>
    <title>${curMenuBean.menuNm}</title>
    <meta name="title" content="부재정보를 설정/해지합니다." />
</head>
 
<body>

<form:form id="csrfForm" name="csrfForm"></form:form>

<c:if test="${not empty dataBean}">

    <div class="bg-box-big text-center f-18" id="boxBig">
        <b>${mgrSession.mgrNm}</b>님은 현재 <span class="text-primary f-bold">부재중</span>으로 설정되어 있습니다.
    </div>
    
    <div class="blank"></div>
    
    <table class="tbl-view">
        <colgroup>
            <col class="th">
            <col>
            <col class="th">
            <col>
        </colgroup>
        <tr>
            <th>부재사유</th>
            <td colspan="3">
                ${dataBean.absenceNm}
                <c:if test="${not empty dataBean.absenceReason}">
                    (${dataBean.absenceReason})
                </c:if>
            </td>
        </tr>
        <tr>
            <th>대리인</th>
            <td colspan="3">${dataBean.agencyNm}</td>
        </tr>
        <tr>
            <th>시작일시</th>
            <td>${dataBean.startDt}</td>
            <th>종료일시</th>
            <td>${dataBean.endDt}</td>
        </tr>
        <tr>
            <th>등록일</th>
            <td>${dataBean.regDt}</td>
            <th>수정일</th>
            <td>${dataBean.modiDt}</td>
        </tr>
    </table>
    
    <sm:button-layout group="true">
        <sm:button value="삭제" glyph="remove" onclick="js_deleteAction(this);"/>
        <sm:button value="수정" glyph="edit" onclick="js_updateForm('${dataBean.mgrId}');"/>
    </sm:button-layout>

</c:if>

<c:if test="${empty dataBean}">
	<c:if test="${not empty handOverList}">

        <div class="bg-box-big text-center f-18">
            <b class="text-primary">${mgrSession.mgrNm}</b>님은 아래 표시된 직원의 업무 <span class="text-danger bold">대리인</span>으로 설정되어 있어 부재중 설정을 할 수 없습니다.
        </div>
        
        <div class="blank"></div>
        
        <table class="tbl-list" style="table-layout: auto;">
            <colgroup>
                <col width="100">
                <col width="100">
                <col>
            </colgroup>
            <tr>
                <th>직원명</th>
                <th>부재사유</th>
                <th>부재기간</th>
            </tr>
            <c:forEach items="${handOverList}" var="item">
                <tr>
                    <td>${item.mgrNm}</td>
                    <td>${item.absenceNm}</td>
                    <td>${item.startDt} ~ ${item.endDt}</td>
                </tr>
            </c:forEach>
        </table>
	</c:if>
    
    <c:if test="${empty handOverList}">
        <div class="bg-box-big text-center f-18">
            <b>${mgrSession.mgrNm}</b>님은 현재 <span class="text-primary bold">근무중</span>으로 설정되어 있습니다.
            
            <div class="blank"></div>
            <div style="color: #707070;" class="f-14">부재중으로 설정하실려면 아래 등록 버튼을 클릭하세요.</div>
            
            <div class="blank"></div>&nbsp;
            <div class="blank-2x"></div>
            <sm:button-layout align="center">
                <sm:button value="등록" glyph="" btnSize="btn-md" onclick="js_updateForm('');"/>
            </sm:button-layout>
        </div>
    </c:if>    
</c:if>

<script type="text/javascript">

    $(document).ready(function(){
        
        var date = new Date();
        var startDtPlain = "${dataBean.startDtPlain}",
            endDtPlain = "${dataBean.endDtPlain}",
            today = js_dateFullConvert(date);
        
        if (startDtPlain != "" && endDtPlain != "") {
            console.log(startDtPlain < today);
            console.log(endDtPlain > today);
            if (startDtPlain < today && endDtPlain > today ) {
                $("#boxBig").empty().append('<b>${mgrSession.mgrNm}</b>님은 현재 <span class="text-primary f-bold">부재중</span>으로 설정되어 있습니다.');
            }
            else {
                $("#boxBig").empty().append('<b>${mgrSession.mgrNm}</b>님의 부재중 설정 내역입니다.');
            }
        }
    });
    
    var js_deleteAction = function(e) {
        if ( confirm("정말 삭제하시겠습니까?") ) {
            
            SM.submit(e, {
                url: "TR_deleteAction.do",
                data: {
                    CSRFToken: $("#csrfForm input[name=CSRFToken]").val()
                }
            }, 
            function(messages, xhr) {
                if (messages.code == 200) {
                    self.location.reload();
                }
            });
        }
    };
    
    var js_updateForm = function(mgrId) {
        self.location.href = "NR_form.do?mgrId=" + mgrId;
    };
    
    var js_dateFullConvert = function(date) {
        
        return date.getFullYear() + 
               js_numberConvert(date.getMonth()+1) + 
               js_numberConvert(date.getDate()) + 
               js_numberConvert(date.getHours()) +
               js_numberConvert(date.getMinutes()) +
               js_numberConvert(date.getSeconds());
    }
</script>

</body>
</html>