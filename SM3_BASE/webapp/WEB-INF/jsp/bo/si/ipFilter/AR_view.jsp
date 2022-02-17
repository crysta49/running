<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>


<table class="tbl-header">
    <tr>
        <th><span class="title-big">접속가능 IP 상세정보</span></th>
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
        <th>IP 명</th>
        <td>
            <strong>${dataBean.ipNm}</strong>
        </td>
        <th>IP 주소</th>
        <td>
            ${dataBean.startIp}
            <c:if test="${dataBean.startIp ne dataBean.endIp}">
                ~ ${dataBean.endIp}
            </c:if>
        </td>
    </tr>
    <tr>
        <th>등록자</th>
        <td> ${dataBean.regNm} </td>
        <th>사용여부</th>
        <td> ${dataBean.useYn == "Y" ? "사용" : dataBean.useYn == "N" ? "미사용" : ""} </td>
    </tr>
    <tr>
        <th>등록일</th>
        <td> ${dataBean.regDt} </td>
        <th>최종 수정일</th>
        <td> ${dataBean.modiDt} </td>
    </tr>
</table>

<sm:button-layout group="true">
    <sm:button value="삭제" glyph="remove" onclick="js_deleteOneAction(this, '${dataBean.ipSeq}');" />
    <sm:button value="수정" glyph="edit" onclick="js_updateForm(this, '${dataBean.ipSeq}');" />
</sm:button-layout>
