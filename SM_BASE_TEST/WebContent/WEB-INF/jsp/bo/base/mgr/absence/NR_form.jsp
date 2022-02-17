<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>
<c:set var="mgrSession" value="${sessionScope[CONSTANT.MGR_SESSION_KEY]}" />

<c:set var="exist" value="${not empty dataBean.mgrId}" />

<html>
<head>
    <title>부재중 정보 ${exist ? "수정" : "등록"}</title> 
</head>
 
<body>

<table class="tbl-header">
    <tr>
        <th><span class="title-big">부재중 정보 ${exist ? "수정" : "등록"}</span></th>
        <td class="tr"><span class="required">표시는 필수입력 항목입니다.</span></td>
    </tr>
</table>

<form:form commandName="dataBean" id="dataForm" name="dataForm" autocomplete="off">
    <form:hidden path="startDt"/>
    <form:hidden path="endDt"/>
    
    <table class="tbl-view tbl-form">
        <colgroup>
            <col class="th">
            <col>
        </colgroup>
        <tr>
            <th>부재사유<em>&nbsp;</em></th>
            <td>
                <sm:code id="absenceCd" grpCd="MGR_ABSNS_RSN" type="radio" />
                &nbsp;
                <form:input path="absenceReason" cssClass="smf-text" size="50" disabled="true"/>
            </td>
        </tr>
        <tr>
            <th>대리인<em>&nbsp;</em></th>
            <td>
                <form:hidden path="agencyId"/>
                <input type="text" name="agencyNm" id="agencyNm" value="${dataBean.agencyNm}" size="20" readonly="readonly" class="smf-text"/>
                <sm:button value="대리인 선택" glyph="" cssClass="btn-default" onclick="js_showAgencyPop('');"/>
            </td>
        </tr>
        <tr>
            <th>시작일시<em>&nbsp;</em></th>
            <td>
                <div id="startDate" data-value="${fn:substring(dataBean.startDt, 0, 10)}" class="smf-date"></div>
                            
                <c:set var="startHour" value="${fn:substring(dataBean.startDtPlain, 8, 10)}" />
                <c:set var="startMin" value="${fn:substring(dataBean.startDtPlain, 10, 12)}" />
                
                <select name="startHour" id="startHour" class="smf-select">
                    <c:forEach begin="0" end="23" var="hour">
                        <c:if test="${hour < 10}"><c:set var="hour" value="0${hour}" /> </c:if>
                        <option value="${hour}" <c:if test="${startHour == hour}">selected="selected"</c:if>>${hour}시</option>
                    </c:forEach>
                </select>
                <select name="startMin" id="startMin" class="smf-select">
                    <c:forEach begin="0" end="59" var="min">
                        <c:if test="${min < 10}"><c:set var="min" value="0${min}" /> </c:if>
                        <option value="${min}" <c:if test="${startMin == min}">selected="selected"</c:if>>${min}분</option>
                    </c:forEach>
                </select>
            </td>
        </tr>
        <tr>
            <th>종료일시<em>&nbsp;</em></th>
            <td>
                <div id="endDate" data-value="${fn:substring(dataBean.endDt, 0, 10)}" class="smf-date"></div>
                            
                <c:set var="endHour" value="${fn:substring(dataBean.endDtPlain, 8, 10)}" />
                <c:set var="endMin" value="${fn:substring(dataBean.endDtPlain, 10, 12)}" />
                
                <select name="endHour" id="endHour" class="smf-select">
                    <c:forEach begin="0" end="23" var="hour">
                        <c:if test="${hour < 10}"><c:set var="hour" value="0${hour}" /> </c:if>
                        <option value="${hour}" <c:if test="${endHour == hour}">selected="selected"</c:if>>${hour}시</option>
                    </c:forEach>
                </select>
                <select name="endMin" id="endMin" class="smf-select">
                    <c:forEach begin="0" end="59" var="min">
                        <c:if test="${min < 10}"><c:set var="min" value="0${min}" /> </c:if>
                        <option value="${min}" <c:if test="${endMin == min}">selected="selected"</c:if>>${min}분</option>
                    </c:forEach>
                </select>
            </td>
        </tr>
    </table>
    
    <sm:button-layout>
        <sm:button value="취소" glyph="" cssClass="btn-link" onclick="js_cancelAction('');"/>
        <sm:button type="submit" value="저장" glyph="saved" />
    </sm:button-layout>

