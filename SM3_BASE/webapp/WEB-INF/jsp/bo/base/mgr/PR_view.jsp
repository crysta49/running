<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>직원정보 조회</title>
</head>
 
<body>

<table class="tbl-header">
    <tr>
        <th>
            <span class="title-big">직원정보 조회</span>
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
            <strong>${dataBean.mgrNm}</strong>
            <c:if test="${dataBean.useYn == 'N'}"><span class="text-danger bold">미사용</span></c:if>
        </td>
        <th>ID (사번)</th>
        <td>
            ${dataBean.mgrId}
            <c:if test="${not empty dataBean.connId}">(연게 ID : ${dataBean.connId})</c:if>
        </td>
    </tr>
    <tr>
        <th>부서</th>
        <td>${dataBean.deptNm}</td>
        <th>직급</th>
        <td>${dataBean.gradeNm}</td>
    </tr>
    <tr>
        <th>전화번호</th>
        <td>${dataBean.telNum}</td>
        <th>역할</th>
        <td>${dataBean.roleNm}</td>
    </tr>
    <tr>
        <th>휴대폰번호</th>
        <td>${dataBean.mobile}</td>
        <th>팩스번호</th>
        <td>${dataBean.faxNum}</td>
    </tr>
    <tr>
        <th>이메일</th>
        <td>${dataBean.email}</td>
        <th>알림</th>
        <td>
            <c:if test="${dataBean.smsYn == 'Y' }">휴대폰</c:if>
            <c:if test="${dataBean.emailYn == 'Y' }">${dataBean.smsYn == 'Y' ? ', ' : '' }이메일</c:if>
            <%-- <c:if test="${dataBean.alimYn == 'Y' }">${dataBean.smsYn == 'Y' || dataBean.emailYn == 'Y' ? ', ' : '' }메신저</c:if> --%>
        </td>
    </tr>
    <tr>
        <th>접속일</th>
        <td>${dataBean.loginDt}</td>
        <th>접속</th>
        <td>${dataBean.loginCnt} 회</td>
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