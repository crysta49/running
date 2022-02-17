<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>
<c:set var="userSession" value="${sessionScope[CONSTANT.USER_SESSION_KEY]}" />

<html>
<head>
    <title>${confBean.bbsNm} 수정</title>
</head>

<body>

<form:form commandName="bbsBean" id="listForm" name="listForm" action="NR_list.do" method="get">
    <form:hidden path="bbsCd" id="_bbsCd"/>
    <form:hidden path="bbsSeq" id="_bbsSeq"/>
    <form:hidden path="currentPage" id="_currentPage"/>
    <form:hidden path="rowPerPage" id="_rowPerPage"/>
    <form:hidden path="searchKey" id="_searchKey"/>
    <form:hidden path="searchVal" id="_searchVal"/>
    <form:hidden path="ctgCd" id="_ctgCd"/>
</form:form>

<form:form commandName="dataBean" id="dataForm" name="dataForm" 
    action="TR_updateAction.do" method="post" enctype="multipart/form-data">
    <form:hidden path="bbsCd" /> 
    <form:hidden path="bbsSeq" />
    <form:hidden path="fileSeq" />

<table>
    <c:if test="${confBean.ctgYn == 'Y'}">
        <tr>
            <th>분류</th>
            <td>
                <select name="ctgCd" id="ctgCd" data-label="분류" >
                    <option value="">-- 선택하세요 --</option>
                <c:forEach items="${confBean.ctgList}" var="item">
                    <option value="${item.ctgCd}"
                        <c:if test="${item.ctgCd == dataBean.ctgCd}">selected="selected"</c:if>>${item.ctgNm}</option>
                </c:forEach>
                </select>
            </td>
        </tr>
    </c:if>
    <tr>
        <th>제목</th>
        <td>
            <form:input path="title" size="60" cssClass="text" data-label="제목"/>
        </td>
    </tr>
    <tr>
        <th>내용</th>
        <td>
            <form:textarea path="question" rows="6" data-label="내용"/>
        </td>
    </tr>
    <c:if test="${confBean.fileYn == 'Y'}">
        <tr>
            <th>첨부파일</th>
            <td>
                <c:set var="fileCnt" value="${fn:length(dataBean.fileList)}"/>
                <c:if test="${fileCnt > 0}">
                    <span class="tip">기존 첨부파일을 삭제하시려면 아래 체크박스를 선택하세요.</span>
                    <sm:file-list list="${dataBean.fileList}" checkbox="true" downCnt="false" fileType="false"/>
                    <div class="blank"></div>
                </c:if>
                <input type="file" name="files" multiple="multiple" class="multifile"/>
                <div class="selected-file"></div>
                <input type="hidden" name="fileCnt" id="fileCnt" value="${fileCnt}"/>
                <input type="hidden" name="${CONSTANT.UPLOAD_FOLDER_PARAM_KEY}" value="bbs" />
            </td>
        </tr>
    </c:if>
    <c:if test="${confBean.alimYn == 'Y'}">
        <tr>
            <th>회신유형</th>
            <td>
                <input type="checkbox" name="alertCdz" id="alertCd_1"
                    <c:if test="${fn:contains(dataBean.alertCds, 'E')}">checked="checked"</c:if> 
                        value="${CONSTANT.ALIM_EMAIL}" /><label for="alertCd_1">이메일</label>
                <input type="checkbox" name="alertCdz" id="alertCd_2" 
                    <c:if test="${fn:contains(dataBean.alertCds, 'M')}">checked="checked"</c:if> 
                        value="${CONSTANT.ALIM_MOBILE}" /><label for="alertCd_2">휴대폰</label>
            </td>
        </tr>
    </c:if>
    <tr>
        <th>등록일</th>
        <td>
            ${dataBean.regDt}
            <c:if test="${not empty dataBean.modiDt}">
            (최종 수정 : ${dataBean.modiDt})
            </c:if> by ${dataBean.writerNm}
        </td>
    </tr>
</table>

<sm:button-layout>
    <sm:button type="submit" value="수정" />
    <sm:button value="취소" onclick="history.back();"/>
    <sm:button value="목록" onclick="BBS.list();"/>
</sm:button-layout>

</form:form>

<sm:js names="validation, multifile" />
<script type="text/javascript" src="<c:url value="/resources/front/FE/js/bbs.js"/>"></script>
<script type="text/javascript">

    $().ready(function() {
        $("#dataForm").validate({
            rules: {
                <c:if test="${confBean.ctgYn == 'Y'}">
                ctgCd : { required: true },
                </c:if>
                title  : { required: true, minlength: 2, maxlength: 180 },
                question : { required: true, minlength: 2 }
            },
            submitHandler: function(form) {
                
                SM.submit(form, {
                    url: "TR_updateAction.do"
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        document.listForm.action= "NR_view.do";
                        document.listForm.submit();
                    }
                });
            }
        });
        
        $(".multifile").MultiFile({
            max: "${confBean.fileCnt}"
        });
        
        if ( ${confBean.fileCnt} <= $("#fileCnt").val() ) 
            $.fn.MultiFile.disableEmpty(".multifile");
        
        $("#title")[0].focus();
    });
</script>

</body>
</html>