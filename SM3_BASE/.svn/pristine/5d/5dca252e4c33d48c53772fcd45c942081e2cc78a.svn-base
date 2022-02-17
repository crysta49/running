<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<html>
<head>
    <title>${curMenuBean.menuNm}</title>
    <meta name="title" content="서비스 메뉴별 접근권한 정보를 관리합니다." />
</head>
 
<body>

<form:form id="csrfForm" name="csrfForm"></form:form>

<div class="row">
    <div class="col-xs-3 list-lbox">
        <div id="authGridDiv"></div>
        <sm:button-layout align="left">
            <sm:button value="권한 추가" glyph="plus" onclick="AUTH.insertForm();"/>
        </sm:button-layout>
    </div>
    <div class="col-xs-9">
        <div id="authViewDiv"></div>
        <div id="menuListDiv">
            <div id="menuGridDiv"></div>
    
            <sm:button-layout>
                <div id="dirtyCheckDiv" class="text-right sr-hidden">
                    <sm:button value="변경사항 저장" glyph="saved" onclick="AUTH.saveAction(this);"/>
                </div>
            </sm:button-layout>
        </div>
    </div>
</div>


<sm:js names="validation, smgrid" />
<script type="text/javascript">
    var TOP_MENU_CD = "${CONSTANT.TOP_MENU_CD}";
</script>
<script type="text/javascript" src="<c:url value="/resources/fm/js/auth.js"/>"></script>

</body>
</html>