/*
 * Salmon 익스플로러 좌측 메뉴 패널
 *
 * @author  finkles
 * @date    2014-10-14
 * @since   2.0
 */
Ext.define("Sm.App.WestPanel", {
    extend: "Ext.Panel",
    alias: "widget.westpanel",
    
    requires: [
        "Ext.tree.*",
        "Ext.data.*"
    ],
    
    id: "id_westpanel",
    width: 200,
    frame: false,

    collapsible: true,
    titleCollapse: true,
    split: false,
    border: false,
    style: { 
        'background-color': '#EDEFEF',
        'border-right': '1px solid #D0D0D0'
    },
    layout: "border",
    margins: "20 0 0 0",
    
    //*
    tools: [{
        type: "refresh",
        qtip: "다시읽기",
        scope: this,
        handler: function(event, toolEl, panel) {
            var me = SM.getCmp("id_my_page");
            me.loader.load();
        }
    }], //*/

    initComponent: function() {

        Ext.apply(this, {

            title: this.loginName + "님 접속중",
            //title: "My 업무현황",
            iconCls: "f3-user",
            
            items: [{
                id: "id_my_page",
                xtype: "panel",
                region: "north",
                layout: "fit",
                height: 180,
                //margins: "0 0 4 0",
                border: false,
                loader: {
                    url: CTX_PATH + "/bo/base/explorer/ER_myWork.do",
                    loadMask: "로딩중 ...",
                    autoLoad: true
                }
            },{
                id: "id_main_menu", 
                xtype: "treepanel",
                title: "마이 메뉴",
                iconCls: "f3-bricks",
                region: "center",
                layout: "fit",
                rootVisible: false,
                useArrows: true,
                singleExpand: true,
                border: false,
                defaults : {
                    bodyStyle : "border: none"
                },
                viewConfig: {
                    loadMask: true
                },
                cls: "mymenu",
                store: new Ext.data.TreeStore({
                    proxy: {
                        type: "ajax",
                        url: CTX_PATH + "/bo/base/menu/JR_listMyAll.do"
                    },
                    root: {
                        text: "", id: "0", expanded: true
                    },
                    nodeParam: "highMenuCd",
                    listeners: {
                        beforeload: function(store, operation, eOpts){
                        },
                        load: function(store, node, records, successful, eOpts){
                            js_setMenuLvlCls(node);
                        }
                    }
                }),
                listeners: {
                    itemclick: function(panel, record, item, index, e, eOpts, param) {
                        
                        if (record.isLeaf()) {
                            if (e) e.stopEvent();
                            
                            Ext.getCmp("id_centerpanel").loadUrl(record, param, record.getPath("text", "^"));
                        }
                        else {
                            var me = this, isExpanded = record.isExpanded();
                            (record.isExpandable() && isExpanded) ? me.collapseNode(record) : me.expandNode(record);
                        }
                    }
                },
                smSelect: function(menuId, param) {
                    var me = this;
                    var node = me.store.getNodeById(menuId);
                    if (node) {
                        me.selectPath(node.getPath());
                        me.fireEvent("itemclick", me, node, null, null, null, null, param);
                    }
                    else {
                        if (menuId.indexOf("VOC_") == -1)
                            alert(menuId + "에 해당하는 메뉴정보가 없습니다.");
                    }
                },
                tools: [{
                    type: "refresh",
                    qtip: "다시읽기",
                    scope: this,
                    handler: function(event, toolEl, panel) {
                        var me = SM.getCmp("id_main_menu");
                        me.getStore().load(me.root);
                    }
                }]
            }]
        });

        /* 메뉴 텍스트명에 IE7, IE10호환성 보기에서 제목 깨질경우  &nbsp; 주면 됨 */
        
        this.callParent();
    }
});

var js_setMenuLvlCls = function(node) {
    if (node.hasChildNodes()) {
        node.eachChild(function(currentChild){
            currentChild.data.cls = "lvl_" + currentChild.getDepth();   
            js_setMenuLvlCls(currentChild);
        });
    }
};