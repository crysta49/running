<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<html>
<head>
    <title>권한 메뉴 할당</title> 
</head>
 
<body>

<div id="menuGridDiv"></div>

<sm:js names="smgrid" />
<script type="text/javascript">

    Ext.onReady(function() {

        Ext.define('Salmon.ReadOnlyCheckColumn', {
            extend: 'Ext.grid.column.CheckColumn',
            alias: 'widget.readonlycheckcolumn',
            listeners: { beforecheckchange: function () { return false; } }
        });
        
        SM_GRID({
            id: "menuGridPanel",
            title: "권한 메뉴 할당 목록",
            dataListUrl: "JR_listAuthItemAll.do?authCd=${smp.authCd}",
            checkbox: true,
            checkboxReadOnly: true,
            renderTo: "menuGridDiv",
            enablePaging: false,
            remoteSort: false,
            height: 400,
            dataField: ["menuCd", "menuNm", "menuUrl", "readYn", "createYn", "updateYn", "deleteYn", "checked"],
            dataColumns: [
                { text: "코드", dataIndex: "menuCd", sortable: false, width: 40, align: "center", menuDisabled: true },
                { text: "메뉴명", dataIndex: "menuNm", sortable: false, width: 180, menuDisabled: true },
                /* { text: "읽기", dataIndex: "readYn", sortable: false, width: 40, xtype: "readonlycheckcolumn", menuDisabled: true },
                { text: "등록", dataIndex: "createYn", sortable: false, width: 40, xtype: "readonlycheckcolumn", menuDisabled: true },
                { text: "수정", dataIndex: "updateYn", sortable: false, width: 40, xtype: "readonlycheckcolumn", menuDisabled: true },
                { text: "삭제", dataIndex: "deleteYn", sortable: false, width: 40, xtype: "readonlycheckcolumn", menuDisabled: true }, */
                { text: "URL", dataIndex: "menuUrl", sortable: false, flex: 1, menuDisabled: true }
            ],
            checkdeselect: function(model, record, index) {
                return false;
            },
            checkselect: function(model, record, index) {
                return false;
            },
            /*-------------------------------------
             * GRID STORE load listener
             -------------------------------------*/
            storeload: function(store, records, success) {
                if (success) {
                    var me = SM.getCmp("menuGridPanel");
                    var sm = me.getSelectionModel();

                    Ext.each(records, function(record) {
                        if (record.data.checked){
                            var row = record.index;
                            sm.select(row, true, true);
                        }
                    });
                }
            },
            tools: [{
                type: "refresh",
                qtip: "다시읽기",
                scope: this,
                handler: function(event, toolEl, panel) {
                    var me = SM.getCmp("menuGridPanel");
                    me.store.reload();
                }
            }]
        });
    });
</script>
    
</body>
</html>