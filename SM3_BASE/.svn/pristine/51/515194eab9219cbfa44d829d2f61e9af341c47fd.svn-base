/*
 * 직원관리 스크립트
 *
 * @author  finkles
 * @date    2014-12-02
 * @since   3.0
 */

var IS_DEPT_CONNECT = false;
if ( document.getElementById("mgr-js").getAttribute("data-dept-connect") == "true" ) {
    IS_DEPT_CONNECT = true;
}

(function ($) {

    MGR = {
        /*-------------------------------------
         * 
         -------------------------------------*/
        deptSearch: function(deptCd) {

            SM.getCmp("mgrPanel").reload({
                currentPage: 1
            }, {
                deptCd: deptCd == "0" ? "" : deptCd
            }, 
            function() {
                $("#resetSearchDiv").hide();
                $("#authCd, #searchVal").val("");
            });
            
            return false;
        },
        search: function() {

            var searchVal = $("#searchVal").val(),
                authCd = $("#authCd").val();
            
            SM.getCmp("mgrPanel").reload({
                currentPage: 1
            }, {
                searchKey: "1001",
                searchVal: searchVal,
                authCd: authCd,
                deptCd: MGR.getSelectedDeptCd()
            }, 
            function() {
                if ( authCd != "" || searchVal != "" )
                    $("#resetSearchDiv").show();
                else 
                    $("#resetSearchDiv").hide();
            });
            
            return false;
        },
        resetSearch: function() {
            
            SM.getCmp("mgrPanel").reload({
                currentPage: 1
            }, {
                deptCd: MGR.getSelectedDeptCd()
            },
            function() {
                $("#resetSearchDiv").hide();
                $("#authCd, #searchVal").val("");
            });
        },
        getSelectedDeptCd: function() {

            var me = SM.getCmp("treePanel");
            var node = me.getSelectionModel().getSelection()[0];
            var deptCd = node ? node.data.id : "";

            return deptCd == "0" ? "" : deptCd;
        },
        excelAction: function() {

            var totalCount = SM.getCmp("mgrPanel").store.totalCount;
            if (totalCount <= 0) {
                alert("대상 자료가 존재하지 않습니다."); return false; 
            }
            
            SM.modal({
                title: "엑셀 변환 옵션 선택",
                width: 560,
                height: 435,
                loadUrl: "PR_excelForm.do"
            });
        },
        getSearchCondition: function() {
            var gridStore = SM.getCmp("mgrPanel").store;
            var sorter = gridStore.sorters.items[0] || {};
            return {
                currentPage: gridStore.currentPage,
                rowPerPage: gridStore.pageSize,
                sortName: sorter.property,
                sortOrder: sorter.direction,
                searchVal: $("#searchVal").val(),
                authCd: $("#authCd").val(),
                deptCd: gridStore.proxy.extraParams.deptCd || ""
            };
        },
        viewPop: function(mgrId) {

            SM.modal({
                title: "직원정보",
                width: 600, height: 400,
                loadUrl: "PR_view.do?mgrId=" + mgrId
            });
        },
        formPop: function(mgrId) {

            var currentNode = SM.getCmp("treePanel").smCurrentNode();
            var deptCd = currentNode ? currentNode.get("id") : "";
            deptCd = deptCd == "0" ? "" : deptCd; 
                
            SM.modal({
                title: "직원정보",
                width: 730, height: (mgrId != "" ? 570 : 450),
                loadUrl: "PR_form.do?mgrId=" + mgrId + "&deptCd=" + deptCd
            });
        },
        authPop: function(data) {

            SM.modal({
                title: "권한 할당",
                width: 310, height: 370,
                loadUrl: "PR_authForm.do?mgrId=" + data.mgrId + "&mgrNm=" + data.mgrNm
            });
        },
        logPop: function(data) {

            SM.modal({
                title: "권한 할당 이력 조회",
                width: 500, height: 400,
                loadUrl: CTX_PATH + "/bo/base/auth/PR_listAuthAssignLog.do?mgrId=" + data.mgrId + "&mgrNm=" + data.mgrNm
            });
        },
        parseYn: function(val) {
            return val == "Y" ? "사용" : "미사용";
        }
    };

})(jQuery);

