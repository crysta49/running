<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<c:set var="exist" value="${not empty dataBean.ntcSeq}" />

<form:form commandName="dataBean" id="dataForm" name="dataForm" autocomplete="off"
    method="post" enctype="multipart/form-data">
    <form:hidden path="ntcSeq"/>
    <form:hidden path="fileSeq"/>
    <input type="hidden" name="${CONSTANT.GLOBAL_EXCL_XSS_KEY}" value="contents"/>
    
    <table class="tbl-header">
        <tr>
            <th><span class="title-big">게시물 ${exist ? "수정" : "등록"}</span></th>
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
            <th>제목<em>&nbsp;</em></th>
            <td colspan="3">
                <select name="bbsCd" id="bbsCd" class="smf-select">
                    <option value="">-- 선택하세요 --</option>
                <c:forEach items="${bbsList}" var="item">
                    <option value="${item.bbsCd}" ${item.bbsCd == dataBean.bbsCd ? 'selected=\'selected\'' : ''}>${item.bbsNm}</option>
                </c:forEach>
                </select>
                <form:input path="title" cssClass="smf-text" size="80"/>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <form:textarea path="contents" rows="8" cssClass="smf-ta smeditor"/>
            </td>
        </tr>
        <tr>
            <th>공지 기간<em>&nbsp;</em></th>
            <td colspan="3">&nbsp;
                <div id="startDd" data-value="${dataBean.startDd}" class="smf-date"></div>
                <div id="endDd" data-value="${dataBean.endDd}" class="smf-date"></div>
            </td>
        </tr>
        <tr>
            <th>첨부파일<br/>(최대: 4개)
                <span class="t3-help smtip">&nbsp;</span>
                <div class="hidden">
                    <div class="smtip-title">첨부파일</div>
                    <div class="smtip-text">
                        <div>첨부 가능한 파일 확장자는 <strong>${CONSTANT.PERMIT_EXTENSIONS_STRING}</strong> 입니다.<br/>
                        첨부하는 파일의 총 용량은 <strong>${CONSTANT.MAX_UPLOAD_SIZE} KB</strong>를 초과할 수 없습니다.</div>
                    </div>
                </div>
            </th>
            <td colspan="3">
                <sm:file-list list="${dataBean.fileList}" checkbox="true" downCnt="false"/>
                <div style="margin-top: 4px;">
                    <input type="file" name="files" multiple="multiple" class="multifile"/>
                </div>
                <div class="selected-file"></div>
                <input type="hidden" name="${CONSTANT.UPLOAD_FOLDER_PARAM_KEY}" value="ntc" />
            </td>
        </tr>
        <c:if test="${exist}">
        <tr>
            <th>등록일</th>
            <td>
                ${dataBean.regDt}
            </td>
            <th>최종 수정일</th>
            <td>
                ${dataBean.modiDt}
            </td>
        </tr>
        </c:if>
    </table>
    
    <sm:button-layout>
        <sm:button value="취소" icon="check" onclick="js_cancelAction('${dataBean.ntcSeq}');" />
        <sm:button type="submit" value="저장" icon="b3-db-save" />
    </sm:button-layout>
    
</form:form>

<script type="text/javascript">

    Ext.onReady(function() {

        $("#dataForm").validate({
            rules: {
                bbsCd: { required: true },
                title: { required: true, maxlength: 120 },
                contents: { required: true }
            }, 
            submitHandler: function(form) {

                if ($("#contents").val() == "") {
                    alert("내용을 입력하세요."); return;
                }
                
                var startDd = $("input[name=startDd]");
                var endDd = $("input[name=endDd]");

                if( endDd.val() < startDd.val() ) {
                    alert("종료일이 시작일보다 작습니다.\n\n기간을 확인해 주세요."); return;
                }
                
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
                    my: "bottom left",
                    at: "top center"
                }
            });
        });
        
        $("textarea.smeditor").ckeditor(CKEDITOR_CONFIG);
        
        $(".multifile").MultiFile({ max: 4 });
        
        $(".tbl-view .smf-date").SM_DATEPICKER({ editable: false });
    });
</script>

        
        