<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<table class="tbl-header">
    <tr>
        <th><span class="title-big">에러 상세정보</span></th>
        <td class="tr">
            <span class="label label-info">${dataBean.regDt} 발생</span> 
            <c:if test="${dataBean.solvYn == 'Y'}">
                <span class="label label-default">${dataBean.solvDt} 해결</span>
            </c:if>
            <c:if test="${dataBean.solvYn == 'N'}">
                <span class="label label-danger">미해결</span>
            </c:if>
        </td>
    </tr>
</table>

<table class="tbl-view">
    <tr>
        <td style="padding: 0; border-bottom: 0;">
            <c:if test="${fn:length(dataBean.contents) <= 13000}">
                <pre name="code" class="java"><sm:xss value="${dataBean.contents}" /></pre>
            </c:if>
            <c:if test="${fn:length(dataBean.contents) > 13000}">
                <div style="padding-top: 10px;">
                    <span class="text-danger">에러 내용의 크기가 커서 코드 색상변환(Highlight) 없이 내용만 출력합니다.</span>
                    <pre style="border-radius: 0; margin-top: 10px; height: 280px; overflow: auto;"><sm:xss value="${dataBean.contents}" /></pre>
                </div>
            </c:if>
        </td>
    </tr>
</table>

<sm:button-layout group="true">
    <sm:button value="삭제" glyph="remove" onclick="js_deleteOneAction(this, '${dataBean.seq}');" />
    <c:if test="${dataBean.solvYn == 'N'}">
        <sm:button value="해결로 변경" glyph="ok" onclick="js_solvedAction(this, '${dataBean.seq}');"/>
    </c:if>
</sm:button-layout>

<script type="text/javascript">
    Ext.onReady(function() {
        dp.SyntaxHighlighter.HighlightAll("code", true, false, false, false);
        $(".dp-highlighter").height(280);
    });
</script>