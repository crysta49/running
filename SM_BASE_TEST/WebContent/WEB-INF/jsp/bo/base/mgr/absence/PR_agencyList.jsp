<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>대리인 지정</title>
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
                    <th style="width: 20%;"><span class="title-big">직원목록</span></th>
                    <td class="tr">
                        <form name="dataForm" method="get" onsubmit="return js_search();">
                            <input type="text" name="searchVal" id="searchVal" value="" class="smf-text" placeholder="직원명을 입력하세요."/>
                            <sm:button type="submit" cssClass="btn-default" glyph="search" value="검색" />
                            <span id="resetSearchDiv" class="sr-hidden">
                                <sm:button value="해제" cssClass="btn-default" onclick="js_resetSearch();" />
                            </span>
                        </form>
                    </td>
                </tr>
            </table>
            <div id="mgrGridDiv"></div>
            <table class="tbl-header" style="margin-top: 4px;">
                <tr>
                    <th>지정 대리인 목록</th>
                    <td class="tr">
                        <span class="t3-help smtip" style="padding-left: 13px;">&nbsp;</span>
                        <div class="sr-hidden">
                            <div class="smtip-title">대리인 지정 방법</div>
                            <div class="smtip-text">
                                <div>직원 목록에서 대상직원을 더블클릭하거나, 지정 대리인 목록으로 해당 직원을 끌어다 놓으세요. (Drag &amp; Drop)</div>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
            <div id="assignMgrGridDiv"></div>
        </div>
    </div> 
</div>

<sm:button-layout align="both">
    <div class="col-xs-8">
        <div class="text-info">가능하면 동일한 권한을 보유한 직원을 지정하세요.</div>
    </div>
    <div class="col-xs-4 text-right">
        <sm:button value="변경사항 적용" glyph="ok" onclick="js_gridSaveAction();" />
    </div>
</sm:button-layout>

