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

<table class="tbl-header">
    <tr>
        <th><span class="title-big">의견글 수정</span></th>
    </tr>
</table>

<div class="cmt-form-panel" style="margin: 0;">
    <form:form commandName="dataBean" id="dataForm" name="dataForm" action="#" enctype="multipart/form-data">
        <form:hidden path="bbsCd"/>
        <form:hidden path="bbsSeq"/>
        <form:hidden path="cmtSeq"/>
        <form:hidden path="fileSeq"/>
        
        <div class="length-checker f-11">
            <span id="cmtContents_wc" class="bold">0</span> / 2,000
        </div>
        <form:textarea path="cmtContents" rows="4" cssStyle="width: 100%;" 
            cssClass="smf-ta wc" data-wc="2000" placeholder="의견글을 등록해 주세요."/>
        <div class="row btn-blank">
            <c:if test="${not empty dataBean.fileList}">
                <div class="col-xs-12">
                    <span class="text-success">파일을 삭제하시려면 체크박스를 선택 후 저장하세요.</span>
                    <sm:file-list list="${dataBean.fileList}" checkbox="true" downCnt="false"/>                
                </div>
            </c:if>
            <div class="col-xs-8">
                <div class="input-group input-file">
                    <input type="text" id="dummy-file" class="smf-text form-control" readonly />
                    <label class="input-group-btn">
                        <span class="btn btn-sm btn-plain">찾아보기&hellip; 
                            <input type="file" name="files" class="sr-hidden" onchange="document.getElementById('dummy-file').value=this.value;"/>
                        </span>
                    </label>
                    <div class="tip">
                        <span class="t3-help smtip" style="padding-left:12px;">&nbsp;</span>
                        <div class="sr-hidden">
                            <div class="smtip-title">첨부파일</div>
                            <div class="smtip-text">
                                <div>첨부 가능한 파일 확장자는 <strong>${CONSTANT.PERMIT_EXTENSIONS_STRING}</strong> 입니다.<br/>
                                첨부하는 파일의 총 용량은 <strong>${CONSTANT.MAX_UPLOAD_SIZE} KB</strong>를 초과할 수 없습니다.</div>
                            </div>
                        </div>
                    </div>
                </div>
                <input type="hidden" name="${CONSTANT.UPLOAD_FOLDER_PARAM_KEY}" value="bbs_comment" />
            </div>
            <div class="col-xs-4 text-right">
                <sm:button type="submit" value="저장" glyph="saved" cssClass="btn-plain"/>
            </div>
        </div>
    </form:form>
</div>

<sm:js names="validation" />
<script type="text/javascript" src="<c:url value="/resources/spi/jquery/wordcount/jquery.wordcount.js"/>"></script>
<script type="text/javascript">

    Ext.onReady(function() {

        $("textarea[name=cmtContents]").focus();

        $("#dataForm").validate({
            rules: {
                cmtContents: { required: true, maxword: 2000 }
            }, 
            submitHandler: function(form) {
                if ( confirm("수정 하시겠습니까?") ) {
  
                    SM.submit(form, {
                        url: CTX_PATH + "/bo/base/bbs/comment/TR_updateAction.do"
                    }, function(messages, xhr) {
                        if (messages.code == 200) {
                            parent.BBS.loadComment("${dataBean.bbsCd}", "${dataBean.bbsSeq}");                            
                            SM.modalClose();
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