Ext.onReady(function() {
    
    SM_TREE({
        id: "treePanel",
        title: "부서목록",
        renderTo: "treeDiv",
        rootText: "부서목록",
        nodeParam: "highDeptCd",
        height: 436,
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
                MGR.deptSearch(record.data.id);
            }
        }
    });
    
    SM_GRID({
        id: "mgrPanel",
        renderTo: "mgrGridDiv",
        dataListUrl: "JR_list.do",
        pageSize: "<c:out value='${empty smp.rowPerPage ? 30 : smp.rowPerPage}' />",
        height: 400,
        showRownum: true,
        dataField: ["deptNm", "mgrId", "mgrNm", "useYn", "gradeNm", "roleNm", "loginDt"],
        dataColumns: [
            { text: "부서", dataIndex: "deptNm", sortable: false, width: 140, locked : true  },
            { text: "이름", dataIndex: "mgrNm", width: 90, locked : true  },
            { text: "직급", dataIndex: "gradeNm", width: 100 },
            { text: "역할", dataIndex: "roleNm", width: 140 },
            { text: "사용", dataIndex: "useYn", width: 50, align: "center", renderer: MGR.parseYn },
            { text: "접속일", dataIndex: "loginDt", width: 140 },
            { text: "작업", xtype: "actioncolumn", locked : true,
              width: 110, align: "center", sortable: false, menuDisabled: true,
              items: [{
                  icon: CTX_PATH + "/resources/spi/famfamfam/icons/accept.png",
                  tooltip: "상세", scope: this,
                  /*-------------------------------------
                   * 직원 Grid 상세 버튼 클릭 이벤트
                   -------------------------------------*/
                  handler: function(grid, rowIndex, colIndex, item, event, record, row){
                      if (event) event.stopEvent();
                      MGR.viewPop(record.data.mgrId);
                  }
              }, {
                  icon: CTX_PATH + "/resources/spi/famfamfam/icons/database_edit.png",
                  tooltip: "수정", scope: this, disabled: IS_DEPT_CONNECT,
                  /*-------------------------------------
                   * 직원 Grid 수정 버튼 클릭 이벤트
                   -------------------------------------*/
                  handler: function(grid, rowIndex, colIndex, item, event, record, row){
                      if (event) event.stopEvent();
                      MGR.formPop(record.data.mgrId);
                  }
              }, {
                  icon: CTX_PATH + "/resources/spi/famfamfam/icons/delete.png",
                  tooltip: "삭제", scope: this, disabled: IS_DEPT_CONNECT,
                  /*-------------------------------------
                   * 직원 Grid 삭제 버튼 클릭 이벤트
                   -------------------------------------*/
                  handler: function(grid, rowIndex, colIndex, item, event, record, row){
                      if (event) event.stopEvent();
                      if ( confirm("[" + record.data.mgrNm + "] 직원을 삭제하시겠습니까?") ) {
                          
                          SM.submit(null, {
                              url: "TR_deleteAction.do",
                              data: { 
                                  mgrId: record.data.mgrId,
                                  CSRFToken: $("#csrfForm input[name=CSRFToken]").val()
                              }
                          }, function(messages, xhr) {
                              if (messages.code == 200) {
                                  grid.getStore().removeAt(rowIndex);
                              }
                          });
                      }
                  }
              }, {
                  icon: CTX_PATH + "/resources/spi/famfamfam/icons/group_link.png",
                  tooltip: "권한할당", scope: this, disabled: IS_DEPT_CONNECT,
                  /*-------------------------------------
                   * 직원 Grid 권한할당 버튼 클릭 이벤트
                   -------------------------------------*/
                  handler: function(grid, rowIndex, colIndex, item, event, record, row){
                      if (event) event.stopEvent();
                      MGR.authPop(record.data);
                  }
              }, {
                  icon: CTX_PATH + "/resources/spi/famfamfam/icons/hourglass_link.png",
                  tooltip: "권한할당 이력조회", scope: this, disabled: IS_DEPT_CONNECT,
                  /*-------------------------------------
                   * 직원 Grid 권한할당 이력조회 버튼 클릭 이벤트
                   -------------------------------------*/
                  handler: function(grid, rowIndex, colIndex, item, event, record, row){
                      if (event) event.stopEvent();
                      MGR.logPop(record.data);
                  }
              }]
            }
        ]
    });
});