<sm:js names="smtree, smgrid" />
<script type="text/javascript">
    Ext.onReady(function() {
        
        SM_TREE({
            id: "treePanel",
            title: "부서목록",
            renderTo: "treeDiv",
            rootText: "부서목록",
            nodeParam: "highDeptCd",
            height: 446,
            enableDD: false,
            dataListUrl: CTX_PATH + "/bo/base/dept/JR_list.do",
            extraParams: {
                useYn: "Y"
            },
            listeners: {
                /*-------------------------------------
                 * 부서트리 노드 클릭 이벤트
                 -------------------------------------*/
                itemClick: function(panel, record, item, index, e, eOpts) {
                    js_deptSearch(record.data.id);
                }
            }
        });
        
        SM_GRID({
            id: "mgrPanel",
            renderTo: "mgrGridDiv",
            dataListUrl: CTX_PATH + "/bo/base/mgr/JR_list.do",
            extraParams: {
                useYn: "Y",
                mgrId: "${smp.mgrId}"
            },
            height: 200,
            showRownum: true,
            pagingInfo: false,
            pageSize: "<c:out value='${empty smp.rowPerPage ? CONSTANT.RPP_CNT : smp.rowPerPage}' />",
            dataField: ["deptNm", "mgrId", "mgrNm"],
            dataColumns: [
                { text: "부서", dataIndex: "deptNm", sortable: false, menuDisabled: true, width: 140 },
                { text: "이름", dataIndex: "mgrNm", sortable: false, menuDisabled: true, width: 90 },
                { text: "ID", dataIndex: "mgrId", sortable: false, menuDisabled: true, width: 80 }
            ],
            viewConfig: {
                copy: true,
                plugins: {
                    ptype: "gridviewdragdrop",
                    dragGroup: "sourceDDGroup",
                    dragText: "아래 지정 처리자 영역으로 이동하세요."
                }
            },
            itemDblClick: function(record, panel) {
                var me = SM.getCmp("assignMgrPanel");
                var allRecords = me.store.getRange();
                
                if (allRecords.length == 0) me.getStore().insert(0, record.data);
            }
        });
        
        SM_GRID({
            id: "assignMgrPanel",
            renderTo: "assignMgrGridDiv",
            height: 170,
            enablePaging: false,
            remoteSort: false,
            dataField: ["deptNm", "mgrId", "mgrNm"],
            store: Ext.create("Ext.data.ArrayStore", {
                fields: ["deptNm", "mgrId", "mgrNm"],
                data: parent == self ? 
                        (opener.agencyDatas.length == 0 ? [] : opener.agencyDatas) : 
                            (parent.agencyDatas.length == 0 ? [] : parent.agencyDatas)
            }),
            dataColumns: [
                { text: "부서", dataIndex: "deptNm", sortable: false, menuDisabled: true, width: 140 },
                { text: "이름", dataIndex: "mgrNm", sortable: false, menuDisabled: true, width: 90 },
                { text: "ID", dataIndex: "mgrId", sortable: false, menuDisabled: true, width: 80 },
                { xtype: "actioncolumn",
                  width: 30, align: "center", sortable: false, menuDisabled: true,
                  items: [{
                      icon: CTX_PATH + "/resources/spi/famfamfam/icons/delete.png",
                      tooltip: "삭제", scope: this,
                      handler: function(grid, rowIndex, colIndex, item, event, record, row){
                          /*-------------------------------------
                           * 할당 관리자 GRID 아이템 삭제 클릭 이벤트
                           -------------------------------------*/
                          if (event) event.stopEvent();
                          grid.getStore().removeAt(rowIndex);
                      }
                   }]
                }
            ],
            viewConfig: {
                plugins: {
                    ptype: "gridviewdragdrop",
                    dropGroup: "sourceDDGroup",
                    enableDrag: false
                },
                listeners: {
                    beforedrop: function(node, data, overModel, dropPosition, dropHandlers, eOpts) {

                        // 타겟 영역에 값 1개이상 존재시 Drop 취소
                        var me = SM.getCmp("assignMgrPanel");
                        var allRecords = me.store.getRange();

                        if ( allRecords.length == 1 ) {
                            dropHandlers.cancelDrop();
                            return false;
                        }
                    }
                }
            }
        });
        
        $(".smtip").each(function() {
            $(this).qtip({
                content: {
                    title: $(this).next().find(".smtip-title"),
                    text: $(this).next().find(".smtip-text")
                },
                position: {
                    my: "bottom right",
                    at: "top center"
                }
            });
        });
    });
    
    var js_deptSearch = function(deptCd) {

        SM.getCmp("mgrPanel").reload({
            currentPage: 1
        }, {
            deptCd: deptCd == "0" ? "" : deptCd,
            useYn: "Y",
            mgrId: "${smp.mgrId}"
        }, 
        function() {
            $("#resetSearchDiv").hide();
            $("#searchVal").val("");
        });
        
        return false;
    };
    
    var js_search = function() {

        var searchVal = $("#searchVal").val();
        
        SM.getCmp("mgrPanel").reload({
            currentPage: 1
        }, {
            searchKey: "1001",
            searchVal: searchVal,
            useYn: "Y",
            mgrId: "${smp.mgrId}",
			deptCd: js_getSelectedDeptCd()
        }, 
        function() {
            if ( searchVal != "" )
                $("#resetSearchDiv").show();
        });
        
        return false;
    };
    
    var js_resetSearch = function() {
        
        SM.getCmp("mgrPanel").reload({
            currentPage: 1
        }, {
            useYn: "Y",
            mgrId: "${smp.mgrId}",
			deptCd: js_getSelectedDeptCd()
        },
        function() {
            $("#resetSearchDiv").hide();
            $("#searchVal").val("");
        });
    };
    
    var js_getSelectedDeptCd = function() {

		var me = SM.getCmp("treePanel");
		var node = me.getSelectionModel().getSelection()[0];
		var deptCd = node ? node.data.id : "";

        return deptCd == "0" ? "" : deptCd;
    };
    
    var js_gridSaveAction = function(e) {
        
        var me = SM.getCmp("assignMgrPanel");
        var allRecords = me.store.getRange();
        var datas = [];
        Ext.each(allRecords, function(record, i){
            datas.push(record.data);
        });
        
        if ( datas.length == 0 ) {
            alert("지정된 대리인이 목록에 없습니다."); return false;
        }
        if (parent == self) opener.js_setAgencyValues(datas);
        else parent.js_setAgencyValues(datas);
        SM.modalClose();
    };
    
</script>

</body>
</html>