/*
 * Salmon 익스플로러 메인 컨텐츠 영역 탭 패널
 *
 * @author  finkles
 * @date    2014-10-14
 * @since   2.0
 */
Ext.define("Sm.App.CenterPanel", {
    extend: "Ext.TabPanel",
    alias: "widget.centerpanel",

    id: "id_centerpanel",
    
    maxTabWidth: 120,
    
    layout: "fit",
    frame: false,
    border: false,
    plain: true,
    
    plugins: [{
        ptype: "tabscrollermenu",
        maxText  : 15,
        pageSize : 10
    }, {
        ptype: "tabclosemenu"
    }],

    listeners: {
        tabchange: function(panel, tab, prev) {
            var oldToken = Ext.History.getToken();
            var newToken = tab.id;

            if (oldToken === null || oldToken.search(newToken) === -1) {

                if (prev)
                    top.document.title = prev.title + " - " + panel.systemNm;

                Ext.History.add(newToken);
                
                top.document.title = tab.title + " - " + panel.systemNm;
                
				/* 탭 선택 시 자동 메뉴 오픈 */
				if (tab.id != "" && tab.id.length > 5) {
					if (tab.id != "xtab-ds") {
						top.js_link(tab.id.substring(5), "");
				    }
				}
            }
        },
        afterrender: function() {
            var me = this;
            
            Ext.History.on("change", function(token) {
                if (token) {
                    var tab = me.setActiveTab(Ext.getCmp(token));
                    if (tab) {
                        $("title", top.document).html(tab.title + " - " + panel.systemNm);
                    }
                }
            });

            var tab = me.add({
                xtype: "component",
                id: "xtab-ds",
                title: "초기화면",
                iconCls: "mnu-ds-home",
                layout: "fit",
                autoEl: {
                    tag: "iframe",
                    frameborder: 0,
                    src : CTX_PATH + "/bo/base/ds/NR_index.do"
                }
            });
            
            me.setActiveTab(tab);
        }
    },
    
    loadUrl: function(record, param, path) {

        if (!record.data.leaf) return false;
        
        if (!record.data.href) {
            alert("URL 정보가 없습니다."); return false;
        }
        
        var me = this;
        
        if (record.data.id == "1") {
            me.setActiveTab(0);
            return false;
        }
        
        /* 현재 위치 표시 */
        if (path) {
            path = path.substring(2);
            var lastIndex = path.lastIndexOf("^");
            if (lastIndex == -1) path = "<b>" + path + "</b>";
            else {
                path = path.substring(0, lastIndex+1) + "<b>" + path.substring(lastIndex+1) + "</b>";
                path = path.split("^").join(" > ");
            }
        }
        
        var tab = Ext.getCmp("xtab-" + record.data.id);

        if (!tab) {
            tab = me.add({
                xtype: "component",
                id: "xtab-" + record.data.id,
                title: record.data.text,
                tooltip: record.data.text,
                iconCls: record.data.iconCls || "x-tree-icon-leaf",
                closable: true,
                smloaded: false,
                layout: "fit",
                autoEl: {
                    tag: "iframe",
                    id: "xiframe-" + record.data.id,
                    frameborder: 0,
                    src : CTX_PATH + record.data.href + (param ? param : "")
                },
                listeners: {
                    load: {
                        element: "el",
                        fn: function() {
                            this.parent().unmask();
                            tab.smloaded = true;
                        }
                    },
                    render: function() {
                        this.up("tabpanel").body.mask("로딩중...");
                    },
                    afterrender: function () {
                        /*--
                        var me = this;
                        me.location = path;
                        me.getEl().on("load", function () {
                            // Do something 
                        }); --*/
                    }
                },
                location: ""
            });
            
            tab.on("activate", function (tab, eOpts) {
                /* IE8 Grid hide 버그 hack, 2015-01-14 */
                var extObj = window.frames[1].Ext;
                if (!extObj) return;

                var gridPanel = extObj.getCmp("gridPanel");
                if (!gridPanel) return;
                
                if (gridPanel) {
                    gridPanel.doComponentLayout();
                }
            });
            
            me.setActiveTab(tab);
            /*-- tab.load(CTX_PATH + record.data.href + (param ? param : "")); --*/
        }
        else {
            /* 메뉴 클릭시 페이지 리로드
            var iframe = $(tab.getEl().dom);
            if (iframe && tab.smloaded) {
                tab.smloaded = false;
                iframe.attr("src", CTX_PATH + record.data.href + (param ? param : ""));
            } */
            
            if (me.getActiveTab() != tab) {
                me.setActiveTab(tab);
            }
        }
    }
});

