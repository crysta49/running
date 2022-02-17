/*
 * Salmon 익스플로러 메인 어플리케이션
 *
 * @author  finkles
 * @date    2014-10-14
 * @since   2.0
 */
Ext.Loader.setConfig({enabled: true});

Ext.Loader.setPath("Ext.ux", CTX_PATH + "/resources/spi/extjs/ux/");

Ext.require([
    "Ext.tip.*",
    "Ext.tab.*",
    "Ext.TabPanel",
    "Ext.util.History",
    "Ext.ux.IFrame",
    "Ext.ux.TabCloseMenu",
    "Ext.ux.TabScrollerMenu"
]);

Ext.define("Sm.App", {
    extend: "Ext.container.Viewport",
    alias: "widget.app",
    layout: "border",

    id: "id_app",
    
    initComponent: function() {

        Ext.apply(this, {
            items: [{
                xtype: "box",
                region: "north",
                contentEl: "header", 
                height: 40,
                border: false,
                style: { /* padding: '8px' */ }
            }, {
                xtype: "westpanel",
                region: "west",
                margin: "0 0 0 0",                
                loginName: this.loginName
            }, {
                xtype: "centerpanel",
                region: "center",
                margin: "0 0 0 0",                
                systemNm: this.systemNm
            }/*, {
                xtype: "box",
                region: "south",
                contentEl: "footer",
                height: 24,
                border: false
            }*/]
        });
        
        this.callParent();
    },
    listeners: {
        resize: function(viewport, width, height, oldWidth, oldHeight, eOpts) {
            var centerPanel = Ext.getCmp("id_centerpanel");
            if (centerPanel) centerPanel.doComponentLayout();
        }
    }/*,
    quickInfoMenuClick: function(id) {
        
        var me = Ext.getCmp("id_centerpanel");
        // var iframeDom = me.getActiveTab().iframeEl.dom;
        var iframeDom = me.getActiveTab().getEl().dom;

        if (id == "refresh") {
            iframeDom.contentWindow.location.reload()
        }
        else if (id == "print") {
            iframeDom.contentWindow.print()
        }
        else if (id == "help") {
            alert("HELP");
        }
        else if (id == "auth") {
            $("#authInfoDiv", iframeDom.contentDocument).toggle();
        }
        else if (id == "debug") {
            $("#debugInfoDiv", iframeDom.contentDocument).toggle();
        }
    },
    getCurrentTime: function() {
        var now = new Date();
        var year = "" + now.getFullYear();
        var month = "" + (now.getMonth() + 1); if (month.length == 1) { month = "0" + month; }
        var day = "" + now.getDate(); if (day.length == 1) { day = "0" + day; }
        var hour = "" + now.getHours(); if (hour.length == 1) { hour = "0" + hour; }
        var minute = "" + now.getMinutes(); if (minute.length == 1) { minute = "0" + minute; }
        var second = "" + now.getSeconds(); if (second.length == 1) { second = "0" + second; }
        return year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second;
    } */
});

/*
var WASTED_TIME = {
    start: new Date(),
    displayElapsedTime: function() {
        var now = new Date();
        var elpased = Math.round((now - this.start)/1000);
        
        var days = Math.floor((elpased % 31536000) / 86400); 
        var hours = Math.floor(((elpased % 31536000) % 86400) / 3600);
        var minutes = Math.floor((((elpased % 31536000) % 86400) % 3600) / 60);
        var seconds = (((elpased % 31536000) % 86400) % 3600) % 60;
        
        if (days > 0)
            return days + "일 " + hours + "시간";
        else if (hours > 0)
            return hours + "시간 " + minutes + "분";
        else if (minutes > 0)
            return minutes + "분 ";
        else 
            return "0"; // seconds + "초";
    }
} */

Ext.onReady(function() {

    Ext.History.init();
    
    Ext.Function.defer(function(){
        Ext.get("loading").remove();
        Ext.get("loading-mask").fadeOut({remove:true});
    }, 1000);
    
    /*
    $(".quick-info-menu li").click(function() {
        var id = $(this).attr("data-id");
        var me = Ext.getCmp("id_app");
        me.quickInfoMenuClick(id);
        // $(".icon-bbar").qtip("api").hide();
    });
    
    $("div.q-text fieldset div").click(function() {
        var id = $(this).attr("data-id");
        if (id == "") return;
        if (confirm(id + " 테마로 변경하시겠습니까?\n페이지가 다시 로드됩니다.")) {
            $.post(CTX_PATH + "/bo/base/mgr/TR_updateThemeAction.do", {
                theme: id
            }, function(){
                top.location.href = CTX_PATH + "/explorer";
            });
        }
    }); */
    
    /*
    $(".icon-bbar").qtip({
        content: {
            title: {
                text: $("#quickInfoDiv > span.q-title"),
                button: "닫기"
            },
            text: $("#quickInfoDiv > div.q-text")
        },
        position: {
            my: "bottom right",
            at: "top left"
        },
        style: {
            width: 400,
            height: 250,
            classes: 'qtip-light qtip-rounded'
        },
        show: {
            event: "click",
            modal: true
        },
        hide: 'click'
    }); */
    
    // 읽지 않은 쪽지 알림
    /*
    Ext.Function.defer(function(){
        $.get(CTX_PATH + "/bo/base/note/TR_countNoRead.do", { 
            "_dc" : $.now() 
        }, function(response) {
            if (Number(response) > 0) {
                SM_NOTE({
                    title: "알림",
                    html: "읽지않은 쪽지가 " + response + "건 있습니다."
                });
            }
        });
    }, 3000); */
    
    /* 접속시간 표시 (every 1 minutes)
    Ext.TaskManager.start({
        run: function() {
            var me = Ext.getCmp("id_app");
            $(".elpased-time").html(WASTED_TIME.displayElapsedTime());
        },
        interval: 1000*60
    }); */
    
    // 새 쪽지 알림 (every 5 minutes)
    /*
    Ext.TaskManager.start({
        run: function() {
            $.get(CTX_PATH + "/bo/base/note/TR_countNewNote.do", { 
                "_dc" : $.now() 
            }, function(response) {
                if (Number(response) > 0) {
                    SM_NOTE();
                }
            });
        },
        interval: 1000*60*5
    }); */
    
    /*--
    // Refresh My Work (every 30 secs)
    Ext.TaskManager.start({
        run: function() {
            
            $.get(CTX_PATH + "/bo/base/explorer/JR_myWork.do",   function(data){

                var tab = Ext.getCmp("xtab-ds");
                var tabDsContents = $(tab.getEl().dom).contents();
                
                if ( data['2001'] != data[null] ){
                    $(".receiverCnt").text(data['2001']);
                    tabDsContents.find("#contentsDiv .tbl-ds .receiverCnt").text(data['2001']);
                }
                if ( data['2002'] != data[null] ) {
                    $(".dividerCnt").text(data['2002']);
                    tabDsContents.find("#contentsDiv .tbl-ds .dividerCnt").text(data['2002']);
                }
                if ( data['2003'] != data[null] ) {
                    $(".dealerCnt").text(data['2003']);
                    tabDsContents.find("#contentsDiv .tbl-ds .dealerCnt").text(data['2003']);
                }
                if ( data['2004'] != data[null] ) {
                    $(".sancerCnt").text(data['2004']);
                    tabDsContents.find("#contentsDiv .tbl-ds .sancerCnt").text(data['2004']);
                }
            }
        )},
        interval: 1000*30
    }); --*/
});
