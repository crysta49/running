/*
 * 코드관리 스크립트
 *
 * @author  finkles
 * @date    2014-12-02
 * @since   3.0
 */
 
(function ($) {

    CODE = {
        /*-------------------------------------
         * 그룹코드 등록 폼
         -------------------------------------*/
        insertForm: function(el) {
            
            this.toggleView(true);
            
            $("#grpViewDiv").SM_LOAD("AR_view.do", { buttonEl : el });
        },
        deleteAction: function(e, grpCd) {
            
            var me = SM.getCmp("grpPanel");

            if ( confirm("삭제 하시겠습니까?") ) {
                SM.submit(e, {
                    url: "TR_deleteAction.do",
                    data: { 
                        grpCd: grpCd,
                        CSRFToken: $("#dataForm input[name=CSRFToken]").val()
                    }
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        me.store.reload();
                        $("#grpViewDiv").html("");
                        
                        js_cacheReloadAction(e);
                    }
                });
            }
        },
        /*-------------------------------------
         * 개별코드 추가
         -------------------------------------*/
        prvRow: function() {

            var me = SM.getCmp("grpPanel");
            var record = me.getSelectionModel().getSelection()[0];

            if (record) {
                var grpCd = record.data.grpCd; 
                var me = SM.getCmp("prdPanel");
                
                me.getStore().insert(0, {
                    grpCd: grpCd, prvCd: "", prvNm: "", subGrpCd: "", isUse: true, orderNo: 1, isNew: true
                });
                me.plugins[0].startEditByPosition({
                    row: 0, column: 0
                });
            }
        },
        /*-------------------------------------
         * 개별코드 저장 액션
         -------------------------------------*/
        prvSaveAction: function(e) {
            
            var me = SM.getCmp("prdPanel");

            var iparams = [], uparams = [], dparams = []; 
            var validateYn = true;
            
            var confirmMsg = "아래 변경사항을 저장하시겠습니까?\n";
            
            var newRecords = me.getStore().getNewRecords();
            if (newRecords.length > 0) confirmMsg += "\n[추가한 코드]\n";
            Ext.each(newRecords, function(record, i){
                var _data = record.data;
                if (_data.prvCd != "" && _data.prvNm != "") {
                    var pattern = /^[_a-zA-Z\d]+$/;
                    if(!pattern.test(_data.prvCd)){
                        alert("영문자 또는 숫자, 언더바('_')만 입력하세요.");
                        validateYn = false;
                    }else{
                        iparams.push(_data.grpCd + "^" + _data.prvCd + "^" + _data.prvNm + "^" + _data.orderNo + "^" + (_data.subGrpCd ? _data.subGrpCd : "") + "^" + _data.isUse);
                        confirmMsg += (i+1) + ". " + _data.prvNm + " (" + _data.prvCd + ")\n";
                    }
                }
                else {
                    alert("코드, 이름을 모두 입력하세요.");
                    validateYn = false;
                }
            });
            
            var updatedRecords = me.getStore().getUpdatedRecords();
            if (updatedRecords.length > 0) confirmMsg += "\n[수정한 코드]\n";
            Ext.each(updatedRecords, function(record, i){
                var _data = record.data;
                uparams.push(_data.grpCd + "^" + _data.prvCd + "^" + _data.prvNm + "^" + _data.orderNo + "^" + (_data.subGrpCd ? _data.subGrpCd : "") + "^" + _data.isUse);
                confirmMsg += (i+1) + ". " + _data.prvNm + " (" + _data.prvCd + ")\n";
            });
            
            var removedRecords = me.getStore().getRemovedRecords();
            if (removedRecords.length > 0) confirmMsg += "\n[삭제한 코드]\n";
            Ext.each(removedRecords, function(record, i){
                var _data = record.data;
                dparams.push(_data.grpCd + "^" + _data.prvCd + "^" + _data.prvNm + "^" + _data.orderNo + "^" + (_data.subGrpCd ? _data.subGrpCd : "") + "^" + _data.isUse);
                confirmMsg += (i+1) + ". " + _data.prvNm + " (" + _data.prvCd + ")\n";
            });
            
            if (!validateYn) return false;

            if ( confirm(confirmMsg) ) {
                
                SM.submit(e, {
                    url: "TR_crudAction.do",
                    data: { 
                        inserts: iparams,
                        updates: uparams,
                        deletes: dparams,
                        CSRFToken: $("#csrfForm input[name=CSRFToken]").val()
                    }
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        me.store.reload();
                        $("#dirtyCheckDiv").hide();
                        
                        js_cacheReloadAction(e);
                    }
                });
            }
        },
        /*-------------------------------------
         * 개별코드 변경사항 체크
         -------------------------------------*/
        dirtyToggle: function() {
            
            var me = SM.getCmp("prdPanel");

            if (me.getDirtyCount() > 0) {
                $("#dirtyCheckDiv").show();
            }
            else $("#dirtyCheckDiv").hide();
        },
        /*-------------------------------------
         * 그룹코드, 개별코드 화면 전환
         -------------------------------------*/
        toggleView: function(isGrpView) {
            if (isGrpView) {
                $("#grpViewDiv").show();
                $("#prvListDiv").hide();
            }
            else {
                $("#grpViewDiv").hide();
                $("#prvListDiv").show();
            }
        }
    };
    
})(jQuery);

