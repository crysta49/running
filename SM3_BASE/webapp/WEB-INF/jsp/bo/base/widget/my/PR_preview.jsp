<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>초기화면 미리보기</title>
</head>

<body>

<c:if test="${not empty myAssignMap['TOP1'] or not empty myAssignMap['TOP2']}">
    <table class="tbl-ds">
        <tr><td class="ds-l">
        
        <c:if test="${not empty myAssignMap['TOP2']}">
            <div id="TOP2_div">
                <ul>
                    <c:forEach items="${myAssignMap['TOP2']}" var="item">
                        <li><a href="<c:url value="/bo/base/widget/modules/${item.menuCd}/${item.fileNm}${item.callParam}"/>"><span>${item.widgetNm}</span></a></li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>
        
        </td><td class="ds-r">
        
        <c:if test="${not empty myAssignMap['TOP1']}">
            <div id="TOP1_div">
                <ul>
                    <c:forEach items="${myAssignMap['TOP1']}" var="item">
                        <li><a href="<c:url value="/bo/base/widget/modules/${item.menuCd}/${item.fileNm}${item.callParam}"/>"><span>${item.widgetNm}</span></a></li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>
        
        </td></tr>
    </table>
    
    <div class="blank"></div>
</c:if>

<c:if test="${not empty myAssignMap['MID1'] or not empty myAssignMap['MID2']}">
    <table class="tbl-ds">
        <tr><td class="ds-l">
        
        <c:if test="${not empty myAssignMap['MID2']}">
            <div id="MID2_div">
                <ul>
                    <c:forEach items="${myAssignMap['MID2']}" var="item">
                        <li><a href="<c:url value="/bo/base/widget/modules/${item.menuCd}/${item.fileNm}${item.callParam}"/>"><span>${item.widgetNm}</span></a></li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>
    
        </td><td class="ds-r">
        
        <c:if test="${not empty myAssignMap['MID1']}">
            <div id="MID1_div">
                <ul>
                    <c:forEach items="${myAssignMap['MID1']}" var="item">
                        <li><a href="<c:url value="/bo/base/widget/modules/${item.menuCd}/${item.fileNm}${item.callParam}"/>"><span>${item.widgetNm}</span></a></li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>
        
        </td></tr>
    </table>
    
    <div class="blank"></div>
</c:if>

<c:if test="${not empty myAssignMap['BOT1'] or not empty myAssignMap['BOT2']}">
    <table class="tbl-ds">
        <tr><td class="ds-l">
        
        <c:if test="${not empty myAssignMap['BOT2']}">
            <div id="BOT2_div">
                <ul>
                    <c:forEach items="${myAssignMap['BOT2']}" var="item">
                        <li><a href="<c:url value="/bo/base/widget/modules/${item.menuCd}/${item.fileNm}${item.callParam}"/>"><span>${item.widgetNm}</span></a></li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>
    
        </td><td class="ds-r">
        
        <c:if test="${not empty myAssignMap['BOT1']}">
            <div id="BOT1_div">
                <ul>
                    <c:forEach items="${myAssignMap['BOT1']}" var="item">
                        <li><a href="<c:url value="/bo/base/widget/modules/${item.menuCd}/${item.fileNm}${item.callParam}"/>"><span>${item.widgetNm}</span></a></li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>
        
        </td></tr>
    </table>
</c:if>

<sm:button-layout>
    <sm:button value="미리보기 닫기" icon="check" onclick="self.close();"/>
</sm:button-layout>

<div class="blank"></div>

<sm:js names="smtab, fusionchart"/>
<script type="text/javascript">
    Ext.onReady(function() {
        <c:forEach items="${myAssignMap}" var="item">
            $("#${item.key}_div").tabs();
        </c:forEach>
    });
    
    var js_link = function(menuId, param) {
        alert("미리보기 화면에서는 지원하지 않습니다.");
    };
</script>

</body>
</html>
