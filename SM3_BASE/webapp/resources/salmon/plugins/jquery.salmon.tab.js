/*
 * 탭 플러그인
 *
 * @author  finkles
 * @date    2014-11-13
 * @since   3.0
 */
(function ($) {
    Ext.require([
         "Ext.tab.*",
         "Ext.TabPanel",
         "Ext.ux.IFrame"
     ]);

    SM_TAB = function(paramOption) {
        
        var userOption = {
            frame: false,
            plain: true,
            activeTab: 0,
            defaults :{
                autoScroll: true,
                border: false,
                bodyPadding: "10 0 0 0"
            }
        };
        
        userOption = $.extend(true, userOption, paramOption);
        
        if (userOption.items) {
            Ext.each(userOption.items, function(item){
                
                item.autoGenId = true;
                item.layout = "fit";
                
                if ( typeof item.src == "string" ) {
                    if (userOption.iframe) {
                        item.xtype = "uxiframe";
                    }
                    else {
                        item.loader = {
                            url: item.src,
                            contentType: 'html',
                            //autoLoad: true,
                            loadMask: true,
                            scripts: true,
                            success: function(e) {
                            }
                        };
                        
                        item.listeners = $.extend(true, item.listeners, {
                            activate: function(tab) {
                                tab.loader.load();
                            }
                        });
                    }
                }
                else {
                    item.contentEl = item.src.attr("id");
                }
            });
        }

        var tabPanel = Ext.create("Ext.TabPanel", {
            id: userOption.id,
            title: userOption.title,
            renderTo: userOption.renderTo,
            width: userOption.width,
            height: userOption.height,
            plugins: userOption.plugins || [],
            frame: userOption.frame,
            plain: userOption.plain,
            activeTab: userOption.activeTab,
            defaults : userOption.defaults,
            border: false,
            cls: "smtab",
            items: userOption.items
        });
        
        Ext.EventManager.onWindowResize(tabPanel.doLayout, tabPanel);
        
        return tabPanel;
    };
    
})(jQuery);
