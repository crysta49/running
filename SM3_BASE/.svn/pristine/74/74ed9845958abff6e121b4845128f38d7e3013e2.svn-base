/*
 * 그리드 플러그인
 *
 * @author  finkles
 * @date    2014-10-30
 * @since   3.0
 */
(function ($) {
    
    SM_GRID = function(paramOption) {
        var userOption = {
            checkbox: false,
            checkboxReadOnly: false,
            enablePaging: true,
            pagingInfo: true,
            bbar: null,
            pageSize: 30,
            // minHeight: 265,
            showRownum: false,
            remoteSort: true,
            viewConfig: {
                stripeRows: true,
                loadMask: true,
                deferEmptyText: false,
                emptyText: "<div style='width:auto; text-align:center;'>조회된 데이터가 없습니다.</div>",
                getRowClass: function(record, index, rowParams, store) {
                    return record.data.useYn == "N" ? "no-use" : "";
                }
            }
        };
        
        userOption = $.extend(true, userOption, paramOption);
        
		var oldGrid = Ext.getCmp(userOption.id);
        if (oldGrid) {
            oldGrid.destroy();
        }

        if (userOption.checkbox) {
            userOption.checkboxModel = Ext.create("Ext.selection.CheckboxModel", {
                checkOnly: true,
                toggleOnClick: false,
                listeners: {
                    beforedeselect: function() {
                        if (userOption.checkboxReadOnly) return false;
                    },
                    beforeselect: function() {
                        if (userOption.checkboxReadOnly) return false;
                    },
                    deselect: function(model, record, index) {
                        if (userOption.checkdeselect) {
                            userOption.checkdeselect(model, record, index);
                        }
                    },
                    select: function(model, record, index) {
                        if (userOption.checkselect) {
                            userOption.checkselect(model, record, index);
                        }
                    }
                }
            });
            
            if (userOption.checkboxReadOnly) {
                userOption.checkboxModel.selectAll = function() {
                    return false;
                };
            }
        }
        
        if (!userOption.store) {
            
            userOption.dataModel = Ext.define("Sm.Grid.Model", {
                extend: "Ext.data.Model",
                fields: userOption.dataField
            });
            
            userOption.store = Ext.create("Ext.data.Store", {
                autoDestroy: true,
                pageSize: Number(userOption.pageSize),
                model: userOption.dataModel,
                remoteSort: userOption.remoteSort,
                autoLoad: true,
                sorters: userOption.sorters || {},
                proxy: {
                    type: "ajax",
                    url: userOption.dataListUrl,
                    extraParams: userOption.extraParams,
                    reader: {
                        root: "list",
                        type: "json",
                        totalProperty: "totalNum"
                    },
                    pageParam: "currentPage",
                    startParam: "offset",
                    limitParam: "rowPerPage",
                    sortParam: "sortName",
                    directionParam: "sortOrder",
                    simpleSortMode: true
                },
                listeners : {
                    beforeload : function(store, operation, eOpts) {
                    },
                    load: function(store, records, successful, eOpts) {
                        if (userOption.storeload) {
                            userOption.storeload(store, records, successful);
                        }
                        var panel = Ext.getCmp(userOption.id);
                        if (panel) {
                            Ext.Function.defer(function(){
                                panel.doComponentLayout();
                            }, 1000);
                        }
                    }
                }
            });
        }
        
        if (userOption.enablePaging) {
            userOption.bbar = Ext.create("Ext.ux.PagingToolbarResizer", {
                xtype: "pagingtoolbar",
                store: userOption.store,
                displayInfo: userOption.pagingInfo
            });
            
            if (userOption.pagingInfo) {
                userOption.bbar.plugins = [{
                    ptype: "pagingtoolbarresizer", displayText: "페이지당 목록"
                }];
            }
        }
        
        if (userOption.showRownum) {
            if (userOption.dataColumns) {
                userOption.dataColumns.unshift({
                    xtype: "rownumberer", 
                    text: "순번", resizable: true, width: 55, align: "center",
                    renderer: function (value, meta, record, row, col, store) {
                        return store.totalCount - store.indexOfTotal(record);
                    }
                });
            }
        }
        
        var gridPanel = Ext.create("Ext.grid.Panel", {
            id: userOption.id,
            title: userOption.title,
            renderTo: userOption.renderTo,
            height: userOption.height,
            minHeight: userOption.minHeight,
            viewConfig: userOption.viewConfig,
            store: userOption.store,
            columns: userOption.dataColumns,
            selModel: userOption.checkbox ? userOption.checkboxModel : null,
            tools: userOption.tools,
            bbar: userOption.bbar,
            plugins: userOption.plugins || [],
            cls: "smgrid",
            columnLines: true,
            loadMask: true,
            listeners : {
                itemClick: function(view, record, item, index, e) {

                    if (e.getTarget(".x-grid-cell-row-checker")) return;
                    if (e.getTarget(".x-action-col-icon")) return;
                    
                    if (userOption.itemClick) {
                        view.getSelectionModel().select(index);
                        
                        var me = this;
                        me.setLoading(true);
                        userOption.itemClick(record, me);
                        
                        Ext.Function.defer(function(){
                            me.doComponentLayout();
                        }, 1000);
                    }
                },
                itemdblclick: function(view, record, item, index, e){
                    if (userOption.itemDblClick) {
                        userOption.itemDblClick(record, this);
                    }
                }        
            },
            /*-------------------------------------
             * 체크박스 선택된 키값을 획득 
             -------------------------------------*/
            getCheckes: function(keyName) {
                var keys = [];
                Ext.each(this.getSelectionModel().getSelection(), function(row, index, value) {
                    keys.push(row.data[keyName]);
                });
                return keys;
            },
            /*-------------------------------------
             * 리로드
             -------------------------------------*/
            reload: function(params, extraParams, callback) {
                var gridStore = this.store;
                
                gridStore.proxy.extraParams = extraParams || {};
                
                gridStore.loadPage(1, {
                    params: params || {},
                    callback: function() {
                        if (callback) callback();
                    }
                });
            },
            /*-------------------------------------
             * Edit Cell일 경우 변경된 row 수를 획득
             -------------------------------------*/
            getDirtyCount: function() {
            	var store = this.store;
            	return store.getNewRecords().length + 
                    	store.getUpdatedRecords().length +
                    	store.getRemovedRecords().length;
            }
        });

        Ext.EventManager.onWindowResize(gridPanel.doLayout, gridPanel);
        
        return gridPanel;
    };
    
    //IE 에서 tools 한글이 짤림 현상 발생
    if (!Ext.isChrome) {
        Ext.override(Ext.tip.Tip, {
            minWidth: 65
        });
    }
    
})(jQuery);

