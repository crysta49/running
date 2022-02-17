/*
 * 권한관리 스크립트
 *
 * @author  finkles
 * @date    2014-12-02
 * @since   3.0
 */
 
(function ($) {

    AUTH = {
        /*-------------------------------------
         * 권한 등록 폼
         -------------------------------------*/
        insertForm: function() {
            
            this.toggleView(true);
            
            $("#authViewDiv").SM_LOAD("AR_view.do", {});
        },
        deleteAction: function(e, authCd) {
            
            var me = SM.getCmp("authPanel");

            if ( confirm("삭제 하시겠습니까?") ) {
                SM.submit(e, {
                    url: "TR_deleteAction.do",
                    data: { 
                        authCd: authCd,
                        CSRFToken: $("#csrfForm input[name=CSRFToken]").val()
                    }
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        me.store.reload();
                        $("#authViewDiv").html("");
                    }
                });
            }
        },
        /*-------------------------------------
         * 권한 저장 액션
         -------------------------------------*/
        saveAction: function(e) {
            
            var me = SM.getCmp("menuGridPanel");
            var sm = me.getSelectionModel();
            var allRecords = me.store.getRange();
            
            var uparams = [];
            
            Ext.each(allRecords, function(item, i){
                var _data = item.data;
                if (sm.isSelected(item)/* && item.dirty */) {
                    uparams.push(_data.menuCd + "^" + _data.readYn + "^" + _data.createYn + "^" + _data.updateYn + "^" + _data.deleteYn);
                }
            });
            
            if ( confirm(uparams.length + "건의 선택항목이 있습니다.\n\n변경사항을 저장하시겠습니까?") ) {

                me.setLoading(true);

                SM.submit(e, {
                    url: "TR_crudAction.do",
                    data: {
                        authCd: currentAuthCd,
                        updates: uparams,
                        CSRFToken: $("#csrfForm input[name=CSRFToken]").val()
                    }
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        me.setLoading(false);
                        me.store.reload();
                        $("#dirtyCheckDiv").hide();
                    }
                });
            }
        },
        /*-------------------------------------
         * 계층형으로 하위 메뉴정보 자동 선택, 해제
         -------------------------------------*/
        recursive: function(panel, sm, allRecords, record, isSelect, direction) {

            this.crudToggle(record, isSelect);
            
            Ext.each(allRecords, function(item, i){
                var _data = item.data;
                
                if (isSelect) {
                    // 하위 메뉴 자동 선택
                    if (direction == "down" && record.data.menuCd == _data.highMenuCd) {
                        if (!sm.isSelected(item)) {
                            sm.select(item.index, true, true);
                            AUTH.recursive(panel, sm, allRecords, item, isSelect, direction);
                        }
                    }
                    // 상위 메뉴 자동 선택
                    if (record.data.highMenuCd != TOP_MENU_CD && direction == "up" && record.data.highMenuCd == _data.menuCd) {
                        if (!sm.isSelected(item)) {
                            sm.select(item.index, true, true);
                            AUTH.recursive(panel, sm, allRecords, item, isSelect, direction);
                        }
                    }
                }
                else {
                    // 하위 메뉴 자동 해제
                    if (record.data.menuCd == _data.highMenuCd) {
                        if (sm.isSelected(item)) {
                            sm.deselect(item.index, true);
                            AUTH.recursive(panel, sm, allRecords, item, isSelect);
                        }
                    }
                }
            });
        },
        /*-------------------------------------
         * 계층형으로 하위 메뉴정보 자동 선택, 해제
         -------------------------------------*/
        recursiveDeselect: function(panel, sm, allRecords, record) {

            var selCount = 0;
            var highMenuItem;
            
            this.crudToggle(record, false);
            
            Ext.each(allRecords, function(item, i){
                var _data = item.data;

                if (record.data.highMenuCd == _data.menuCd) {
                    highMenuItem = item;
                }
                // 동일레벨 메뉴 선택값 없을 경우 상위 메뉴 자동 해제
                if (record.data.highMenuCd != TOP_MENU_CD && record.data.highMenuCd == _data.highMenuCd) {
                    if (sm.isSelected(item)) {
                        selCount++;
                    }
                }
            });
            
            if (selCount == 0 && highMenuItem) {
                sm.deselect(highMenuItem.index, true);
                AUTH.recursiveDeselect(panel, sm, allRecords, highMenuItem);
            }
        },
        /*-------------------------------------
         * CRUD 체크박스 선택, 해제
         -------------------------------------*/
        crudToggle: function(record, isSet) {
            
            /*-- 속도 느림 ㅠㅠ --*/
            if (isSet) {
                if (!record.data.readYn) record.set("readYn", isSet);
            }
            else {
                if (record.data.readYn) record.set("readYn", isSet);
                if (record.data.createYn) record.set("createYn", isSet);
                if (record.data.updateYn) record.set("updateYn", isSet);
                if (record.data.deleteYn) record.set("deleteYn", isSet);
            }
        },
        /*-------------------------------------
         * 권한할당 변경사항 체크
         -------------------------------------*/
        dirtyToggle: function(allRecords) {
            
            var me = SM.getCmp("menuGridPanel");
            var sm = me.getSelectionModel();
            
            if (allRecords) {
                var compareSelectedMenus = "";
                Ext.each(allRecords, function(item, i){
                    var _data = item.data;
                    if (sm.isSelected(item)) {
                        compareSelectedMenus += _data.menuCd + ",";
                    }
                });

                if (initSelectedMenus != compareSelectedMenus) {
                    $("#dirtyCheckDiv").show();
                }
                else $("#dirtyCheckDiv").hide();
            }
            else {
                if (me.getDirtyCount() > 0) {
                    $("#dirtyCheckDiv").show();
                }
                else $("#dirtyCheckDiv").hide();
            }
        },
        /*-------------------------------------
         * 권한 추가, 할당 화면 전환
         -------------------------------------*/
        toggleView: function(isAuth) {
            if (isAuth) {
                $("#authViewDiv").show();
                $("#menuListDiv").hide();
            }
            else {
                $("#authViewDiv").hide();
                $("#menuListDiv").show();
            }
        }
    };
    
})(jQuery);

