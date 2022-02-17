<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>CSS 샘플</title>
    <style type="text/css">
    .smd-box div.cnt-class { color: #397D33; padding: 0 0 10px 0; }
    </style>
</head>
 
<body>

<table class="tbl-header">
    <tr>
        <th>
            <span class="title-big">테이블</span>
            <span class="title-small">.tbl-view</span>
        </th>
        <td class="tr"><span>상세보기 테이블 샘플 입니다.</span></td>
    </tr>
</table>
<table class="tbl-view">
    <colgroup>
        <col class="th">
        <col>
    </colgroup>
    <tr>
        <th>메뉴 코드</th>
        <td>1000</td>
    </tr>
    <tr>
        <th>메뉴 명</th>
        <td>메뉴관리</td>
    </tr>
    <tr>
        <th>메뉴 경로</th>
        <td>/루트/환경관리/메뉴관리</td>
    </tr>
</table>

<div class="blank"></div>

<table class="tbl-header">
    <tr>
        <th>
            <span class="title-big">폼</span>
            <span class="title-small">.smf-text .smf-ta .smf-select .smf-radio .smf-checkbox .smf-select</span>
        </th>
        <td class="tr"><span>폼 샘플 입니다.</span></td>
    </tr>
</table>
<table class="tbl-view">
    <colgroup>
        <col class="th">
        <col>
    </colgroup>
    <tr>
        <th>메뉴 코드</th>
        <td>362</td>
    </tr>
    <tr>
        <th>메뉴 명<em>&nbsp;</em></th>
        <td>
            <input id="text" name="text" class="smf-text" type="text" value="샘플페이지" size="40">
        </td>
    </tr>
    <tr>
        <th>메뉴 URL</th>
        <td>
            <input id="menuUrl" name="menuUrl" class="smf-text" type="text" value="" size="50">
        </td>
    </tr>
    <tr>
        <th>사용 여부</th>
        <td>
            <input id="useYn1" name="useYn" class="smf-radio" type="radio" value="Y" checked="checked"><label for="useYn1">사용</label>
            <input id="useYn2" name="useYn" class="smf-radio" type="radio" value="N"><label for="useYn2">미사용</label>
        </td>
    </tr>
    <tr>
        <th>추가 옵션</th>
        <td>
            <div><input type="radio" name="appendOption" id="isSame" value="isSame" class="smf-radio"><label for="isSame">선택한 메뉴 동일 레벨에 추가</label></div>
            <div><input type="radio" name="appendOption" id="isChild" value="isChild" class="smf-radio"><label for="isChild">선택한 메뉴 하위 레벨에 추가</label></div>
            <div><input type="radio" name="appendOption" id="isRoot" value="isRoot" class="smf-radio" checked="checked"><label for="isRoot">루트 메뉴에 추가</label></div>
        </td>
    </tr>
</table>

<div class="blank"></div>

<table class="tbl-header">
    <tr>
        <th>
            <span class="title-big">버튼 레이아웃</span>
            <span class="title-small">&lt;sm:button-layout align="both" /&gt;</span>
        </th>
        <td class="tr"><span>버튼 레이아웃 샘플 입니다.</span></td>
    </tr>
</table>
<div class="smd-box">
    <sm:button-layout align="both">
        <div>
            <sm:button value="등록" icon="b3-db-save" />
            <sm:button value="취소" icon="b3-arrow-undo" />
        </div>
        <div class="left">
            <sm:button value="수정" icon="b3-db-edit" />
        </div>
    </sm:button-layout>
    
    <hr/>
    <div class="cnt-class">&lt;sm:button-layout align="left" /&gt; 아이콘 없음</div>
    <sm:button-layout align="left">
        <sm:button value="등록" />
        <sm:button value="취소" />
    </sm:button-layout>
        
    <hr/>
    <div class="cnt-class">&lt;sm:button-layout align="center" /&gt;</div>
    <sm:button-layout align="center">
        <sm:button value="등록" icon="b3-db-save" />
        <sm:button value="취소" icon="b3-arrow-undo" />
    </sm:button-layout>
        
    <hr/>
    <div class="cnt-class">&lt;sm:button-layout /&gt;</div>
    <sm:button-layout>
        <sm:button value="등록" icon="b3-db-save" />
        <sm:button value="취소" icon="b3-arrow-undo" />
    </sm:button-layout>
</div>

<div class="blank"></div>

<table class="tbl-header">
    <tr>
        <th>
            <span class="title-big">버튼 아이콘</span>
        </th>
        <td class="tr"><span>버튼 아이콘 샘플 입니다.</span></td>
    </tr>
</table>
<div class="smd-box" style="height: auto;">
    <div class="cnt-class">&lt;sm:button value="버튼 텍스트" /&gt;</div>
    <sm:button value="아이콘 없음" /> <sm:button value="검색" />
    
    <div class="blank"></div><div class="blank"></div>
    
    <div class="cnt-class">&lt;sm:button value="버튼 텍스트" tip="이것은 TIP입니다." /&gt;</div>
    <sm:button value="아이콘 없음" tip="이것은 아이콘 없음 TIP입니다."/> <sm:button value="검색" tip="이것은 검색 TIP입니다."/>
    
    <div class="blank"></div><div class="blank"></div>
       
    <div class="cnt-class">&lt;sm:button value="버튼 텍스트" icon="버튼 아이콘" /&gt;</div>

    <sm:button icon="check" value="check" /> <sm:button icon="add" value="add" />
    <sm:button icon="delete" value="delete" /> <sm:button icon="calendar" value="calendar" />
    <sm:button icon="refresh" value="refresh" /> <sm:button icon="download" value="download" />
    <div class="blank"></div>
    <sm:button icon="b3-db-save" value="저장 | b3-db-save" /> <sm:button icon="b3-db-delete" value="삭제 | b3-db-delete" /> 
    <sm:button icon="b3-db-add" value="추가 | b3-db-add" /> <sm:button icon="b3-db-edit" value="수정 | b3-db-edit" />
    <div class="blank"></div>
    <sm:button icon="b3-user" value="사용자 | b3-user" /> <sm:button icon="b3-group-link" value="할당 | b3-group-link" />
    <sm:button icon="b3-tick" value="목록 | 확인 | b3-tick" /> <sm:button icon="b3-arrow-undo" value="취소 | b3-arrow-undo" />
    <div class="blank"></div>
    <sm:button icon="b3-arrow-refresh" value="다시읽기 | b3-arrow-refresh" /> 
    <sm:button icon="b3-printer" value="출력 | 인쇄 | b3-printer" /> <sm:button icon="b3-loading" value="처리중 | b3-loading" /> 
    <div class="blank"></div>
    <sm:button icon="b3-heart-add" value="스크랩 | b3-heart-add" /> <sm:button icon="b3-heart-delete" value="스크랩 삭제 | b3-heart-delete" />
    <sm:button icon="b3-search" value="검색 | b3-search" /> <sm:button icon="b3-search-reset" value="검색해제 | b3-search-reset" />
    <div class="blank"></div>
    <sm:button icon="b3-excel" value="엑셀 | b3-excel" />
    <sm:button icon="b3-user-go" value="처리자 지정 | b3-user-go" />
    <sm:button icon="b3-dept" value="주무부서 | b3-dept" />
    <sm:button icon="b3-dept-add" value="협조부서 | b3-dept-add" />

    <div class="blank"></div><div class="blank"></div> 
    
    <div class="cnt-class">
        &lt;sm:button value="버튼 텍스트" glyph="버튼 아이콘" /&gt; =>
        <a href="http://fortawesome.github.io/Font-Awesome/icons/" target="_blank">http://fortawesome.github.io/Font-Awesome/icons/</a>
    </div>
    <sm:button glyph="fa-download" value="다운로드 | fa-download" />
    <sm:button glyph="fa-plus" value="추가 | fa-plus" />
</div>

<div class="blank"></div>

<table class="tbl-header">
    <tr>
        <th>
            <span class="title-big">텍스트 아이콘</span>
            <span class="title-small">&lt;span class="아이콘"&gt;텍스트&lt;/span&gt;</span>
        </th>
        <td class="tr"><span>텍스트 아이콘 샘플 입니다.</span></td>
    </tr>
</table>
<div class="smd-box">
    <span class="t3-accept">수락 | t3-accept</span> &nbsp; 
    <span class="t3-add">추가 | t3-add</span> &nbsp; 
    <span class="t3-cross">삭제 | t3-cross</span> &nbsp; 
    <span class="t3-delete">삭제 | t3-delete</span> &nbsp; 
    <span class="t3-cancel">취소 | t3-cancel</span> &nbsp; 
    <div class="blank"></div>
    <span class="t3-disk">다운로드 | t3-disk</span> &nbsp; 
    <span class="t3-disk-small">다운로드 | t3-disk-small</span> &nbsp; 
    <span class="t3-download">다운로드 | t3-download</span> &nbsp; 
    <span class="t3-exclamation">경고 | t3-exclamation</span> &nbsp; 
    <span class="t3-title">제목 | t3-title</span> &nbsp; 
    <div class="blank"></div>
    <span class="t3-title-small">제목 | t3-title-small</span> &nbsp; 
    <span class="t3-loader">로딩중 | t3-loader</span> &nbsp; 
    <span class="t3-db-table">로그조회 | t3-db-table</span> &nbsp; 
    <span class="t3-information">정보 | t3-information</span> &nbsp; 
    <span class="t3-help">도움말 | t3-help</span> &nbsp; 
    
    
</div>

<div class="blank"></div>

<table class="tbl-header">
    <tr>
        <th>
            <span class="title-big">라벨, 뱃지</span>
            <span class="title-small">&lt;span class="label label-success"&gt;텍스트&lt;/span&gt;</span>
        </th>
        <td class="tr"><span>라벨, 뱃지 텍스트 샘플 입니다.</span></td>
    </tr>
</table>
<div class="smd-box">
    <span class="label label-success">성공 | label label-success</span> &nbsp; 
    <span class="label label-warning">경고 | label label-warning</span> &nbsp; 
    <span class="label label-danger">중요 | label label-danger</span> &nbsp; 
    <span class="label label-info">정보 | label label-info</span> &nbsp; 
    <span class="label label-inverse">반전 | label label-inverse</span> &nbsp; 
    <div class="blank"></div>
    <span class="badge badge-success">10</span> badge badge-success &nbsp; 
    <span class="badge badge-warning">20</span> badge badge-warning &nbsp; 
    <span class="badge badge-danger">30</span> badge badge-danger &nbsp; 
    <span class="badge badge-info">40</span> badge badge-info &nbsp; 
    <span class="badge badge-inverse">50</span> badge badge-inverse &nbsp; 
</div>

</body>
</html>