</form:form>

<sm:js names="validation" />
<script type="text/javascript">
    
    // 지정된 대리인 정보 저장소
    var agencyDatas = [];

    $(document).ready(function(){
        
        $("#dataForm").validate({
            rules: {
                absenceCd: { required: true },
                agencyNm: { required: true },
                startDate: { required: true },
                endDate: { required: true }
            }, 
            submitHandler: function(form) {

                var absenceCd = $("input[name=absenceCd]:checked").val();
                if ( !absenceCd ) {
                    alert("부재사유를 선택하세요."); return;
                }
                if (absenceCd == 303 && $("#absenceReason").val() == "") {
                    alert("부재사유 기타 내용을 입력하세요."); $("#absenceReason").focus(); return;
                }
                
                var startDate = $("input[name=startDate]").val();
                var endDate = $("input[name=endDate]").val();
                
                if ( startDate == "" || endDate == "" ) {
                    alert("시작일시와 종료일시를 지정하세요"); return;
                }
                
                var startDt = startDate.split("-").join("")
                                    .concat($("#startHour").val())
                                    .concat($("#startMin").val()) + "00";
                var endDt = endDate.split("-").join("")
                                    .concat($("#endHour").val())
                                    .concat($("#endMin").val()) + "00";
                
                if (endDt <= startDt) {
                    alert("종료일시가 시작일시보다 작거나 같습니다.\n\n설정기간을 확인해 주세요."); return;
                }
                
                var today = "${today}";

                if (endDt < today) {
                    alert("종료일시는 현재 시간 보다 커야 합니다."); return;
                }
                
                $("#startDt").val(startDt);
                $("#endDt").val(endDt);
                
                // 부재중 기간 내 중복 요청 목록
                $.get("JR_listAgencyOver.do", {
                    startDt: startDt,
                    endDt: endDt,
                    mgrId: "${mgrSession.mgrId}"
                }, function(data) {
                    
                    var returnText = "부재중 설정이 중복됩니다.\n";
                    $.each(data, function(idx, data) {
                        returnText = returnText + data.mgrNm + " : " + data.startDt + " ~ " + data.endDt + "\n"
    	            });
                    alert(returnText);
                })
                .fail(function() {
                    
                    SM.submit(form, {
                        url: "${exist ? 'TR_updateAction.do' : 'TR_insertAction.do'}"
                    }, function(messages, xhr) {
                        if (messages.code == 200) {
                            self.location.href = "NR_index.do";
                        }
                    });
                });
            }
        });
        
        $(".smf-date").SM_DATEPICKER({ editable: false, minValue : new Date() });
        
        $("input[name=absenceCd]").click(function() {
            if (this.value == 303) {
                $("#absenceReason").attr("disabled", false);
            }
            else {
                $("#absenceReason").attr("disabled", true).val("");
            }
        });
        
        var absencdCd = "${dataBean.absenceCd}";
        if (absencdCd != "")
            $("input[name=absenceCd][value="+ absencdCd +"]").click();
        else
            $("input[name=absenceCd]")[0].click();
    });
    
    var js_showAgencyPop = function() {
        SM.modal({
            title: "대리인 지정",
            width: 670,
            height: 570,
            y: -1,
            loadUrl: "PR_agencyList.do?mgrId=${mgrSession.mgrId}"
        });
    };
    
    var js_setAgencyValues = function(datas) {

        // TODO : 대리인이 다른 사람의 대리로 기 등록되었는지 체크
        // 여러 사람의 대리인으로 등록이 가능하도록 정책을 정하면 체크 필요 없음 
        
        var _datas = [];
        Ext.each(datas, function(item, i){
            _datas.push([item.deptNm, item.mgrId, item.mgrNm]);
            
            $("input[name=agencyId]").val(item.mgrId);
            $("input[name=agencyNm]").val(item.mgrNm);
        });
        agencyDatas = _datas;
    };
    
    var js_cancelAction = function() {
        self.location.href = "NR_index.do";
    };
</script>

</body>
</html>