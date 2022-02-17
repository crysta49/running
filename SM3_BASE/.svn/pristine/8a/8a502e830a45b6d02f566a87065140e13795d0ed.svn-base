<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>위젯 관리</title> 
</head>
 
<body>

<div class="smd-tree-box">
    <div id="treeDiv" class="no-border">
        <div id="widgetGridDiv"></div>
        <div>
            <sm:button-layout align="left">
                <sm:button value="위젯 추가" icon="add" onclick="js_insertForm();"/>
            </sm:button-layout>
        </div>
    </div>
    <div id="viewDiv"></div>
</div>

<sm:js names="validation, smgrid" />
<script type="text/javascript">
  
    Ext.onReady(function() {

        SM_GRID({
            id: "widgetPanel",
            title: "위젯",
            renderTo: "widgetGridDiv",
            dataListUrl: "JR_list.do",
            enablePaging: false,
            remoteSort: false,
            height: 400,
            dataField: ["seq", "widgetNm", "fileNm", "useYn"],
            dataColumns: [
                { text: "위젯", dataIndex: "widgetNm", width: 120, sortable: false },
                { text: "파일", dataIndex: "fileNm", width: 80, sortable: false }
            ],
            tools: [{
                type: "refresh",
                qtip: "다시읽기",
                scope: this,
                handler: function(event, toolEl, panel) {
                    var me = SM.getCmp("widgetPanel");
                    me.store.reload();
                }
            }],
            /*-------------------------------------
             * 위젯 아이템 클릭 이벤트
             -------------------------------------*/
            itemClick : function(record, panel) {

                $("#viewDiv").SM_LOAD("AR_view.do", {
                    seq: record.data.seq
                }, function(){
                    panel.setLoading(false);
                });
            }
        });
    });
    
    var js_insertForm = function() {

        $("#viewDiv").SM_LOAD("AR_view.do", {});
    };
    
    var js_deleteAction = function(e, seq) {
        
        var me = SM.getCmp("widgetPanel");

        if ( confirm("삭제 하시겠습니까?\n\n사용중인 직원에 연결된 위젯정보가 모두 삭제됩니다.") ) {
            SM.submit(e, {
                url: "TR_deleteAction.do",
                data: { 
                    seq: seq,
                    CSRFToken: $("#dataForm input[name=CSRFToken]").val()
                }
            }, function(messages, xhr) {
                if (messages.code == 200) {
                    me.store.reload();
                    $("#viewDiv").html("");
                }
            });
        }
    };

    var js_assignPop = function(seq) {

        SM.modal({
            title: "위젯 사용 직원 목록",
            width: 550, height: 380,
            loadUrl: "PR_assignList.do?seq=" + seq
        });
    };
</script>
    
</body>
</html>