/**
 * PagingToolbarResizer plugin for Ext PagingToolbar
 *
 * Contains a combobox where user can choose the pagesize dynamically
 *
 * @author    Loiane Groner <http://loianegroner.com> <http://loiane.com>
 * @date      September 2011
 * @version   1 - ported to Ext JS 4
 *
 * @license Ext.ux.PagingToolbarResizer is licensed under the terms of
 * the Open Source LGPL 3.0 license.  Commercial use is permitted to the extent
 * that the code/component(s) do NOT become part of another Open Source or Commercially
 * licensed development library or toolkit without explicit permission.
 * 
 * License details: http://www.gnu.org/licenses/lgpl.html
 */

/**
 * @class Ext.ux.PagingToolbarResizer
 *
 * Creates new PagingToolbarResizer plugin
 * @constructor
 * @param {Object} config The config object
 * 
 * How to use
 * 
    Just instatiate a new PagingToolbarResizer inside PagingToolbar plugins option:

    bbar: new Ext.PagingToolbar({
            pageSize: 25,
            store: store,
            displayInfo: true,
            displayMsg: "Displaying topics {0} - {1} of {2}",
            emptyMsg: "No topics to display",
            plugins : [Ext.create("Ext.ux.PagingToolbarResizer", {options : [ 50, 100, 500 ] })]
    })
 */
Ext.define("Ext.ux.PagingToolbarResizer", {
    extend: "Ext.AbstractPlugin",
    alias: "plugin.pagingtoolbarresizer",

  /**
   * @cfg {Ext.data.Store} options
   * The {@link Ext.data.Store} combobox should use as its data source (required).
   * You can also use an array of integers.
   * Defaults to [5, 10, 15, 20, 25, 30, 50, 75, 100, 200, 300, 500, 1000]
   */   
  options: [5, 10, 30, 50, 100, 300, 500],
  
  /**
   * @cfg {String} mode Acceptable values are:
   * 
   * 
    "remote" : Default
   * 
    Automatically loads the {@link #store} the first time the trigger
   * is clicked. If you do not want the store to be automatically loaded the first time the trigger is
   * clicked, set to "local" and manually load the store.  To force a requery of the store
   * every time the trigger is clicked see {@link #lastQuery}.
   * 
    "local" :
   * 
    ComboBox loads local data
   * 
   * 
   */
  mode: "remote",
  
  /**
   * @cfg {String} displayText
   * The message to display before the combobox (defaults to "Records per Page")
   */
  displayText: "Records per Page",

  constructor: function(config) {
    
    Ext.apply(this, config);
    
    this.callParent(arguments);
  },

  init : function(pagingToolbar) {
    
    var comboStore = this.options;
    
    var ptStore = pagingToolbar.store;
      
    var combo = Ext.create("Ext.form.field.ComboBox",{
      typeAhead: false,
      triggerAction: "all",
      forceSelection: true,
      lazyRender:true,
      editable: false,
      mode: this.mode,
      value: ptStore.pageSize,
      width:50,
      store: comboStore,
      listeners: {
        select: function(combo, value, i){
            ptStore.pageSize = value[0].data.field1;
            ptStore.loadPage(1);
        }
      }
    });

    var index = pagingToolbar.items.indexOf(pagingToolbar.items.map["refresh"]);
    pagingToolbar.insert(++index,"-");
    pagingToolbar.insert(++index, this.displayText);
    pagingToolbar.insert(++index, combo);
    // pagingToolbar.insert(++index,"-");
    
    //destroy combobox before destroying the paging toolbar
    pagingToolbar.on({
      beforedestroy: function(){
        combo.destroy();
      }
    });

  }
});