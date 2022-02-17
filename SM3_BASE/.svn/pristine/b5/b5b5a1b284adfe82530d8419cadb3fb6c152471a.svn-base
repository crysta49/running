<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<html>
<head>
    <title>${curMenuBean.menuNm}</title>
    <c:if test="${!CONSTANT.IS_DEPT_CONNECT}">
        <meta name="title" content="부서 정보를 관리합니다." />
    </c:if>
    <c:if test="${CONSTANT.IS_DEPT_CONNECT}">
        <meta name="title" content="부서 정보를 조회합니다. 시스템 연계를 통해 부서 정보는 자동으로 갱신됩니다." />
    </c:if>
</head>

<body>

<div class="row">
    <div class="col-xs-4 list-lbox">
        <div id="treeDiv"></div>
    </div>
    <div class="col-xs-8">
        <div id="viewDiv">
            <div class="bg-box bg-info text-info">좌측에서 부서명을 선택하면 상세내용을 조회할 수 있습니다.</div>
        </div>
    </div>
</div>

<form:form id="csrfForm" name="csrfForm"></form:form>

<sm:js names="validation, smtree" />
<script type="text/javascript">

    Ext.onReady(function() {
    
        SM_TREE({
            id: "treePanel",
            title: "부서목록",
            renderTo: "treeDiv",
            nodeParam: "highDeptCd",
            rootText: "부서목록",
            height: 455,
            enableDD: ${!CONSTANT.IS_DEPT_CONNECT},
            
            smViewParam: function(node) {
                return {
                    deptCd: node.data.id
                }
            },
            smInsertParam: function(node) {
                return {
                    highDeptCd: node.data.id,
                    deptNm: $("#newText").val(),
                    CSRFToken: $("#insertForm input[name=CSRFToken]").val()
                };
            },
            smUpdateParam: function(node) {
                return {
                    deptCd: node.data.id,
                    deptNm: $("#text").val(),
                    branchCd: $("#branchCd").val(),
                    orderNo: 0,
                    useYn: $("input[name=useYn]:checked").val(),
                    CSRFToken: $("#updateForm input[name=CSRFToken]").val()
                };
            },
            smMoveParam: function(node, newParent, index) {
                return {
                    deptCd: node.data.id,
                    highDeptCd: newParent.data.id,
                    orderNo: index + 1,
                    CSRFToken: $("#csrfForm input[name=CSRFToken]").val()
                }
            },
            smDeleteParam: function(node) {
                return {
                    deptCd: node.data.id,
                    CSRFToken: $("#updateForm input[name=CSRFToken]").val()
                }
            },
            smBeforeInsert: function(formId) {
                return $(formId).valid();
            },
            smBeforeUpdate: function(formId) {
                return $(formId).valid();
            }
        });
    });
</script>
    
</body>
</html>