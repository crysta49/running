<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<c:set var="exist" value="${not empty dataBean && dataBean.deptCd ne '0'}" />

<c:if test="${exist}">

    <table class="tbl-header">
        <tr>
            <th><span class="title-big">부서 상세정보</span></th>
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
            <th>부서 경로</th>
            <td colspan="3"><span id="treePath"></span></td>
        </tr>
        <tr>
            <th>부서 코드</th>
            <td>
                ${dataBean.deptCd}
            </td>
            <th>정렬 순서</th>
            <td id="orderNo">
                ${dataBean.orderNo}
            </td>
        </tr>
        <tr>
            <th>부서 명</th>
            <td colspan="3">
                ${dataBean.deptNm}
            </td>
        </tr>
        <c:if test="${CONSTANT.USE_BRANCH}">
        <tr>
            <th>부점 명</th>
            <td colspan="3">
                ${dataBean.branchNm}
            </td>
        </tr>
        </c:if>
        <tr>
            <th>사용 여부</th>
            <td colspan="3">
                ${dataBean.useYn == 'Y' ? "사용" : "미사용"}
            </td>
        </tr>
        <tr>
            <th>등록일</th>
            <td>${dataBean.regDt}</td>
            <th>최종 수정일</th>
            <td>${dataBean.modiDt}</td>
        </tr>
    </table>
</c:if>

<c:if test="${!exist}">
    <div class="bg-box bg-info text-info">좌측에서 부서명을 선택하면 상세내용을 조회할 수 있습니다.</div>
</c:if>
