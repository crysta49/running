<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<c:set var="exist" value="${not empty dataBean.authCd}" />

<c:if test="${empty dataBean.manageYn or dataBean.manageYn == 'Y'}">
    
    <form:form commandName="dataBean" id="dataForm" name="dataForm" autocomplete="off">
        <form:hidden path="authCd"/>
        
        <table class="tbl-header">
            <tr>
                <th><span class="title-big">권한 ${exist ? "수정" : "등록"}</span></th>
                <td class="tr"><span class="required">표시는 필수입력 항목입니다.</span></td>
            </tr>
        </table>
        
        <table class="tbl-view tbl-form">
            <colgroup>
                <col class="th">
                <col>
            </colgroup>
            <tr>
                <th>권한명<em>&nbsp;</em></th>
                <td>
                    <form:input path="authNm" size="40" cssClass="smf-text"/>
                </td>
            </tr>
            <tr>
                <th>권한설명</th>
                <td>
                    <form:textarea path="authDesc" rows="4" cssClass="smf-ta"/>
                </td>
            </tr>
        </table>
        
        <sm:button-layout group="true">
            <c:if test="${exist}">
                <sm:button value="삭제" glyph="remove" onclick="AUTH.deleteAction(this, '${dataBean.authCd}');" />
            </c:if>
            <sm:button type="submit" value="${exist ? '수정' : '등록'}" glyph="saved"/>
        </sm:button-layout>
    
    </form:form>
    
    
    <script type="text/javascript">
        Ext.onReady(function() {
    
            $("#dataForm").validate({
                rules: {
                    authNm: { required:true, maxlength:15 },
                    authDesc: { maxlength:65 }
                }, 
                submitHandler: function(form) {
                    
                    SM.submit(form, {
                        url: "${exist ? 'TR_updateAction.do' : 'TR_insertAction.do'}"
                    }, function(messages, xhr) {
                        if (messages.code == 200) {
                            SM.getCmp("authPanel").store.reload();
                            $("#authViewDiv").html("");
                        }
                    });
                }
            });
        });
    </script>
</c:if>

<c:if test="${dataBean.manageYn == 'N'}">
    <table class="tbl-header">
        <tr>
            <th><span class="title-big">권한 조회</span></th>
            <td class="tr"><span class="text-danger bold">본 권한은 시스템 기본값으로, 조회만 가능합니다.</span></td>
        </tr>
    </table>
    
    <table class="tbl-view">
        <colgroup>
            <col class="th">
            <col>
        </colgroup>
        <tr>
            <th>권한명</th>
            <td>
                ${dataBean.authNm}
            </td>
        </tr>
        <tr>
            <th>권한설명</th>
            <td>
                ${dataBean.authDesc}
            </td>
        </tr>
    </table>
</c:if>