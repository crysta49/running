<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<c:set var="exist" value="${not empty dataBean && dataBean.menuCd ne '0'}" />

<c:if test="${exist}">
    
    <form:form commandName="dataBean" id="updateForm" name="updateForm">
        <form:hidden path="menuCd"/>

        <table class="tbl-header">
            <tr>
                <th><span class="title-big">메뉴 상세정보</span></th>
                <td class="tr"><span class="required">표시는 필수입력 항목입니다.</span></td>
            </tr>
        </table>
        
        <table class="tbl-view">
            <colgroup>
                <col class="th">
                <col>
                <col class="th">
                <col>
            </colgroup>
            <tr>
                <th>메뉴 경로</th>
                <td colspan="3"><span id="treePath"></span></td>
            </tr>
            <tr>
                <th>메뉴 코드</th>
                <td>
                    <span id="nodeId">${dataBean.menuCd}</span>
                </td>
                <th>정렬 순서
                    <span class="t3-help smtip">&nbsp;</span>
                    <div class="hidden">
                        <div class="smtip-title">정렬 순서</div>
                        <div class="smtip-text">
                            <div>좌측 메뉴목록에서 드래그 앤 드랍을 통해 정렬순서를 변경할 수 있습니다.</div>
                        </div>
                    </div>
                </th>
                <td id="orderNo">
                    ${dataBean.orderNo}
                </td>
            </tr>
            <tr>
                <th>메뉴 명<em>&nbsp;</em></th>
                <td>
                    <form:input path="text" size="20" cssClass="smf-text" />
                </td>
                <th>메뉴 ID
                    <span class="t3-help smtip">&nbsp;</span>
                    <div class="hidden">
                        <div class="smtip-title">메뉴 ID</div>
                        <div class="smtip-text">
                            <div>해당 메뉴를 구분하는 고유값을 입력합니다.</div>
                            <div>(영문, 숫자만 가능)</div>
                        </div>
                    </div>
                </th>
                <td>
                    <form:input path="menuId" size="15" cssClass="smf-text" readonly="${smp.leaf ? 'false' : 'true'}"/>
                </td>
            </tr>
            <tr>
                <th>메뉴 유형</th>
                <td>
                    <c:if test="${!smp.leaf}">
                        <sm:code id="typeCd" grpCd="FRONT_MENU_TYPE" option="disabled='disabled'"/>
                    </c:if>
                    <c:if test="${smp.leaf}">
                        <sm:code id="typeCd" grpCd="FRONT_MENU_TYPE" />
                    </c:if>
                </td>
                <th>표시 여부
                    <span class="t3-help smtip">&nbsp;</span>
                    <div class="hidden">
                        <div class="smtip-title">표시 여부</div>
                        <div class="smtip-text">표시를 선택한 메뉴만 고객단 TOP, LEFT 영역 메뉴에 노출됩니다.</div>
                    </div>
                </th>
                <td>
                    <form:radiobutton path="showYn" value="Y" label="표시" cssClass="smf-radio" />
                    <form:radiobutton path="showYn" value="N" label="미표시" cssClass="smf-radio"/>
                </td>
            </tr>
            <c:if test="${smp.leaf}">
                <tr>
                    <th>메뉴 URL 안내</th>
                    <td id="urlHelp" colspan="3">
                        <span class="gray">메뉴 유형을 선택하시면 도움말이 표시됩니다.</span>
                    </td>
                </tr>
            </c:if>
            <tr>
                <th>메뉴 URL
                    <span class="t3-help smtip">&nbsp;</span>
                    <div class="hidden">
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
                    <form:input path="menuUrl" size="50" cssClass="smf-text" readonly="${smp.leaf ? 'false' : 'true'}" />
                </td>
            </tr>
            <tr>
                <th>메뉴 패턴
                    <span class="t3-help smtip">&nbsp;</span>
                    <div class="hidden">
                        <div class="smtip-title">메뉴 패턴</div>
                        <div class="smtip-text">
                            <div>ANT 스타일 기반 경로 패턴을 입력합니다.</div>
                            <div>하위레벨 메뉴가 존재할 경우에는 입력하지 않습니다.
                            <br/>ex) /**/menu/*</div>
                        </div>
                    </div>
                </th>
                <td colspan="3">
                    <form:input path="menuPattern" size="50" cssClass="smf-text" readonly="${smp.leaf ? 'false' : 'true'}" /> &nbsp;
                    <span><a href="http://ant.apache.org/manual/dirtasks.html#patterns" target="_blank">패턴 참고</a></span>
                </td>
            </tr>
            <tr>
                <th>메뉴 담당자</th>
                <td colspan="3">
                    <input type="text" name="mgrNm" id="mgrNm" value="${dataBean.mgrNm}" class="smf-text" readonly="readonly"/>
                    <input type="hidden" name="mgrId" id="mgrId" value="${dataBean.mgrId}" />
                    <sm:button value="담당자 지정" onclick="js_showMenuMgrPop();"/>
                </td>
            </tr>
            <tr>
                <th>메뉴 아이콘</th>
                <td>
                    <form:input path="menuIcon" size="20" cssClass="smf-text" readonly="${smp.leaf ? 'false' : 'true'}" />
                </td>
                <th>사용 여부</th>
                <td>
                    <form:radiobutton path="useYn" value="Y" label="사용" cssClass="smf-radio" />
                    <form:radiobutton path="useYn" value="N" label="미사용" cssClass="smf-radio"/>
                </td>
            </tr>
            <tr>
                <th>등록일</th>
                <td>${dataBean.regDt}</td>
                <th>최종 수정일</th>
                <td>${dataBean.modiDt}</td>
            </tr>
        </table>

        <sm:button-layout>
            <sm:button value="삭제" icon="b3-db-delete" onclick="SM.getCmp('treePanel').smDelete(this);" />
            <sm:button value="수정" icon="b3-db-save" onclick="SM.getCmp('treePanel').smUpdate(this, '#updateForm');" />
        </sm:button-layout>

    </form:form>
    
    <div class="blank"></div>
</c:if>

<form:form id="insertForm" name="insertForm">

    <table class="tbl-header">
        <tr>
            <th><span class="title-big">메뉴 추가</span></th>
            <td class="tr"><span class="required">표시는 필수입력 항목입니다.</span></td>
        </tr>
    </table>
    
    <table class="tbl-view">
        <colgroup>
            <col class="th">
            <col>
        </colgroup>
        <tr>
            <th>메뉴 명<em>&nbsp;</em></th>
            <td>
                <input type="text" name="newText" id="newText" class="smf-text" size="40" />
            </td>
        </tr>
        <tr>
            <th>추가 옵션</th>
            <td>
                <div><input type="radio" name="appendOption" id="isSame" value="isSame" class="smf-radio"
                    <c:if test="${!exist}">disabled="disabled"</c:if> /><label for="isSame">선택한 메뉴 동일 레벨에 추가</label></div>
    
                <div><input type="radio" name="appendOption" id="isChild" value="isChild" class="smf-radio"
                    <c:if test="${!exist}">disabled="disabled"</c:if> /><label for="isChild">선택한 메뉴 하위 레벨에 추가</label></div>
    
                <div><input type="radio" name="appendOption" id="isRoot" value="isRoot" class="smf-radio"
                    checked="checked" /><label for="isRoot">루트 메뉴에 추가</label></div>
            </td>
        </tr>
    </table>

    <sm:button-layout>
        <sm:button value="저장" icon="b3-db-save" onclick="SM.getCmp('treePanel').smInsert(this, '#insertForm');" />
    </sm:button-layout>
</form:form>

<script type="text/javascript">
    Ext.onReady(function() {
        
        <c:if test="${smp.domainCd == dataBean.menuCd}">
            $("#updateForm input, #updateForm select").attr("disabled", true);
        </c:if>
        
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
        
        $("#typeCd").change(function() {

            if (this.value == "500") {
                $("#urlHelp").html(
                    "메뉴 URL : <a href='#' onclick='js_setUrlHelp(500);'>/fe/cms/{FOLDER_NM}/{FILE_NM}/NR_index.do</a><br/>" +
                    "메뉴 패턴 : <a href='#' onclick='js_setUrlHelp(500);'>/**/cms/{FOLDER_NM}/{FILE_NM}/*</a><br/>" + 
                    "형식으로 입력하세요."
                );
            }
            else if (this.value == "501") {
                $("#urlHelp").html(
                    "메뉴 URL : <a href='#' onclick='js_setUrlHelp(501);'>/fe/bbs/NR_list.do?bbsCd={BBS_CD}</a><br/>" +
                    "메뉴 패턴 : <a href='#' onclick='js_setUrlHelp(501);'>/fe/bbs/NR_*.do*bbsCd={BBS_CD}*</a><br/>" + 
                    "형식으로 입력하세요."
                );
            }
            else {
                $("#urlHelp").html(
                    "기술인력의 도움을 받아 메뉴 URL과 패턴을 입력하세요."
                );
            }
        });
    });
    
    var js_setUrlHelp = function(typeCd) {
        
        if (typeCd == "500") {
            $("#menuUrl").val("/fe/cms/{FOLDER_NM}/{FILE_NM}/NR_index.do");
            $("#menuPattern").val("/**/cms/{FOLDER_NM}/{FILE_NM}/*");
        }
        else if (typeCd == "501") {
            $("#menuUrl").val("/fe/bbs/NR_list.do?bbsCd={BBS_CD}");
            $("#menuPattern").val("/fe/bbs/NR_*.do*bbsCd={BBS_CD}*");
        }
    };
</script>
