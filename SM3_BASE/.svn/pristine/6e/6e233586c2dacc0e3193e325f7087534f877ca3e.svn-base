<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<html>
<head>
    <title>의견글 댓글 등록</title>
</head>
 
<body>

<table class="tbl-header">
    <tr>
        <th><span class="title-big">의견글 댓글 등록</span></th>
    </tr>
</table>

<div class="cmt-form-panel" style="margin: 0;">
    <div class="cmt-rpl-content"><sm:br data="${dataBean.cmtContents}" /></div>
    <div class="blank"></div>
    <sm:file-list list="${dataBean.fileList}" fileLog="false"/>
</div>

<div class="cmt-form-panel" style="margin-top: 14px;">
    <form:form commandName="dataBean" id="dataForm" name="dataForm" action="#" enctype="multipart/form-data">
        <form:hidden path="bbsCd"/>
        <form:hidden path="bbsSeq"/>
        <form:hidden path="cmtSeq"/>
        
        <div class="length-checker f-11">
            <span id="cmtContents_wc" class="bold">0</span> / 2,000
        </div>
        <textarea name="cmtContents" id="cmtContents" 
            rows="4" style="width: 100%;" class="smf-ta wc" data-wc="2000" placeholder="위 의견글에 대한 댓글을 등록해 주세요."></textarea>
        <div class="row btn-blank">
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
                SM.submit(form, {
                    url: CTX_PATH + "/bo/base/bbs/comment/TR_replyAction.do"
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        parent.BBS.loadComment("${dataBean.bbsCd}", "${dataBean.bbsSeq}");                            
                        SM.modalClose();
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
        
        $(".wc").wordcount();
    });
</script>

</body>
</html>