<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>
<c:set var="mgrSession" value="${sessionScope[CONSTANT.MGR_SESSION_KEY]}" />

<table class="tbl-header">
    <tr>
        <th><span class="title-big">게시판 설정 상세정보</span></th>
        <td class="tr">
            ${dataBean.useYn == 'Y' ? '' : '<span class=\'text-danger bold\'>미사용</span>'}
        </td>
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
        <th>게시판 명</th>
        <td>
            <strong>${dataBean.bbsNm}</strong>
        </td>
        <th>게시판 코드</th>
        <td>
            ${dataBean.bbsCd}
        </td>
    </tr>
    <tr>
        <th>게시판 유형</th>
        <td>
            ${dataBean.typeNm}
        </td>
        <th>게시판 폴더</th>
        <td>
            ${dataBean.folderNm}
        </td>
    </tr>
    <tr>
        <th>분류 여부</th>
        <td>
            ${dataBean.ctgYn == 'Y' ? '사용' : '미사용'}
            <c:if test="${dataBean.ctgYn == 'Y'}">
                <div class="smd-sub-box">
                <c:forEach items="${dataBean.ctgList}" var="item" varStatus="status">
                    ${item.ctgNm}<c:if test="${!status.last}">,</c:if>
                </c:forEach>
                </div>
            </c:if>
        </td>
        <th>관리전용 여부</th>
        <td>
            ${dataBean.admYn == 'Y' ? '사용' : '미사용'}
            <c:if test="${dataBean.admYn == 'Y'}">
                <div class="smd-sub-box">
                <c:forEach items="${dataBean.mgrList}" var="item" varStatus="status">
                    ${item.mgrNm}<c:if test="${!status.last}">,</c:if>
                </c:forEach>
                </div>
            </c:if>
        </td>
    </tr>
    <tr>
        <th>의견글 여부</th>
        <td>
            ${dataBean.cmtYn == 'Y' ? '사용' : '미사용'}
        </td>
        <th>공개 여부</th>
        <td>
            ${dataBean.openYn == 'Y' ? '사용' : '미사용'}
        </td>
    </tr>
    <%-- <tr>
        <th>공지 여부</th>
        <td>
            ${dataBean.ntcYn == 'Y' ? '사용' : '미사용'}
        </td>
        <th>알림 여부</th>
        <td>
            ${dataBean.alimYn == 'Y' ? '사용' : '미사용'}
        </td>
    </tr> --%>
    <tr>
        <th>첨부 여부</th>
        <td>
            ${dataBean.fileYn == 'Y' ? '사용' : '미사용'}
        </td>
        <th>첨부 수</th>
        <td>
            ${dataBean.fileCnt} 개
        </td>
    </tr>
    <tr>
        <th>HTML 여부</th>
        <td>
            ${dataBean.htmlYn == 'Y' ? '사용' : '미사용'}
        </td>
        <th>확장 테이블</th>
        <td>
            ${dataBean.tableNm}
        </td>
    </tr>
    <tr>
        <th>등록일</th>
        <td>
            ${dataBean.regDt}
        </td>
        <th>최종 수정일</th>
        <td>
            ${dataBean.modiDt}
        </td>
    </tr>
</table>

<sm:button-layout group="true">
    <sm:button value="삭제" glyph="remove" onclick="js_deleteOneAction(this, '${dataBean.bbsCd}');" />
    <sm:button value="수정" glyph="edit" onclick="js_updateForm(this, '${dataBean.bbsCd}');" />
</sm:button-layout>
