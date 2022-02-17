<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="HDAY_UTIL" clazz="com.srpost.cm.bo.base.hday.HdayUtil"/>

<c:set var="exist" value="${not empty dataBean.seq}" />

<form:form commandName="dataBean" id="dataForm" name="dataForm" autocomplete="off">
    <form:hidden path="seq"/>
    
    <table class="tbl-header">
        <tr>
            <th><span class="title-big">공휴일 ${exist ? "수정" : "등록"}</span></th>
            <td class="tr"><span class="required">표시는 필수입력 항목입니다.</span></td>
        </tr>
    </table>
    
    <table class="tbl-view tbl-form">
        <colgroup>
            <col class="th">
            <col>
        </colgroup>
        <tr>
            <th>공휴일 명<em>&nbsp;</em></th>
            <td>
                <form:input path="hdayNm" cssClass="smf-text"/>
            </td>
        </tr>
        <tr>
            <th>반복주기<em>&nbsp;</em></th>
            <td>
                <form:radiobutton path="cycle" value="${HDAY_UTIL.NO_CYCLE}" label="없음" cssClass="smf-radio" onclick="js_changeCycle(this.value);"/>
                <form:radiobutton path="cycle" value="${HDAY_UTIL.EVERY_WEEK}" label="매주" cssClass="smf-radio" onclick="js_changeCycle(this.value);"/>
                <form:radiobutton path="cycle" value="${HDAY_UTIL.EVERY_MONTH}" label="매월" cssClass="smf-radio" onclick="js_changeCycle(this.value);"/>
                <form:radiobutton path="cycle" value="${HDAY_UTIL.EVERY_YEAR}" label="매년" cssClass="smf-radio" onclick="js_changeCycle(this.value);"/>
            </td>
        </tr>
        <tr id="TR_${HDAY_UTIL.EVERY_WEEK}" 
            <c:if test="${dataBean.cycle != HDAY_UTIL.EVERY_WEEK}">style="display:none"</c:if>>
            <th>주(WEEK)<em>&nbsp;</em></th>
            <td>
                <form:select path="week" cssClass="smf-select">
                    <form:option value="0" label="매주"/>
                    <form:option value="1" label="1째주" />
                    <form:option value="2" label="2째주" />
                    <form:option value="3" label="3째주" />
                    <form:option value="4" label="4째주" />
                    <form:option value="5" label="5째주" />
                </form:select>
                
                <form:select path="dow" cssClass="smf-select">
                    <form:option value="2" label="월요일"/>
                    <form:option value="3" label="화요일" />
                    <form:option value="4" label="수요일" />
                    <form:option value="5" label="목요일" />
                    <form:option value="6" label="금요일" />
                    <form:option value="7" label="토요일" />
                </form:select>
            </td>
        </tr>
        <tr id="TR_${HDAY_UTIL.EVERY_YEAR}"
            <c:if test="${dataBean.cycle != HDAY_UTIL.EVERY_YEAR}">style="display:none"</c:if>>
            <th>양력/음력<em>&nbsp;</em></th>
            <td>
                <form:radiobutton path="lunarYn" value="N" label="양력" cssClass="smf-radio"/>
                <form:radiobutton path="lunarYn" value="Y" label="음력" cssClass="smf-radio"/>
            </td>
        </tr>
        <tr id="TR_DT"
            <c:if test="${dataBean.cycle == HDAY_UTIL.EVERY_WEEK}">style="display:none"</c:if>>
            <th>기간 설정<em>&nbsp;</em></th>
            <td>&nbsp; 
                <div id="startDd" data-value="${dataBean.startDd}" class="smf-date"></div>
                <div id="endDd" data-value="${dataBean.endDd}" class="smf-date"></div>
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
                <td class="plain">${dataBean.regDt}</td>
            </tr>
            <tr>
                <th>최종 수정일</th>
                <td class="plain">${dataBean.modiDt}</td>
            </tr>
        </c:if>
    </table>
    
    <sm:button-layout group="true">
        <c:if test="${exist}">
            <sm:button value="삭제" glyph="remove" onclick="js_deleteAction(this, '${dataBean.seq}');" />
        </c:if>
        <sm:button type="submit" glyph="saved" value="${exist ? '수정' : '등록'}" />
    </sm:button-layout>

</form:form>

<script type="text/javascript">
    Ext.onReady(function() {

        $("#dataForm").validate({
            rules: {
                hdayNm: { required: true, minlength: 2, maxlength: 20 }
            }, 
            submitHandler: function(form) {
                
                var cycle = $("input[name=cycle]:checked").val();

                var startDd = $("input[name=startDd]");
                var endDd = $("input[name=endDd]");
                
                if ( cycle != "${HDAY_UTIL.EVERY_WEEK}" && startDd.val() == "" ) {
                    alert("시작일자를 선택하세요"); return;
                }
                if( endDd.val() < startDd.val() ) {
                    alert("종료일이 시작일보다 작습니다.\n\n설정기간을 확인해 주세요."); return;
                }
                if( cycle == "${HDAY_UTIL.EVERY_MONTH}" ) {
                    var startMonth = startDd.val().substring(5, 7);
                    var endMonth = endDd.val().substring(5, 7);
                    if ( startMonth != endMonth  ) {
                        alert("반복주기가 매월(月)일 경우에는 해당 월 내에서만 시작, 종료일을 지정해야 합니다.\n\n설정기간을 확인해 주세요."); return;
                    }
                }
                
                SM.submit(form, {
                    url: "${exist ? 'TR_updateAction.do' : 'TR_insertAction.do'}"
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        SM.getCmp("hdayPanel").store.reload();
                        $("#viewDiv").html("");
                        
                        js_cacheReloadAction(form);
                    }
                });
            }
        });
        
        $(".smf-date").SM_DATEPICKER({ editable: false });
    });
</script>
