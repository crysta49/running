<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<c:set var="exist" value="${not empty dataBean.domainCd}" />

<form:form commandName="dataBean" id="dataForm" name="dataForm" autocomplete="off">
    <table class="tbl-header">
        <tr>
            <th><span class="title-big">도메인 ${exist ? "수정" : "등록"}</span></th>
            <td class="tr"><span class="required">표시는 필수입력 항목입니다.</span></td>
        </tr>
    </table>
    
    <table class="tbl-view">
        <colgroup>
            <col class="th">
            <col>
        </colgroup>
        <tr>
            <th>도메인 코드
                <span class="t3-help smtip">&nbsp;</span>
                <div class="hidden">
                    <div class="smtip-title">도메인 코드</div>
                    <div class="smtip-text">
                        <div>고객단 메뉴의 최상위 메뉴코드와 일치하며 자동할당 됩니다.</div>
                    </div>
                </div>
            </th>
            <td>
                <c:if test="${exist}">
                    <form:input path="domainCd" cssClass="smf-text" size="3" maxlength="4" readonly="true"/>
                </c:if>
                <c:if test="${!exist}">
                    <span class="gray">자동할당</span>
                </c:if>
            </td>
        </tr>
        <tr>
            <th>도메인 명<em>&nbsp;</em></th>
            <td>
                <form:input path="domainNm" cssClass="smf-text" size="40"/>
            </td>
        </tr>
        <tr>
            <th>도메인 URL<em>&nbsp;</em>
                <span class="t3-help smtip">&nbsp;</span>
                <div class="hidden">
                    <div class="smtip-title">도메인 URL</div>
                    <div class="smtip-text">
                        <div>www.domain.com 또는 en.domain.com 형식으로 입력하세요.</div>
                    </div>
                </div>
            </th>
            <td>
                <form:input path="domainUrl" cssClass="smf-text" size="25"/>
            </td>
        </tr>
    </table>
    
    <sm:button-layout>
        <c:if test="${exist}">
            <sm:button value="삭제" icon="b3-db-delete" onclick="js_deleteAction(this, '${dataBean.domainCd}');" />
            <sm:button type="submit" value="수정" icon="b3-db-save" />
        </c:if>
        <c:if test="${!exist}">
            <sm:button type="submit" value="등록" icon="b3-db-save" />
        </c:if>
    </sm:button-layout>

</form:form>

<script type="text/javascript">
    Ext.onReady(function() {

        $("#dataForm").validate({
            rules: {
                domainNm: { required: true, maxlength: 30 },
                domainUrl: { required: true, maxlength: 50 }
            }, 
            submitHandler: function(form) {
                
                SM.submit(form, {
                    url: "${exist ? 'TR_updateAction.do' : 'TR_insertAction.do'}"
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        SM.getCmp("gridPanel").store.reload();
                        $("#viewDiv").html("");
                    }
                });
            }
        });
        
        $(".smtip").each(function() {
            $(this).qtip({
                content: {
                    title: $(this).next().find(".smtip-title"),
                    text: $(this).next().find(".smtip-text")
                },
                position: {
                    my: "left center",
                    at: "center center"
                }
            });
        });
    });
</script>
