<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<c:set var="exist" value="${not empty dataBean && dataBean.menuCd ne '0'}" />

<c:if test="${exist}">

    <form:form commandName="dataBean" id="updateForm" name="updateForm" onsubmit="false">
        <form:hidden path="menuCd"/>

        <table class="tbl-header">
            <tr>
                <th><span class="title-big">메뉴 상세정보</span></th>
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
                <th>메뉴 경로</th>
                <td colspan="3" class="plain"><span id="treePath"></span></td>
            </tr>
            <tr>
                <th>메뉴 코드</th>
                <td class="plain">
                    <span id="nodeId">${dataBean.menuCd}</span>
                </td>
                <th>정렬 순서
                    <span class="t3-help smtip">&nbsp;</span>
                    <div class="sr-hidden">
                        <div class="smtip-title">정렬 순서</div>
                        <div class="smtip-text">
                            <div>좌측 메뉴목록에서 드래그 앤 드랍을 통해 정렬순서를 변경할 수 있습니다.</div>
                        </div>
                    </div>
                </th>
                <td id="orderNo" class="plain">
                    ${dataBean.orderNo}
                </td>
            </tr>
            <tr>
                <th>메뉴 명<em>&nbsp;</em></th>
                <td colspan="3">
                    <form:input path="text" size="50" cssClass="smf-text" onkeypress="if(event.keyCode==13) {js_enterKeyCheck('update'); return false;}" />
                </td>
            </tr>
            <tr>
                <th>메뉴 URL
                    <span class="t3-help smtip">&nbsp;</span>
                    <div class="sr-hidden">
                        <div class="smtip-title">메뉴 URL</div>
                        <div class="smtip-text">
                            <c:if test="${not empty pageContext.request.contextPath}">
                               <div>컨텍스트 경로(<b>${pageContext.request.contextPath}</b>)를 제외한 나머지 URL을 입력합니다.</div>
                            </c:if>
                            <div>하위레벨 메뉴가 존재할 경우에는 입력하지 않습니다.
                            <br/>ex) /bo/base/menu/NR_index.do</div>
                        </div>
                    </div>
                </th>
                <td colspan="3">
                    <form:input path="menuUrl" size="50" cssClass="smf-text" readonly="${smp.leaf ? 'false' : 'true'}" onkeypress="if(event.keyCode==13) {js_enterKeyCheck('update'); return false;}" />
                </td>
            </tr>
            <tr>
                <th>메뉴 패턴
                    <span class="t3-help smtip">&nbsp;</span>
                    <div class="sr-hidden">
                        <div class="smtip-title">메뉴 패턴</div>
                        <div class="smtip-text">
                            <div>ANT 스타일 기반 경로 패턴을 입력합니다.</div>
                            <div>하위레벨 메뉴가 존재할 경우에는 입력하지 않습니다.
                            <br/>ex) /**/menu/*</div>
                        </div>
                    </div>
                </th>
                <td colspan="3">
                    <form:input path="menuPattern" size="50" cssClass="smf-text" readonly="${smp.leaf ? 'false' : 'true'}" onkeypress="if(event.keyCode==13) {js_enterKeyCheck('update'); return false;}" />
                    <span><a href="http://ant.apache.org/manual/dirtasks.html#patterns" target="_blank">패턴 참고</a></span>
                </td>
            </tr>
            <tr>
                <th>할당 권한그룹</th>
                <td colspan="3" class="plain">
                    <c:if test="${empty dataBean.authList}">없음</c:if>
                    <c:forEach items="${dataBean.authList}" var="item" varStatus="status">
                        <a href="#" onclick="js_authListPop('${item.authCd}')">${item.authNm}</a><c:if test="${!status.last}">, </c:if>
                    </c:forEach>
                </td>
            </tr>
            <tr>
                <th>구분선 여부</th>
                <td>
                    <form:radiobutton path="dividerYn" value="Y" label="사용" cssClass="smf-radio" />
                    <form:radiobutton path="dividerYn" value="N" label="미사용" cssClass="smf-radio"/>
                </td>
                <th>사용 여부</th>
                <td>
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
            <%-- <tr>
                <th>메뉴 아이콘</th>
                <td>
                    <form:input path="menuIcon" size="15" cssClass="smf-text" readonly="${smp.leaf ? 'false' : 'true'}" />
                </td>
                <th>메뉴 ID
                    <span class="t3-help smtip">&nbsp;</span>
                    <div class="sr-hidden">
                        <div class="smtip-title">메뉴 ID</div>
                        <div class="smtip-text">
                            <div>해당 메뉴를 구분하는 고유값을 입력합니다.</div>
                            <div>(영문, 숫자만 가능)</div>
                        </div>
                    </div>
                </th>
                <td>
                    <form:input path="menuId" size="10" cssClass="smf-text" readonly="${smp.leaf ? 'false' : 'true'}" />
                </td>
            </tr> --%>
        </table>
        
        <sm:button-layout group="true">
            <sm:button value="삭제" glyph="remove" onclick="SM.getCmp('treePanel').smDelete(this);"/>
            <sm:button value="수정" glyph="saved" onclick="SM.getCmp('treePanel').smUpdate(this, '#updateForm');" id="updateBtn"/>
        </sm:button-layout>

    </form:form>
    
    <div class="blank-2x"></div>
</c:if>

<form:form id="insertForm" name="insertForm" onsubmit="SM.getCmp('treePanel').smInsert(this, '#insertForm');">

    <table class="tbl-header">
        <tr>
            <th><span class="title-big">메뉴 추가</span></th>
            <td class="text-right"><span class="required">표시는 필수입력 항목입니다.</span></td>
        </tr>
    </table>
    
    <table class="tbl-view tbl-form">
        <colgroup>
            <col class="th">
            <col>
        </colgroup>
        <tr>
            <th>메뉴 명<em>&nbsp;</em></th>
            <td>
                <input type="text" name="newText" id="newText" class="smf-text" size="40" onkeypress="if(event.keyCode==13) {js_enterKeyCheck('insert'); return false;}" />
            </td>
        </tr>
        <tr>
            <th>추가 옵션</th>
            <td>
                <div style="margin: 4px 0;">
                    <div><input type="radio" name="appendOption" id="isSame" value="isSame" class="smf-radio"
                        <c:if test="${!exist}">disabled="disabled"</c:if> /><label for="isSame">선택한 메뉴 동일 레벨에 추가</label></div>
        
                    <div><input type="radio" name="appendOption" id="isChild" value="isChild" class="smf-radio"
                        <c:if test="${!exist or smp.depth >= 3}">disabled="disabled"</c:if> /><label for="isChild">선택한 메뉴 하위 레벨에 추가</label></div>
        
                    <div><input type="radio" name="appendOption" id="isRoot" value="isRoot" class="smf-radio"
                        checked="checked" /><label for="isRoot">루트 메뉴에 추가</label></div>
                </div>
            </td>
        </tr>
    </table>
    
    <sm:button-layout>          
        <sm:button value="등록" glyph="saved" onclick="SM.getCmp('treePanel').smInsert(this, '#insertForm');" id="insertBtn"/>
    </sm:button-layout>
</form:form>

<script type="text/javascript">
    $(document).ready(function(){
        
        if ( $("#updateForm") ) {
            $("#updateForm").validate({
                rules: {
                    text: { required:true, minlength:2, maxlength:30 },
                    menuId: { alphanumeric: true }
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
