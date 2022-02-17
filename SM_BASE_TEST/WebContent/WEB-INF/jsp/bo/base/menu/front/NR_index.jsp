<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>메뉴 관리</title>
    <style type="text/css">
    </style>
</head>

<body>

<div class="smd-tree-box">
    <div id="treeDiv">
        <select name="domainCd" id="domainCd" class="smf-select" onchange="js_changeDomainCd(this);"
            style="width: 100%; font-weight: bold; border-top: none; border-left: none; border-right: none;">
            <option value="">-- 도메인 선택 --</option>
            <c:forEach items="${domainList}" var="item">
                <option value="${item.domainCd}" ${item.domainCd == smp.domainCd ? 'selected=\'selected\'' : ''}>${item.domainNm} (${item.domainUrl})</option>
            </c:forEach>
        </select>
        <div id="menuTreeDiv"></div>
    </div>
    <div id="viewDiv"><span class="t3-information text-info">좌측에서 도메인과 메뉴명을 선택하면 상세내용을 조회할 수 있습니다.</span></div>
</div>

<form:form id="treeForm" name="treeForm">
</form:form>

<sm:js names="validation, smtree" />
<script type="text/javascript">
    Ext.onReady(function() {
    
        SM_TREE({
            id: "treePanel",
            title: "프론트 메뉴목록",
            renderTo: "menuTreeDiv",
            nodeParam: "highMenuCd",
            extraParams: {
                domainCd: "${smp.domainCd}"  
            },
            rootId: "${smp.domainCd}",
            rootText: ${empty smp.domainCd ? '"메뉴목록"' : '$("#domainCd :selected").text()'},
            height: 455,
            
            smViewParam: function(node) {
                return {
                    menuCd: node.data.id,
                    domainCd: "${smp.domainCd}",
                    leaf: node.data.leaf
                }
            },
            smInsertParam: function(node) {
                return {
                    highMenuCd: node.data.id,
                    domainCd: "${smp.domainCd}",
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
                    mgrId: $("#mgrId").val(),
                    menuPattern: $("#menuPattern").val(),
                    menuIcon: $("#menuIcon").val(),
                    orderNo: 0,
                    useYn: $("input[name=useYn]:checked").val(),
                    CSRFToken: $("#updateForm input[name=CSRFToken]").val()
                };
            },
            smMoveParam: function(node, newParent, index) {
                return {
                    menuCd: node.data.id,
                    highMenuCd: newParent.data.id,
                    orderNo: index + 1,
                    CSRFToken: $("#treeForm input[name=CSRFToken]").val()
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
            <c:if test="${empty smp.domainCd}">
            , listeners: {
                itemClick: function(panel, record, item, index, e, eOpts) {
                    alert("도메인을 먼저 선택하세요."); return;
                }
            }
            </c:if>
        });
    });
    
    var js_changeDomainCd = function(el) {
        
        var value = el.value;
        if (value != "") {
            self.location.href = "NR_index.do?domainCd=" + value;
        }
    };
    
    var js_showMenuMgrPop = function() {
        SM.modal({
            title: "메뉴 담당자 지정",
            width: 670,
            height: 570,
            y: -1,
            loadUrl: "PR_menuMgrForm.do"
        });
    };
    
 	// 지정된 담당자 정보 저장소
    var js_setMenuMgrValues = function(mgrId, mgrNm) {

        $("#mgrNm").val(mgrNm);
        $("#mgrId").val(mgrId);
    };
</script>

</body>
</html>