<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<c:set var="exist" value="${not empty dataBean.grpCd}" />

<form:form commandName="dataBean" id="dataForm" name="dataForm" autocomplete="off">

    <table class="tbl-header">
        <tr>
            <th><span class="title-big">그룹코드 ${exist ? "수정" : "등록"}</span></th>
            <td class="tr"><span class="required">표시는 필수입력 항목입니다.</span></td>
        </tr>
    </table>
    
    <table class="tbl-view tbl-form">
        <colgroup>
            <col class="th">
            <col>
        </colgroup>
        <tr>
            <th>그룹코드<em>&nbsp;</em></th>
            <td>
                <form:input path="grpCd" size="20" cssClass="smf-text" readonly="${exist ? 'true' : 'false'}"/>
            </td>
        </tr>
        <tr>
            <th>그룹코드명<em>&nbsp;</em></th>
            <td>
                <form:input path="grpNm" size="40" cssClass="smf-text"/>
            </td>
        </tr>
    </table>
    
    <sm:button-layout group="true">
        <c:if test="${exist}">
            <sm:button value="삭제" glyph="remove" onclick="CODE.deleteAction(this, '${dataBean.grpCd}');"/>
        </c:if>
        <sm:button type="submit" value="${exist ? '수정' : '등록'}" glyph="saved"/>
    </sm:button-layout>
</form:form>


<script type="text/javascript">
    $(document).ready(function(){

        $("#dataForm").validate({
            rules: {
                grpCd: { required:true, codevalue: true, minlength:1, maxlength:20 },
                grpNm: { required:true, maxlength:50 }
            }, 
            submitHandler: function(form) {
                
                SM.submit(form, {
                    url: "${exist ? 'TR_updateAction.do' : 'TR_insertAction.do'}"
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        SM.getCmp("grpPanel").store.reload();
                        $("#grpViewDiv").html("");
                        
                        js_cacheReloadAction(form);
                    }
                });
            }
        });
    });
</script>
