<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<html>
<head>
    <title>도메인 관리</title> 
</head>
 
<body>

<div class="smd-tree-box">
    <div id="treeDiv" class="no-border">
        <div id="gridDiv"></div>
        <div>
            <sm:button-layout align="left">
                <sm:button value="도메인 추가" icon="add" onclick="js_insertForm();"/>
            </sm:button-layout>
        </div>
    </div>
    <div id="viewDiv"></div>
</div>

<sm:js names="validation, smgrid" />
<script type="text/javascript">
  
    Ext.onReady(function() {

        SM_GRID({
            id: "gridPanel",
            title: "도메인",
            renderTo: "gridDiv",
            dataListUrl: "JR_list.do",
            enablePaging: false,
            remoteSort: false,
            height: 400,
            dataField: ["domainCd", "domainNm", "domainUrl"],
            dataColumns: [
                { text: "도메인코드", dataIndex: "domainCd", width: 60 },
                { text: "도메인명", dataIndex: "domainNm", width: 140 }
            ],
            tools: [{
                type: "refresh",
                qtip: "다시읽기",
                scope: this,
                handler: function(event, toolEl, panel) {
                    var me = SM.getCmp("gridPanel");
                    me.store.reload();
                }
            }],
            /*-------------------------------------
             * 공휴일 아이템 클릭 이벤트
             -------------------------------------*/
            itemClick : function(record, panel) {

                $("#viewDiv").SM_LOAD("AR_view.do", {
                    domainCd: record.data.domainCd
                }, function(){
                    panel.setLoading(false);
                });
            }
        });
    });
    
    var js_insertForm = function() {

        $("#viewDiv").SM_LOAD("AR_view.do", {});
    };
    
    var js_deleteAction = function(e, domainCd) {
        
        var me = SM.getCmp("gridPanel");

        if ( confirm("삭제 하시겠습니까?") ) {
            SM.submit(e, {
                url: "TR_deleteAction.do",
                data: { 
                    domainCd: domainCd,
                    CSRFToken: $("input[name=CSRFToken]").val()
                }
            }, function(messages, xhr) {
                if (messages.code == 200) {
                    me.store.reload();
                    $("#viewDiv").html("");
                }
            });
        }
    };
</script>
    
</body>
</html>