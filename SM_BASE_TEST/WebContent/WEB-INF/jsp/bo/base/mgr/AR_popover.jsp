<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>${dataBean.mgrNm}</title>
</head>

<body>
    <table class="tbl-view">
    <colgroup>
        <col width="80">
        <col>
    </colgroup>
    <tr>
        <th>부서</th>
        <td>${dataBean.deptNm}</td>
    </tr>
    <tr>
        <th>이름</th>
        <td>${dataBean.mgrNm} ${dataBean.gradeNm}</td>
    </tr>
    <tr>
        <th>ID (사번)</th>
        <td>${dataBean.mgrId}</td>
    </tr>
    <tr>
        <th>전화번호</th>
        <td>${dataBean.telNum}</td>
    </tr>
    <tr>
        <th>이메일</th>
        <td class="text-overflow">${dataBean.email}</td>
    </tr>
</table>
</body>
</html>