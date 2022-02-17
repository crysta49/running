<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>${curMenuBean.menuNm}</title>
    <meta name="title" content="시스템 전역에서 사용하는 메뉴 정보를 관리합니다." />
</head>

<body>

<div class="row">
    <div class="col-xs-4 list-lbox">
        <div id="treeDiv"></div>
    </div>
    <div class="col-xs-8">
        <div id="viewDiv">
            <div class="bg-box bg-info text-info">좌측에서 메뉴명을 선택하면 상세내용을 조회할 수 있습니다.</div>
        </div>
    </div>
</div>

<form:form id="csrfForm" name="csrfForm"></form:form>

<sm:js names="validation, smtree" />
<script type="text/javascript">

    Ext.onReady(function() {
    
        SM_TREE({
            id: "treePanel",
            title: "메뉴목록",
            renderTo: "treeDiv",
            nodeParam: "highMenuCd",
            rootText: "메뉴목록",
            height: 455,
            
            smViewParam: function(node) {
                
                return {
                    menuCd: node.data.id,
                    leaf: node.data.leaf,
                    depth: node.data.depth
                }
            },
            smInsertParam: function(node) {
                return {
                    highMenuCd: node.data.id,
                    menuNm: $("#newText").val(),
                    CSRFToken: $("#insertForm input[name=CSRFToken]").val()
                };
            },
            smUpdateParam: function(node) {
                return {
                    menuCd: node.data.id,
                    menuNm: $("#text").val(),
                    menuId: $("#menuId").val(),
                    menuUrl: $("#menuUrl").val(),
                    menuPattern: $("#menuPattern").val(),
                    menuIcon: $("#menuIcon").val(),
                    orderNo: 0,
                    dividerYn: $("input[name=dividerYn]:checked").val(),
                    useYn: $("input[name=useYn]:checked").val(),
                    CSRFToken: $("#updateForm input[name=CSRFToken]").val()
                };
            },
            smMoveParam: function(node, newParent, index) {
                return {
                    menuCd: node.data.id,
                    highMenuCd: newParent.data.id,
                    orderNo: index + 1,
                    CSRFToken: $("#csrfForm input[name=CSRFToken]").val()
                }
            },
            smDeleteParam: function(node) {
                return {
                    menuCd: node.data.id,
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
    
    var js_authListPop = function(authCd) {
        
        SM.modal({
            title: "권한 메뉴 할당 정보",
            width: 700, height: 460,
            loadUrl: CTX_PATH + "/bo/base/auth/PR_listAuthItem.do?authCd=" + authCd
        });
    };
</script>

</body>
</html>