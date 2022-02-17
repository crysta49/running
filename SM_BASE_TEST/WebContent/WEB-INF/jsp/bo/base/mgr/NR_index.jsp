<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<html>
<head>
    <title>${curMenuBean.menuNm}</title>
    <c:if test="${!CONSTANT.IS_DEPT_CONNECT}">
        <meta name="title" content="직원 정보를 관리합니다." />
    </c:if>
    <c:if test="${CONSTANT.IS_DEPT_CONNECT}">
        <meta name="title" content="직원 정보를 조회합니다. 시스템 연계를 통해 직원 정보는 자동으로 갱신됩니다." />
    </c:if>
</head>

<body>

<div class="row">
    <div class="col-xs-4 list-lbox">
        <div id="treeDiv"></div>
    </div>
    <div class="col-xs-8">
        <div id="viewDiv">
            <table class="tbl-header">
                <tr>
                    <th style="width: 30%;">
                        <span class="title-big">직원목록</span>
                    </th>
                    <td class="tr">
                        <form name="dataForm" method="get" onsubmit="return MGR.search();">
                            <select name="authCd" id="authCd" class="smf-select" onchange="MGR.search();">
                                <option value="">-- 할당권한 --</option>
                                <c:forEach items="${authList}" var="item">
                                    <option value="${item.authCd}">${item.authNm}</option>
                                </c:forEach>
                            </select>
                            <input type="text" name="searchVal" id="searchVal" value="" class="smf-text"/>
                            <sm:button type="submit" cssClass="btn-default" glyph="search" value="검색" />
                            <span id="resetSearchDiv" class="sr-hidden">
                                <sm:button value="해제" cssClass="btn-default" onclick="MGR.resetSearch();" />
                            </span>
                        </form>
                    </td>
                </tr>
            </table>
            <div id="mgrGridDiv"></div>
            
            <sm:button-layout group="true">
                <sm:button value="엑셀" glyph="floppy-save" onclick="MGR.excelAction(this);"/>
                <c:if test="${!CONSTANT.IS_DEPT_CONNECT}">
                    <sm:button value="추가" glyph="plus" onclick="MGR.formPop('');"/>
                </c:if>
            </sm:button-layout>
            
        </div>
    </div>
</div>

<form:form id="csrfForm" name="csrfForm"></form:form>

<sm:js names="validation, smtree, smgrid" />
<script type="text/javascript" src="<c:url value="/resources/fm/js/mgr.js"/>" 
    id="mgr-js" data-dept-connect="${CONSTANT.IS_DEPT_CONNECT}"></script>

</body>
</html>