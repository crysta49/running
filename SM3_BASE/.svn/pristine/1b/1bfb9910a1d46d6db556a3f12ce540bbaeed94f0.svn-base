<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>게시판 분류지정</title>
</head>
 
<body>

<table class="tbl-header">
    <tr>
        <th>
            <span class="title-big">게시판 분류를 지정하세요.</span>
        </th>
        <td class="tr"></td>
    </tr>
</table>
<div>
    <div id="gridDiv"></div>

    <sm:button-layout align="both">
        <div class="col-xs-6">
            <sm:button value="분류 추가" glyph="plus" onclick="js_gridRow();"/>
        </div>
        <div id="dirtyCheckDiv" class="col-xs-6 text-right sr-hidden">
            <sm:button value="변경사항 적용" glyph="ok" onclick="js_gridSaveAction();" />
        </div>
    </sm:button-layout>
</div>

<sm:js names="smgrid" />
<script type="text/javascript">

    Ext.onReady(function() {
        
        SM_GRID({
            id: "gridPanel",
            renderTo: "gridDiv",
            enablePaging: false,
            remoteSort: false,
            height: 240,
            store: Ext.create("Ext.data.ArrayStore", {
                fields: ["ctgCd", "ctgNm", "orderNo", "isNew"],
                data: parent.ctgDatas
            }),
            plugins: [new Ext.grid.plugin.CellEditing({
                clicksToEdit: 1,
                autoCancel: true,
                listeners: {
                    /*-------------------------------------
                     * GRID 셀 편집 전처리 이벤트
                     -------------------------------------*/
                    beforeedit: function(editor, e) {
                        if (!e.record.data.isNew && e.field == "ctgCd") {
                            e.cancel = true;
                        }
                    },
                    /*-------------------------------------
                     * GRID 셀 편집 후처리 이벤트 (입력값 검증)
                     -------------------------------------*/
                    validateedit: function(editor, e) {
                        if (e.value == e.originalValue) {
                            return false;
                        }
                        if (e.field == "ctgCd") {
                            var me = SM.getCmp("gridPanel");
                            var allRecords = me.store.getRange();
                            var dup = 0;
                            Ext.each(allRecords, function(record, i){
                                var _data = record.data;
                                if (_data.ctgCd == e.value) dup++;
                            });
                            
                            if (dup > 0) {
                                e.cancel = true;
                                //alert("코드값은 중복될 수 없습니다.");
                                return false;
                            }
                        }
                    },
                    /*-------------------------------------
                     * GRID 셀 편집 후처리 이벤트
                     -------------------------------------*/
                    edit: function(editor, e) {
                        if (e.value !== e.originalValue) {
                            js_dirtyToggle();
                        }
                    },
                    /*-------------------------------------
                     * GRID 셀 편집 취소 이벤트
                     -------------------------------------*/
                    canceledit: function(editor, e) {
                        var me = e.grid;
                        var data = e.record.data;
                        if (data.isNew) {
                            if (data.ctgCd == "" && data.ctgNm == "")
                                me.store.remove(e.record);
                        }
                    }
                }
            })],
            viewConfig: {
                plugins: {
                    ptype: "gridviewdragdrop", dragText: "순서이동"
                },
                listeners: {
                    /*-------------------------------------
                     * GRID 순서변경 (DnD) 후처리 이벤트
                     -------------------------------------*/
                    drop: function(node, data, dropRec, dropPosition) {
                        var me = SM.getCmp("gridPanel");
                        var allRecords = me.store.getRange();

                        Ext.each(allRecords, function(record, i){
                            record.set("orderNo", i+1);
                        });
                        js_dirtyToggle();
                    }
                }
            },
            dataColumns: [
                { text: "코드", dataIndex: "ctgCd", sortable: false, menuDisabled: true, width: 50, align: "center", editor: { allowBlank: false, maxLength: "4", maskRe: /[0-9.]/ } },
                { text: "분류명", dataIndex: "ctgNm", sortable: false, menuDisabled: true, width: 160, editor: { allowBlank: false, maxLength: "20" } },
                { text: "순서", dataIndex: "orderNo", sortable: false, menuDisabled: true, width: 40, align: "center", 
                  editor: { xtype: "numberfield", minValue: 0, maxValue: 100, allowBlank: false } },
                { xtype: "actioncolumn",
                  width: 30, align: "center", sortable: false, menuDisabled: true,
                  items: [{
                      icon: CTX_PATH + "/resources/spi/famfamfam/icons/delete.png",
                      tooltip: "삭제", scope: this,
                      handler: function(grid, rowIndex, colIndex, item, event, record, row){
                          /*-------------------------------------
                           * 분류 GRID 아이템 삭제 클릭 이벤트
                           -------------------------------------*/
                          if (event) event.stopEvent();
                          grid.getStore().removeAt(rowIndex);
                          js_dirtyToggle();
                      }
                  }]
                }
            ]
        });
    });
    
    var js_gridRow = function() {

        var me = SM.getCmp("gridPanel");
        
        me.getStore().insert(0, {
            ctgCd: "", ctgNm: "", orderNo: 1, isNew: true
        });
        me.plugins[0].startEditByPosition({
            row: 0, column: 0
        });
    };
    
    var js_gridSaveAction = function(e) {
        
        var me = SM.getCmp("gridPanel");
        var allRecords = me.store.getRange();
        var datas = [];
        Ext.each(allRecords, function(record, i){
            if (record.data.ctgCd != "")
                datas.push(record.data);
        });

        if ( confirm("변경사항을 적용하시겠습니까?") ) {
            parent.js_setBbsCtgValues(datas, true);
            SM.modalClose();
        }
    };
    
    var js_dirtyToggle = function() {
        
        var me = SM.getCmp("gridPanel");
        
        if (me.getDirtyCount() > 0) {
            $("#dirtyCheckDiv").show();
        }
        else $("#dirtyCheckDiv").hide();
    };
</script>
                
</body>
</html>