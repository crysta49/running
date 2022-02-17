<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>고객정보 조회</title>
</head>
 
<body>

<table class="tbl-header">
    <tr>
        <th>
            <span class="title-big">고객정보 조회</span>
        </th>
        <td class="tr"></td>
    </tr>
</table>
<table class="tbl-view">
    <colgroup>
        <col class="th">
        <col>
        <col class="th">
        <col>
    </colgroup>
    <tr>
        <th>이름</th>
        <td>
            <strong>${dataBean.userNm}</strong>
            <c:if test="${dataBean.useYn == 'N'}"><span class="emphasis">미사용</span></c:if>
        </td>
        <th>ID</th>
        <td>
            ${dataBean.userId}
        </td>
    </tr>
    <tr>
        <th>전화번호</th>
        <td>${dataBean.userEncTelNum}</td>
        <th>고객유형</th>
        <td>${dataBean.typeNm}</td>
    </tr>
    <tr>
        <th>휴대폰</th>
        <td>${dataBean.userEncMobile}</td>
        <th>이메일</th>
        <td>${dataBean.userEncEmail}</td>
    </tr>
    <tr>
        <th>주소</th>
        <td colspan="3">
            <c:if test="${not empty dataBean.postCd }">[${dataBean.postCd}] </c:if>${dataBean.addr1} ${dataBean.addr2}
        </td>    
    </tr>
    <tr>
        <th>등록일</th>
        <td>${dataBean.regDt}</td>
        <th>최종 수정일</th>
        <td>${dataBean.modiDt}</td>
    </tr>
</table>

<script type="text/javascript">

    Ext.onReady(function() {

    });
    
</script>
                
</body>
</html>