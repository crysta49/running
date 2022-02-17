<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>
<c:set var="mgrSession" value="${sessionScope[CONSTANT.MGR_SESSION_KEY]}" />

<div class="cmt-form-panel">
    <form:form name="commentForm" id="commentForm" method="post" action="#" enctype="multipart/form-data">
        <input type="hidden" name="bbsCd" value="${smp.bbsCd}" />
        <input type="hidden" name="bbsSeq" value="${smp.bbsSeq}" />
        
        <div class="length-checker f-11">
            <span id="cmtContents_wc" class="bold">0</span> / 2,000
        </div>
        <textarea name="cmtContents" id="cmtContents" 
            rows="4" style="width: 100%;" class="smf-ta wc" data-wc="2000" placeholder="의견글을 등록해 주세요."></textarea>
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

<c:if test="${not empty dataList}">
    <div class="cmt-list-title"><span class="title f-bold f-15">의견글</span><span class="f-bold cnt">(${fn:length(dataList)}개)</span></div>
    
    <c:forEach items="${dataList}" var="item" varStatus="status">
        <div class="cmt-list-row ${item.depth > 0 ? 'cmt-list-depth' : ''}">
            <div class="row" style="margin-left: ${item.depth*30}px">
                <c:if test="${item.depth > 0}"><span class="t3-re">&nbsp;</span></c:if>
                <c:if test="${item.cmtContents == '_DELETE_'}">
                    <div class="text-danger">삭제된 글입니다.</div>
                </c:if>
                <c:if test="${item.cmtContents != '_DELETE_'}">
                    <div class="col-xs-6">
                        <span class="writer f-bold" data-toggle="popover" data-popover-id="${item.mgrId}" title="${item.writerNm}"><a href="#" onclick="return false;">${item.writerNm}</a></span>
                        <span class="date f-11">${item.regDt} <c:if test="${not empty item.modiDt}">(수정 : ${item.modiDt})</c:if></span>
                    </div>
                    <div class="col-xs-6 text-right">
                        <sm:button value="댓글" btnSize="btn-xs" cssClass="btn-plain" onclick="BBS.replyCommentFormPop('${smp.bbsCd}', '${smp.bbsSeq}', '${item.cmtSeq}', ${not empty item.fileList}); return false;"/>
                        <!-- 본인 의견글일 경우 -->
                        <c:if test="${item.mgrId == mgrSession.mgrId}"> 
                            <sm:button value="수정" btnSize="btn-xs" cssClass="btn-plain" onclick="BBS.updateCommentFormPop('${smp.bbsCd}', '${smp.bbsSeq}', '${item.cmtSeq}', ${not empty item.fileList}); return false;"/>
                            <sm:button value="삭제" btnSize="btn-xs" cssClass="btn-plain" onclick="BBS.commentDeleteAction('${smp.bbsCd}', '${smp.bbsSeq}', '${item.cmtSeq}'); return false;"/>
                        </c:if>
                    </div>
                    <div class="col-xs-12 contents">
                        <sm:br data="${item.cmtContents}" />
                    </div>
                    <c:if test="${not empty item.fileList}">
                        <div class="col-xs-12">
                            <sm:file-list list="${item.fileList}" />
                        </div>
                    </c:if>
                </c:if>
            </div>
        </div>
    </c:forEach>
</c:if>

<script type="text/javascript">

    Ext.onReady(function() {

        $("#commentForm").validate({
            rules: {
                cmtContents: { required: true, maxword: 2000 }
            }, 
            submitHandler: function(form) {

                SM.submit(form, {
                    url: CTX_PATH + "/bo/base/bbs/comment/TR_insertAction.do"
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        BBS.loadComment("${smp.bbsCd}", "${smp.bbsSeq}");
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
        
        parent.js_popover();
    });
</script>
