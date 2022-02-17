<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<table class="tbl-header">
    <tr>
        <th><span class="title-big">공지글 상세정보</span></th>
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
        <th>제목</th>
        <td colspan="3">
            <span>[${dataBean.bbsNm}]</span>
            <strong>${dataBean.title}</strong>
        </td>
    </tr>
    <tr>
        <td colspan="4" class="contents-view">
            <div id="contents-desc" class="hidden">${dataBean.contents}</div>
            <div id="contents-frame"></div>
        </td>
    </tr>
    <tr>
        <th>공지 기간</th>
         <td colspan="3">
            ${dataBean.startDd} ~ ${dataBean.endDd}
        </td>
    </tr>
    <tr>
        <th>첨부파일</th>
        <td colspan="3">
            <sm:file-list list="${dataBean.fileList}"/>
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

<sm:button-layout>
    <sm:button value="삭제" icon="b3-db-delete" onclick="js_deleteOneAction(this, '${dataBean.ntcSeq}');" />
    <sm:button value="수정" icon="b3-db-edit" onclick="js_updateForm(this, '${dataBean.ntcSeq}');" />
</sm:button-layout>

<script type="text/javascript">

    $().ready(function(){
        SM.generateViewFrame( $(".contents-view") );
    });
</script>