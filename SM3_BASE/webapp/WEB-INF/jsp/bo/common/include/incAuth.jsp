<%@ page contentType="text/html;charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<div id="authInfoDiv" class="hidden">
    <table class="tbl-header">
        <tr>
            <th><span class="title-big">권한정보 조회</span></th>
            <td class="tr"><sm:button value="닫기" onclick="$('#authInfoDiv').hide();"/></td>
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
            <th>메뉴코드</th>
            <td>${auth.menuCd}</td>
            <th>메뉴패턴</th>
            <td>${auth.menuPattern}</td>
        </tr>
        <tr>
            <th>조회</th>
            <td>${auth.readYn}</td>
            <th>등록</th>
            <td>${auth.createYn}</td>
        </tr>
        <tr>
            <th>수정</th>
            <td>${auth.updateYn}</td>
            <th>삭제</th>
            <td>${auth.deleteYn}</td>
        </tr>
    </table>
    <div class="blank"></div>
</div>