Ext.onReady(function() {
    
    SM_GRID({
        id: "grpPanel",
        title: "그룹코드",
        renderTo: "grpGridDiv",
        dataListUrl: "JR_list.do",
        enablePaging: false,
        remoteSort: false,
        height: 400,
        dataField: ["grpCd", "grpNm"],
        dataColumns: [
            { text: "코드", dataIndex: "grpCd", sortable: false, width: 90 },
            { text: "이름", dataIndex: "grpNm", width: 110 },
            { xtype: "actioncolumn",
              width: 30, align: "center", sortable: false, menuDisabled: true,
              items: [{
                  icon: CTX_PATH + "/resources/spi/famfamfam/icons/database_edit.png",
                  tooltip: "그룹코드 수정", scope: this,
                  /*-------------------------------------
                   * 그룹코드 수정 버튼 클릭 이벤트
                   -------------------------------------*/
                  handler: function(grid, rowIndex, colIndex, item, event, record, row){
                      if (event) event.stopEvent();
                      
                      CODE.toggleView(true);
                      
                      $("#grpViewDiv").SM_LOAD("AR_view.do", {
                          grpCd: record.data.grpCd
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
                var me = SM.getCmp("grpPanel");
                me.store.reload();
            }
        }],
        /*-------------------------------------
         * 그룹코드 아이템 클릭 이벤트
         -------------------------------------*/
        itemClick : function(record, panel) {
            
            CODE.toggleView(false);
            
            SM.getCmp("prdPanel").reload({
                grpCd: record.data.grpCd
            }, {}, 
            function() {
                panel.setLoading(false);
                $(".qtip").remove();
                
                $("#btn-prv-add").show();
            });
        }
    });
    
    SM_GRID({
        id: "prdPanel",
        title: "개별코드 목록",
        dataListUrl: "JR_list.do?prvCd=_dummy_",
        renderTo: "prvGridDiv",
        enablePaging: false,
        remoteSort: false,
        height: 400,
        plugins: [new Ext.grid.plugin.CellEditing({
            clicksToEdit: 1,
            autoCancel: true,
            listeners: {
                /*-------------------------------------
                 * GRID 셀 편집 전처리 이벤트
                 -------------------------------------*/
                beforeedit: function(editor, e) {
                    if (!e.record.data.isNew && e.field == "prvCd") {
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
                    if (e.field == "prvCd") {
                        var me = SM.getCmp("prdPanel");
                        var allRecords = me.store.getRange();
                        var dup = 0;
                        Ext.each(allRecords, function(record, i){
                            var _data = record.data;
                            if (_data.prvCd == e.value) dup++;
                        });
                        
                        if (dup > 0) {
                            e.cancel = true;
                            alert("코드값은 중복될 수 없습니다.");
                            return false;
                        }
                    }
                },
                /*-------------------------------------
                 * GRID 셀 편집 후처리 이벤트
                 -------------------------------------*/
                edit: function(editor, e) {
                    if (e.value !== e.originalValue) {
                        CODE.dirtyToggle();
                    }
                },
                /*-------------------------------------
                 * GRID 셀 편집 취소 이벤트
                 -------------------------------------*/
                canceledit: function(editor, e) {
                    var me = e.grid;
                    var data = e.record.data;
                    if (data.isNew) {
                        if (data.prvCd == "" && data.prvNm == "")
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
                 * GRID 순서변경 (DnD) 선처리 이벤트
                 -------------------------------------*/
                beforedrop: function( node, data, overModel, dropPosition, dropFunction, eOpts) {
                    var me = SM.getCmp("prdPanel");
                    
                    if (me.getDirtyCount() > 0) {
                        if ( !confirm("코드 변경사항이 있습니다. 계속 진행하실 경우 변경사항이 소실됩니다.") ) {
                            eOpts.cancel = true; return false;
                        }
                    }
                },
                /*-------------------------------------
                 * GRID 순서변경 (DnD) 후처리 이벤트
                 -------------------------------------*/
                drop: function(node, data, dropRec, dropPosition) {

                    var me = SM.getCmp("grpPanel");
                    var record = me.getSelectionModel().getSelection()[0];
                    var grpCd = record.data.grpCd; 
                    
                    var me2 = SM.getCmp("prdPanel");
                    var allRecords = me2.store.getRange();
                    
                    var prvCds = [];
                    Ext.each(allRecords, function(record, i){
                        var _data = record.data;
                        if(_data.prvCd) prvCds.push(_data.prvCd);
                    });

                    $.post("TR_orderAction.do", {
                        grpCd: grpCd,
                        orders: prvCds,
                        CSRFToken: $("#csrfForm input[name=CSRFToken]").val()
                    }, function() {
                        var me = SM.getCmp("prdPanel");
                        me.store.reload();
                    });
                }
            }
        },
        dataField: ["grpCd", "prvCd", "prvNm", "orderNo", "subGrpCd", "isUse", "regDt", "modiDt", "isNew"],
        dataColumns: [
            { text: "코드", dataIndex: "prvCd", sortable: false, width: 40, align: "center", editor: { allowBlank: false, maxLength: "8" } },
            { text: "이름", dataIndex: "prvNm", width: 130, editor: { allowBlank: false, maxLength: "20" } },
            { text: "순서", dataIndex: "orderNo", width: 40, align: "center", editor: { xtype: "numberfield", minValue: 0, maxValue: 100, allowBlank: false } },
            { text: "하위코드", dataIndex: "subGrpCd", editor: {
                  xtype: "combo",
                  // editable: false,
                  autoScroll: true,
                  allowBlank: true,
                  typeAhead: true,
                  queryMode: "local",
                  displayField: "grpNm",
                  valueField: "grpCd",
                  emptyText: "하위코드 선택",
                  store: Ext.create("Ext.data.Store", {
                      fields: [
                          { name: "grpCd", type :"string" },
                          { name: "grpNm", type :"string" }
                      ],
                      autoLoad: true,
                      proxy: {
                          //noCache: false,
                          type: "ajax",
                          url: "JR_list.do"
                      }
                  })
              }, renderer: function(value, metaData, record) {
                  if (value) {
                      var grpCdStore = SM.getCmp("grpPanel").store;
                      var grpCdRec = grpCdStore.findRecord("grpCd", value);
                      return grpCdRec.get("grpNm");
                  } else return "";
              }
            },
            { text: "사용", dataIndex: "isUse", width: 40, 
              xtype: "checkcolumn", stopSelction: false,
              listeners: {
                  checkchange: function(column, recordIndex, checked) {
                      CODE.dirtyToggle();
                  }
              }
            },
            { xtype: "actioncolumn",
              width: 30, align: "center", sortable: false, menuDisabled: true,
              items: [{
                  icon: CTX_PATH + "/resources/spi/famfamfam/icons/delete.png",
                  tooltip: "삭제", scope: this,
                  handler: function(grid, rowIndex, colIndex, item, event, record, row){
                      /*-------------------------------------
                       * 개별코드 GRID 아이템 클릭 이벤트
                       -------------------------------------*/
                      if (event) event.stopEvent();
                      if ( confirm("[" + record.data.prvNm + "] 값을 삭제하시겠습니까?") ) {
                          grid.getStore().removeAt(rowIndex);
                          CODE.dirtyToggle();
                      }
                  }
              }]
            },
            { text: "등록일", dataIndex: "regDt", width: 140 },
            { text: "수정일", dataIndex: "modiDt", width: 140 }
        ],
        tools: [{
            type: "refresh",
            qtip: "다시읽기",
            scope: this,
            handler: function(event, toolEl, panel) {
                var me = SM.getCmp("prdPanel");
                me.store.reload();
            }
        }]
    });
});