<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>${curMenuBean.menuNm}</title>
    <meta name="title" content="시스템 전역에서 사용하는 공통코드 정보를 관리합니다." />
</head>
 
<body>

<c:set var="cacheClass" value="CodeCache" scope="request" />
<c:import url="/WEB-INF/jsp/bo/common/include/incCacheReload.jsp" charEncoding="UTF-8"/>

<form:form id="csrfForm" name="csrfForm"></form:form>

<div class="row">
    <div class="col-xs-4 list-lbox">
        <div id="grpGridDiv"></div>
        <div class="btn-blank">
            <sm:button value="그룹코드 추가" glyph="plus" onclick="CODE.insertForm(this);"/>
        </div>
    </div>
    <div class="col-xs-8">
        <div id="grpViewDiv"></div>
        <div id="prvListDiv">
            <div id="prvGridDiv"></div>
    
            <sm:button-layout align="both">
                <div class="col-xs-6">
                    <sm:button value="개별코드 추가" glyph="plus" onclick="CODE.prvRow();"/>
                </div>
                <div class="col-xs-6 text-right sr-hidden" id="dirtyCheckDiv">
                    <sm:button value="변경사항 저장" glyph="saved" onclick="CODE.prvSaveAction(this);" />
                </div>
                
            </sm:button-layout>
        </div>
    </div>
</div>

<sm:js names="validation, smgrid" />
<script type="text/javascript" src="<c:url value="/resources/fm/js/code.js"/>"></script>

</body>
</html>