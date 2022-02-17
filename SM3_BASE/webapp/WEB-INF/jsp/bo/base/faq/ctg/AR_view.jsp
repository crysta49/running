<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<c:set var="exist" value="${not empty dataBean && dataBean.ctgCd ne '0'}" />

<c:if test="${exist}">
    
    <form:form commandName="dataBean" id="updateForm" name="updateForm" autocomplete="off" onsubmit="false">
        <form:hidden path="ctgCd"/>

        <table class="tbl-header">
            <tr>
                <th><span class="title-big">분류 상세정보</span></th>
                <td class="tr"><span class="required">표시는 필수입력 항목입니다.</span></td>
            </tr>
        </table>
        
        <table class="tbl-view tbl-form">
            <colgroup>
                <col class="th">
                <col>
                <col class="th">
                <col>
            </colgroup>
            <tr>
                <th>분류 경로</th>
                <td colspan="3" class="plain"><span id="treePath"></span></td>
            </tr>
            <tr>
                <th>분류 코드</th>
                <td class="plain">
                    <span id="nodeId">${dataBean.ctgCd}</span>
                </td>
                <th>정렬 순서
                    <span class="t3-help smtip">&nbsp;</span>
                    <div class="sr-hidden">
                        <div class="smtip-title">정렬 순서</div>
                        <div class="smtip-text">
                            <div>좌측 분류목록에서 드래그 앤 드랍을 통해 정렬순서를 변경할 수 있습니다.</div>
                        </div>
                    </div>
                </th>
                <td id="orderNo" class="plain">
                    ${dataBean.orderNo}
                </td>
            </tr>
            <tr>
                <th>분류 명<em>&nbsp;</em></th>
                <td colspan="3">
                    <form:input path="text" size="40" cssClass="smf-text" onkeydown="if(event.keyCode==13) {js_enterKeyCheck('update'); return false;}"/>
                </td>
            </tr>
            <tr>
                <th>사용 여부</th>
                <td colspan="3">
                    <form:radiobutton path="useYn" value="Y" label="사용" cssClass="smf-radio" />
                    <form:radiobutton path="useYn" value="N" label="미사용" cssClass="smf-radio"/>
                </td>
            </tr>
            <tr>
                <th>등록일</th>
                <td class="plain">${dataBean.regDt}</td>
                <th>최종 수정일</th>
                <td class="plain">${dataBean.modiDt}</td>
            </tr>
        </table>

        <sm:button-layout group="true">
            <sm:button value="삭제" glyph="remove" onclick="SM.getCmp('treePanel').smDelete(this);" />
            <sm:button value="수정" glyph="saved" onclick="SM.getCmp('treePanel').smUpdate(this, '#updateForm');" id="updateBtn" />
        </sm:button-layout>

    </form:form>
    
    <div class="blank-2x"></div>
</c:if>

<form:form id="insertForm" name="insertForm" onsubmit="false">

    <table class="tbl-header">
        <tr>
            <th><span class="title-big">분류 추가</span></th>
            <td class="tr"><span class="required">표시는 필수입력 항목입니다.</span></td>
        </tr>
    </table>
    
    <table class="tbl-view tbl-form">
        <colgroup>
            <col class="th">
            <col>
        </colgroup>
        <tr>
            <th>분류 명<em>&nbsp;</em></th>
            <td>
                <input type="text" name="newText" id="newText" class="smf-text" size="40" onkeydown="if(event.keyCode==13) {js_enterKeyCheck('insert'); return false;}" />
            </td>
        </tr>
        <tr>
            <th>추가 옵션</th>
            <td>
                <div style="margin: 4px 0;">
                    <div><input type="radio" name="appendOption" id="isSame" value="isSame" class="smf-radio"
                        <c:if test="${!exist}">disabled="disabled"</c:if> /><label for="isSame">선택한 분류 동일 레벨에 추가</label></div>
        
                    <div><input type="radio" name="appendOption" id="isChild" value="isChild" class="smf-radio"
                        <c:if test="${!exist}">disabled="disabled"</c:if> /><label for="isChild">선택한 분류 하위 레벨에 추가</label></div>
        
                    <div><input type="radio" name="appendOption" id="isRoot" value="isRoot" class="smf-radio"
                        checked="checked" /><label for="isRoot">루트 분류에 추가</label></div>
                </div>
            </td>
        </tr>
    </table>

    <sm:button-layout>
        <sm:button value="저장" glyph="saved" onclick="SM.getCmp('treePanel').smInsert(this, '#insertForm');" id="insertBtn" />
    </sm:button-layout>
</form:form>

<script type="text/javascript">
    Ext.onReady(function() {
        
        if ( $("#updateForm") ) {
            $("#updateForm").validate({
                rules: {
                    text: { required:true, minlength:2, maxlength:30 }
                }
            });
        }

        $("#insertForm").validate({
            rules: {
                newText: { required:true, minlength:2, maxlength:30 }
            }
        });
        
        $(".smtip").each(function() {
            $(this).qtip({
                content: {
                    title: $(this).next().find(".smtip-title"),
                    text: $(this).next().find(".smtip-text")
                },
                position: {
                    my: "bottom center",
                    at: "top center"
                }
            });
        });
    });
    
    var js_enterKeyCheck = function(action) {
        
    	$("#"+action+"Btn").click();
    }
</script>
