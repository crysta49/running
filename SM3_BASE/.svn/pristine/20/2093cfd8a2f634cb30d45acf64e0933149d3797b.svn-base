<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<html>
<head>
    <title>의견글 수정</title>
</head>
 
<body>

<form:form commandName="dataBean" id="dataForm" name="dataForm" action="#" enctype="multipart/form-data">
    <form:hidden path="bbsCd"/>
    <form:hidden path="bbsSeq"/>
    <form:hidden path="cmtSeq"/>
    <form:hidden path="fileSeq"/>
    
    <table class="tbl-view">
        <tr>
            <td>의견글 수정</td>
            <td><span id="cmtContents_wc" class="bold">0</span>/2,000</td>
        </tr>
        <tr>
            <td colspan="2">
                <form:textarea path="cmtContents" rows="4" cssClass="wc" data-wc="2000" data-label="의견글 내용"/>
            </td>
        </tr>
        <c:if test="${not empty dataBean.fileList}">
        <tr>
            <td colspan="2">
                <span>파일을 삭제하시려면 체크박스를 선택 후 수정 버튼을 클릭하세요.</span>
                <sm:file-list list="${dataBean.fileList}" checkbox="true" downCnt="false"/>
            </td>
        </tr>
        </c:if>
        <tr>
            <td>
                <span class="smtip">@</span>
                <div class="hidden">
                    <div class="smtip-title">첨부파일</div>
                    <div class="smtip-text">
                        <div>첨부 가능한 파일 확장자는 <strong>${CONSTANT.PERMIT_EXTENSIONS_STRING}</strong> 입니다.<br/>
                        첨부하는 파일의 총 용량은 <strong>${CONSTANT.MAX_UPLOAD_SIZE} KB</strong>를 초과할 수 없습니다.</div>
                    </div>
                </div>
                <input type="file" name="files" />
                <input type="hidden" name="${CONSTANT.UPLOAD_FOLDER_PARAM_KEY}" value="bbs_comment" />
            </td>
            <td class="tr">
                <sm:button type="submit" value="수정" icon="b3-db-save" />
            </td>
        </tr>
    </table>
</form:form>

<sm:js names="validation" />
<script type="text/javascript" src="<c:url value="/resources/spi/jquery/wordcount/jquery.wordcount.js"/>"></script>
<script type="text/javascript">

    $().ready(function(){

        $("#dataForm").validate({
            rules: {
                cmtContents: { required: true, maxword: 2000 }
            }, 
            submitHandler: function(form) {
                if ( confirm("수정 하시겠습니까?") ) {
  
                    SM.submit(form, {
                        url: CTX_PATH + "/fe/bbs/comment/TR_updateAction.do"
                    }, function(messages, xhr) {
                        if (messages.code == 200) {
                            opener.BBS.loadComment("${dataBean.bbsCd}", "${dataBean.bbsSeq}");
                            self.close();
                        }
                    });
                }
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
        
        $(".wc").wordcount().trigger("textchange");
    });
</script>

</body>
</html>