<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<c:choose>
    <c:when test="${not empty error}">
        <<div class="bg-box bg-danger text-danger"><span class="text-danger">${error}</span></div>
    </c:when>
    <c:when test="${not empty exceed}">
        <div class="bg-box bg-danger">
            <span class="text-danger">파일 크기가 <strong>${exceed}</strong>를 초과해서 미리보기를 할 수 없습니다.</span>
            <div class="blank"></div>
            <div class="text-info">위 목록의 내려받기 버튼을 클릭하세요.</div>
        </div>
    </c:when>
            
    <c:otherwise>
        <table class="tbl-header">
            <tr>
                <th><span class="title-big">로그 상세정보</span></th>
            </tr>
        </table>
        <table class="tbl-view">
            <tr>
                <td style="padding: 0;">
                    <c:if test="${fn:length(data) <= 13000}">
                        <pre name="code" class="java"><sm:xss value="${data}" /></pre>
                    </c:if>
                    <c:if test="${fn:length(data) > 13000}">
                        <div style="padding: 10px;">
                            <span class="text-danger">에러 내용의 크기가 커서 코드 색상변환(Highlight) 없이 내용만 출력합니다.</span>
                            <pre style="margin-top: 12px; height: 280px; overflow: auto;"><sm:xss value="${data}" /></pre>
                        </div>
                    </c:if>
                </td>
            </tr>
        </table>
        
        <script type="text/javascript">
            Ext.onReady(function() {
                dp.SyntaxHighlighter.HighlightAll("code", true, false, false, false);
                $(".dp-highlighter").height(280);
            });
        </script>
    </c:otherwise>
</c:choose>