var initSelectedMenus = "";
var currentAuthCd = "";

Ext.onReady(function() {
    
    SM_GRID({
        id: "authPanel",
        title: "권한목록",
        renderTo: "authGridDiv",
        dataListUrl: "JR_list.do",
        enablePaging: false,
        remoteSort: false,
        height: 500,
        dataField: ["authCd", "authNm", "manageYn"],
        dataColumns: [
            { text: "코드", dataIndex: "authCd", sortable: false, width: 70, align: "center" },
            { text: "권한명", dataIndex: "authNm", width: 80 },
            { xtype: "actioncolumn",
              width: 30, align: "center", sortable: false, menuDisabled: true,
              items: [{
                  icon: CTX_PATH + "/resources/spi/famfamfam/icons/database_edit.png",
                  tooltip: "권한 수정", scope: this,
                  /*-------------------------------------
                   * 권한 수정 버튼 클릭 이벤트
                   -------------------------------------*/
                  handler: function(grid, rowIndex, colIndex, item, event, record, row){
                      if (event) event.stopEvent();
                      
                      AUTH.toggleView(true);
                      
                      $("#authViewDiv").SM_LOAD("AR_view.do", {
                          authCd: record.data.authCd
                      }, function(){
                      });
                  }
              }]
            }
        ],
        tools: [{
            type: "refresh",
            qtip: "다시읽기",
            scope: this,
            handler: function(event, toolEl, panel) {
                var me = SM.getCmp("authPanel");
                me.store.reload();
            }
        }],
        /*-------------------------------------
         * 권한 아이템 클릭 이벤트
         -------------------------------------*/
        itemClick : function(record, panel) {
            
            AUTH.toggleView(false);
            
            SM.getCmp("menuGridPanel").reload({
                authCd: record.data.authCd
            }, {}, 
            function() {
                panel.setLoading(false);
                $(".qtip").remove();
                
                currentAuthCd = record.data.authCd;
            });
        }
    });
    
    SM_GRID({
        id: "menuGridPanel",
        title: "권한 메뉴 할당",
        dataListUrl: "JR_listAuthItemAll.do",
        checkbox: true,
        renderTo: "menuGridDiv",
        enablePaging: false,
        remoteSort: false,
        height: 500,
        
        dataField: ["menuCd", "menuNm", "menuUrl", "readYn", "createYn", "updateYn", "deleteYn", "checked", "highMenuCd"],
        dataColumns: [
            { text: "코드", dataIndex: "menuCd", sortable: false, width: 40, align: "center", menuDisabled: true },
            { text: "메뉴명", dataIndex: "menuNm", sortable: false, width: 180, menuDisabled: true },
            /*{ text: "읽기", dataIndex: "readYn", sortable: false, width: 40, xtype: "checkcolumn", menuDisabled: true,
              listeners: { checkchange: AUTH.dirtyToggle }
            },
            { text: "등록", dataIndex: "createYn", sortable: false, width: 40, xtype: "checkcolumn", menuDisabled: true,
              listeners: { checkchange: AUTH.dirtyToggle }
            },
            { text: "수정", dataIndex: "updateYn", sortable: false, width: 40, xtype: "checkcolumn", menuDisabled: true,
              listeners: { checkchange: AUTH.dirtyToggle }
            },
            { text: "삭제", dataIndex: "deleteYn", sortable: false, width: 40, xtype: "checkcolumn", menuDisabled: true,
              listeners: { checkchange: AUTH.dirtyToggle }
            },*/
            { text: "URL", dataIndex: "menuUrl", sortable: false, flex: 1, menuDisabled: true }
        ],
        /*-------------------------------------
         * GRID STORE load listener
         -------------------------------------*/
        storeload: function(store, records, success) {
            if (success) {
                $("#dirtyCheckDiv").hide();
                
                var me = SM.getCmp("menuGridPanel");
                var sm = me.getSelectionModel();
                
                initSelectedMenus = "";
                
                Ext.each(records, function(record) {
                    if (record.data.checked){
                        var row = record.index;
                        sm.select(row, true, true);
                        initSelectedMenus += record.data.menuCd + ",";
                    }
                });
            }
        },
        /*-------------------------------------
         * 좌측 체크박스 선택 이벤트
         -------------------------------------*/
        checkselect: function(model, record, index) {
    
            // console.log("SEL> " + record.data.menuNm + ", " + record.data.checked);
    
            var me = SM.getCmp("menuGridPanel");
            var sm = me.getSelectionModel();
            
            var allRecords = me.store.getRange();
            
            AUTH.recursive(me, sm, allRecords, record, true, "down");
            AUTH.recursive(me, sm, allRecords, record, true, "up");
            
            AUTH.dirtyToggle(allRecords);
        },
        /*-------------------------------------
         * 좌측 체크박스 선택해제 이벤트
         -------------------------------------*/
        checkdeselect: function(model, record, index) {
            
            // console.log("DESEL> " + record.data.menuNm + ", " + record.data.checked);
    
            var me = SM.getCmp("menuGridPanel");
            var sm = me.getSelectionModel();
            
            var allRecords = me.store.getRange();
            
            AUTH.recursive(me, sm, allRecords, record, false);
            AUTH.recursiveDeselect(me, sm, allRecords, record);
            
            AUTH.dirtyToggle(allRecords);
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
