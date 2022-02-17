<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<c:set var="exist" value="${not empty dataBean.ipSeq}" />

<form:form commandName="dataBean" id="dataForm" name="dataForm" autocomplete="off">
    <form:hidden path="ipSeq" />
    <form:hidden path="startIp" />
    <form:hidden path="endIp" />
    
    <table class="tbl-header">
        <tr>
            <th><span class="title-big">접속가능 IP ${exist ? "수정" : "등록"}</span></th>
            <td class="tr"><span class="required">표시는 필수입력 항목입니다.</span></td>
        </tr>
    </table>

    <table class="tbl-view tbl-form">
        <colgroup>
            <col width="140">
            <col>
        </colgroup>
        <tr>
            <th>IP 명<em>&nbsp;</em></th>
            <td>
                <form:input path="ipNm" cssClass="smf-text" size="30"/>
            </td>
        </tr>
        <tr>
            <th>IP 주소<em>&nbsp;</em></th>
            <td>
                <div style="float:left;">
                    <input type="text" id="ip1" name="ip1" class="smf-text" size="5" />&#44;
                    <input type="text" id="ip2" name="ip2" class="smf-text" size="5" />&#44;
                    <input type="text" id="ip3" name="ip3" class="smf-text" size="5" />&#44;
                    <input type="text" id="ip4" name="ip4" class="smf-text" size="5" />
                </div>
                <div id="bandDiv" style="float:left; display:none; margin-left:10px;">
                    &#126; <input type="text" id="ip5" name="ip5" class="smf-text" size="5" />
                </div>
                <div style="padding-top:9px;">
                    <input type="checkbox" id="bandYn" style="margin:0 3px 0 10px;" /><label for="bandYn" style="vertical-align:3px; margin-left:3px;">대역지정하기</label>
                </div>
            </td>
        </tr>
        <tr>
            <th>사용 여부<em>&nbsp;</em></th>
            <td>
                <form:radiobutton path="useYn" value="Y" label="사용" cssClass="smf-radio"/>
                <form:radiobutton path="useYn" value="N" label="미사용" cssClass="smf-radio"/>
            </td>
        </tr>
    </table>
    
    <sm:button-layout>
        <sm:button value="취소" glyph="" cssClass="btn-link" onclick="js_cancelAction('${dataBean.ipSeq}');" />
        <sm:button type="submit" value="${exist ? '수정' : '등록'}" glyph="saved" />
    </sm:button-layout>
</form:form>

<script type="text/javascript">

Ext.onReady(function() {

    $("#dataForm").validate({
        rules: {
            ipNm  : { required: true, maxlength: 20 },
            ip1   : { required: true, number: true, range: [0, 255] },
            ip2   : { required: true, number: true, range: [0, 255] },
            ip3   : { required: true, number: true, range: [0, 255] },
            ip4   : { required: true, number: true, range: [0, 255] },
            ip5   : { required: false, number: true, range: [0, 255] },
            useYn : { required: true }
        }, 
        submitHandler: function(form) {
            
            var startIp = "";
            var endIp = "";
            
            startIp = $("#ip1").val() + "." + $("#ip2").val() + "." + $("#ip3").val() + "." + $("#ip4").val();
            endIp = startIp;

            if ( $("#bandYn").is(":checked") ) {
                if( $("#ip5").val() == "" ) {
                    alert("IP 대역을 지정해주세요."); $("#ip5").focus(); return false;
                } else {
                    endIp = $("#ip1").val() + "." + $("#ip2").val() + "." + $("#ip3").val() + "." + $("#ip5").val();
                }
            }
             
            $("#startIp").val(startIp);
            $("#endIp").val(endIp);
            
            if ( confirm("${exist ? '수정하시겠습니까?' : '등록하시겠습니까?'}") ) {
                
                SM.submit(form, {
                    url: "${exist ? 'TR_updateAction.do' : 'TR_insertAction.do'}"
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        SM.getCmp("gridPanel").store.reload();
                        $("#viewDiv").html("");
                    }
                });
            }
            
        }
    });
    
    $("#bandYn").change(function(){
        if( $(this).is(":checked") ) {
            $("#bandDiv").show();
        }
        else {
            $("#bandDiv").hide();
            $("#ip5").val("");
        }
    });
    
    <c:if test="${not empty dataBean.startIp}">
        var startIpArr = $("#startIp").val().split(".");
        var endIpArr = $("#endIp").val().split(".");
        
        $("#ip1").val(startIpArr[0]);
        $("#ip2").val(startIpArr[1]);
        $("#ip3").val(startIpArr[2]);
        $("#ip4").val(startIpArr[3]);
        
        if( $("#startIp").val() != $("#endIp").val() ) {
            $("#bandYn").attr("checked", "checked").change();
            $("#ip5").val(endIpArr[3]);
        }
    </c:if>
    
});


</script>

        
