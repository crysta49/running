<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<c:set var="exist" value="${not empty dataBean.seq}" />

<form:form commandName="dataBean" id="dataForm" name="dataForm" autocomplete="off">
    <form:hidden path="seq"/>
    <form:hidden path="menuCd"/>
    
    <table class="tbl-header">
        <tr>
            <th><span class="title-big">위젯 ${exist ? "수정" : "등록"}</span></th>
            <td class="tr"><span class="required">표시는 필수입력 항목입니다.</span></td>
        </tr>
    </table>
    
    <table class="tbl-view">
        <colgroup>
            <col class="th">
            <col>
        </colgroup>
        <tr>
            <th>위젯명<em>&nbsp;</em></th>
            <td>
                <form:input path="widgetNm" cssClass="smf-text" size="50"/>
            </td>
        </tr>
        <tr>
            <th>파일명<em>&nbsp;</em>
                <span class="t3-help smtip">&nbsp;</span>
                <div class="hidden">
                    <div class="smtip-title">파일명</div>
                    <div class="smtip-text">
                        <div>대상 파일은 /WEB-INF/jsp/bo/base/widget/modules 폴더에 위치합니다.</div>
                    </div>
                </div>
            </th>
            <td>
                <select name="fileNm" id="fileNm" class="smf-select">
                    <option value="">-- 선택하세요 --</option>
                    <c:forEach items="${fileList}" var="item">
                        <option value="${item}" ${item == dataBean.fileNm ? "selected='selected'" : ""}>${item}</option>
                    </c:forEach>
                </select>
            </td>
        </tr>
        <tr>
            <th>호출 인자
                <span class="t3-help smtip">&nbsp;</span>
                <div class="hidden">
                    <div class="smtip-title">호출 인자</div>
                    <div class="smtip-text">
                        <div>파일 호출 시 전달할 인자를 설정하세요.</div>
                    </div>
                </div>
            </th>
            <td>
                <form:input path="callParam" cssClass="smf-text" size="50"/>
            </td>
        </tr>
        <tr>
            <th>연결 메뉴
                <span class="t3-help smtip">&nbsp;</span>
                <div class="hidden">
                    <div class="smtip-title">호출 인자</div>
                    <div class="smtip-text">
                        <div>본 위젯과 연결할 메뉴를 선택하세요.</div>
                    </div>
                </div>
            </th>
            <td>
                <div class="menuTreeDiv" id="menuNm"></div>
            </td>
        </tr>
        <tr>
            <th>사용권한</th>
            <td>
                <c:forEach items="${authList}" var="item">
                    <input type="checkbox" name="authCds" id="id_${item.authCd}" value="${item.authCd}" 
                        ${item.checked == 'Y' ? 'checked="checked"' : ''} class="smf-checkbox" />
                    <label for="id_${item.authCd}">${item.authNm}</label><br/>
                </c:forEach>
            </td>
        </tr>
        <c:if test="${exist}">
            <tr>
                <th>사용여부</th>
                <td>
                    <form:radiobutton path="useYn" value="Y" label="사용" cssClass="smf-radio"/>
                    <form:radiobutton path="useYn" value="N" label="미사용" cssClass="smf-radio"/>
                </td>
            </tr>
            <tr>
                <th>등록일</th>
                <td>${dataBean.regDt}</td>
            </tr>
            <tr>
                <th>최종 수정일</th>
                <td>${dataBean.modiDt}</td>
            </tr>
        </c:if>
    </table>
    
    <sm:button-layout align="both">
        <div class="left">
            <c:if test="${exist}">
                <sm:button value="사용 직원 (${dataBean.assignCount}명)" icon="b3-user" onclick="js_assignPop('${dataBean.seq}');" />
            </c:if>
        </div>
        <div>
            <c:if test="${exist}">
                <sm:button value="삭제" icon="b3-db-delete" onclick="js_deleteAction(this, '${dataBean.seq}');" />
                <sm:button type="submit" value="수정" icon="b3-db-save" />
            </c:if>
            <c:if test="${!exist}">
                <sm:button type="submit" value="등록" icon="b3-db-save" />
            </c:if>
        </div>
    </sm:button-layout>

</form:form>

<script type="text/javascript">
    Ext.onReady(function() {

        $("#dataForm").validate({
            rules: {
                widgetNm: { required: true, maxlength: 20 },
                fileNm: { required: true }
            }, 
            submitHandler: function(form) {

                SM.submit(form, {
                    url: "${exist ? 'TR_updateAction.do' : 'TR_insertAction.do'}"
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        SM.getCmp("widgetPanel").store.reload();
                        $("#viewDiv").html("");
                    }
                });
            }
        });
        
        $(".menuTreeDiv").SM_TREECOMBO({
            dataListUrl: CTX_PATH + "/bo/base/menu/JR_listAll.do",
            value: "${empty dataBean.menuCd ? smp.menuCd : dataBean.menuCd}",
            select: function(record) {
                $("#menuCd").val(record.data.id);
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
