<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>
<c:set var="userSession" value="${sessionScope[CONSTANT.USER_SESSION_KEY]}" />

<form:form name="commentForm" id="commentForm" method="post" action="#" enctype="multipart/form-data">
    <input type="hidden" name="bbsCd" value="${smp.bbsCd}" />
    <input type="hidden" name="bbsSeq" value="${smp.bbsSeq}" />

    <table style="margin-bottom: 12px;">
        <tr>
            <td>의견글 등록</td>
            <td>
                <span id="cmtContents_wc" class="bold">0</span>/2,000
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <textarea name="cmtContents" id="cmtContents" rows="4" class="wc" data-wc="2000" data-label="의견글 내용"></textarea>
            </td>
        </tr>
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
                <sm:button type="submit" value="등록" icon="b3-db-save" />
            </td>
        </tr>
    </table>
</form:form>

<c:forEach items="${dataList}" var="item" varStatus="status">
    <table style="margin-left: ${item.depth*20}px; margin-bottom: 12px;">
        <tr>
            <td>
                <c:if test="${item.depth > 0}"><span>↘</span></c:if>
                ${item.writerNm} 
                <span class="gray">${item.regDt}
                    <c:if test="${not empty item.modiDt}">(수정 : ${item.modiDt})</c:if>
                </span>
                <sm:new-icon date="${item.regDt}"/>
            </td>
            <td style="text-align: right;">
                <c:if test="${item.cmtContents != '_DELETE_'}">
                    <a href="#" onclick="BBS.replyCommentFormPop('${smp.bbsCd}', '${smp.bbsSeq}', '${item.cmtSeq}'); return false;"><span class="label">댓글</span></a>
                    <!-- 본인 의견글일 경우 -->
                    <c:if test="${not empty item.userKey and item.userKey == userSession.userKey}">
                        <a href="#" onclick="BBS.updateCommentFormPop('${smp.bbsCd}', '${smp.bbsSeq}', '${item.cmtSeq}'); return false;"><span class="label">수정</span></a>
                        <a href="#" onclick="BBS.commentDeleteAction('${smp.bbsCd}', '${smp.bbsSeq}', '${item.cmtSeq}'); return false;"><span class="label">삭제</span></a>
                    </c:if>
                </c:if>
            </td>
        </tr>
        <c:if test="${item.cmtContents != '_DELETE_'}">
            <tr>
                <td colspan="2">
                <sm:br data="${item.cmtContents}" />
                    
                <sm:file-list list="${item.fileList}" />
                </td>
            </tr>
        </c:if>
        <c:if test="${item.cmtContents == '_DELETE_'}">
            <tr>
                <td colspan="2">삭제된 글입니다.</td>
            </tr>
        </c:if>
    </table>

</c:forEach>

<sm:no-data dataBean="${dataList}" colspan="2" />

<script type="text/javascript">

    $().ready(function(){
        $("#commentForm").validate({
            rules: {
                cmtContents: { required: true, maxword: 2000 }
            }, 
            submitHandler: function(form) {

                SM.submit(form, {
                    url: "<c:url value="/fe/bbs/comment/TR_insertAction.do"/>"
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        $("#commentDiv").SM_LOAD("<c:url value="/fe/bbs/comment/AR_list.do"/>", {
                            bbsCd: "${smp.bbsCd}",
                            bbsSeq: "${smp.bbsSeq}"
                        });
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
