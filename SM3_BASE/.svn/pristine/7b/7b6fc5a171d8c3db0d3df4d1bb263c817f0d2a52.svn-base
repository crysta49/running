/*
 * 트리 플러그인
 *
 * @author  finkles
 * @date    2014-10-30
 * @since   3.0
 */
(function ($) {
    
    SM_TREE = function(paramOption) {
        var userOption = {
            id: "treePanel",
            title: "트리 제목",
            rootId: "0",
            rootText: "ROOT",
            extraParams : {},            
            nodeParam: "node",
            height: 430,
            minHeight: 400,
            renderTo : "treeDiv",
            rootVisible: true,
            enableDD: true,
            tools: paramOption.tools || ["down", "up", "refresh"],
            dataListUrl: "JR_list.do",
            dataViewUrl: "AR_view.do",
            dataInsertUrl: "TR_insertAction.do",
            dataUpdateUrl: "TR_updateAction.do",
            dataDeleteUrl: "TR_deleteAction.do"
        };
        
        userOption = $.extend(true, userOption, paramOption);

        var getViewConfig = function() {
            if (userOption.enableDD) {
                return {
                    plugins: {
                        ptype: "treeviewdragdrop",
                        //appenOnly: true,
                        containerScroll: true
                    },
                    listeners: {
                        /*--
                        nodedragover: function(targetNode, position, dragData, e, eOpts) {
                            targetNode.data.leaf = false;
                        } --*/
                    },
                    loadMask: false
                };
            } 
            else return { loadMask: false };
        }
        
        var treeTools = [];
        Ext.each(userOption.tools || [], function(item) {            
            if (item == "down") {
                treeTools.push({
                    type: "down",
                    qtip: "모두 열기",
                    scope: this,
                    handler: function(e, el, owner, tool){
                        var me = SM.getCmp(userOption.id);
                        me.expandAll(function() {
                        });
                    }
                });
            }
            else if (item == "up") {
                treeTools.push({
                    type: "up",
                    qtip: "모두 닫기",
                    scope: this,
                    handler: function(){
                        var me = SM.getCmp(userOption.id);
                        me.collapseAll(function() {
                        });
                    }
                });
            }
            else if (item == "refresh") {
                treeTools.push({
                    type: "refresh",
                    qtip: "다시읽기",
                    scope: this,
                    handler: function(event, toolEl, panel) {
                        var me = SM.getCmp(userOption.id);
                        me.getStore().load( );
                    }
                });
            }
        }, this);

        var treePanel = Ext.create("Ext.tree.Panel", {

            id: userOption.id, 
            title: userOption.title,
            rootId: userOption.rootId,
            rootText: userOption.rootText,
            extraParams : userOption.extraPrams,            
            nodeParam: userOption.nodeParam,
            height: userOption.height,
            minHeight: userOption.minHeight,
            width:  userOption.width,
            rootVisible: userOption.rootVisible,
            renderTo: userOption.renderTo,
            
            smViewParam: userOption.smViewParam,
            smInsertParam: userOption.smInsertParam,
            smUpdateParam: userOption.smUpdateParam,
            smMoveParam: userOption.smMoveParam,
            smDeleteParam: userOption.smDeleteParam,
            smBeforeInsert: userOption.smBeforeInsert,
            smBeforeUpdate: userOption.smBeforeUpdate,
            
            columns: userOption.columns,
            useArrows: false,
            border: false,
            defaults : {
                bodyStyle : "border: none"
            },
            cls: userOption.cls || "smtree",
            store: new Ext.data.TreeStore({
                proxy: {
                    type: "ajax",
                    url: userOption.dataListUrl,
                    extraParams: userOption.extraParams
                },
                root: {
                    text: userOption.rootText,
                    id: userOption.rootId,
                    expanded: true
                },
                nodeParam: userOption.nodeParam,
                listeners: {
                    beforeload: function(store, operation, eOpts){
                    },
                    load: function(store, node, records, successful, eOpts){
                        if (userOption.load) {
                            userOption.load(node);
                        }
                        else {
                            node.eachChild(function(currentChild){     
                                if (currentChild.raw.disabled == "true") {
                                    currentChild.data.cls = "x-tree-disabled";
                                    currentChild.data.disabled = true;
                                }
                                
                                if (!currentChild.raw.checked) return;
                                
                                if (currentChild.raw.checked == "true")
                                    currentChild.data.checked = true;
                                else
                                    currentChild.data.checked = false;
                            });
                        }
                        
                        // this.getEl().unmask();
                    }
                }
            }),
            viewConfig: getViewConfig(),
            tools: treeTools,
            listeners: {
                /*-------------------------------------
                 * 트리노드 클릭
                 -------------------------------------*/
                itemclick: function(panel, record, item, index, e, eOpts) {
                    
                    if (e) e.stopEvent();
                    
                    if (userOption.listeners && userOption.listeners.itemClick) {
                        userOption.listeners.itemClick(panel, record, item, index, e, eOpts);
                        return;
                    }
                    
                    $("#viewDiv").SM_LOAD(
                        userOption.dataViewUrl, userOption.smViewParam(record) || {}, 
                        function(){
                            $("#treePath").html( record.getPath("text", "/") );
                    });
                },
                /*-------------------------------------
                 * 트리노드 이동
                 -------------------------------------*/
                itemmove: function(node, oldParent, newParent, index, eOpts) {
                    
                    var me = this;
                    
                    var params = me.smMoveParam(node, newParent, index) || {};

                    $.post(userOption.dataUpdateUrl, params, function(response) {
                        
                        var messages = SM.parseMsg(response);
                        
                        if (messages.code == 200) {
                            $("#orderNo").html(index+1);
                        }
                        else {
                            alert(messages.text);
                        }
                    });
                },
                /*-------------------------------------
                 * 트리 표시 완료 이벤트
                 -------------------------------------*/
                afterrender: function(panel, eOpts) {
                    if (userOption.listeners && userOption.listeners.afterrender) {
                        userOption.listeners.afterrender(panel, eOpts);
                    }
                },
                /*-------------------------------------
                 * 트리 체크박스 선택/해제 이벤트
                 -------------------------------------*/
                checkchange: function(node, checked, eOpts) {
                    if (userOption.listeners && userOption.listeners.checkchange) {
                        userOption.listeners.checkchange(node, checked, eOpts);
                    }
                }
            },
            /*-------------------------------------
             * 현재 선택된 노드를 획득
             -------------------------------------*/
            smCurrentNode: function() {

                var me = this;
                
                var currentNode = null;
                var nodeId = $("#nodeId").text();
                if (nodeId != "") {
                    currentNode = me.store.getNodeById(nodeId);
                }
                else {
                    currentNode = me.getSelectionModel().getLastSelected();
                }
                return currentNode;
            },
            /*-------------------------------------
             * 자료 등록
             -------------------------------------*/
            smInsert: function(e, formId) {

                var me = this;

                if (me.smBeforeInsert) {
                    if ( !me.smBeforeInsert(formId) ) return false;
                }
                
                var appendOption = $("input[name=appendOption]:checked").val();

                var selectedNode = me.smCurrentNode();

                var targetNode = selectedNode;
                if ( appendOption == "isSame" ) {
                    targetNode = selectedNode.parentNode;
                }
                else if ( appendOption == "isRoot" ) {
                    targetNode = me.getRootNode();
                }
                
                var params = me.smInsertParam(targetNode) || {};
                
                SM.submit(e, {
                    url: userOption.dataInsertUrl,
                    data: params
                }, function(messages, xhr) {
                    
                    if (messages.code != 200) return;
                    
                    targetNode.appendChild({
                        id        : messages.dummy,
                        text      : $("#newText").val(),
                        leaf      : true,
                        draggable : true
                    });

                    if ( $("#isChild").is(":checked") ) {
                        targetNode.set("leaf", false);
                        targetNode.expand();
                    }
                    
                    $("#newText").val("");
                });
            },
            /*-------------------------------------
             * 자료 수정
             -------------------------------------*/
            smUpdate: function(e, formId) {

                var me = this;
                if (me.smBeforeUpdate) {
                    if ( !me.smBeforeUpdate(formId) ) return false;
                }

                var targetNode = me.smCurrentNode();
                
                var params = me.smUpdateParam(targetNode) || {};
                
                SM.submit(e, {
                    url: userOption.dataUpdateUrl,
                    data: params
                }, function(messages, xhr) {

                    if (messages.code != 200) return;
                    
                    targetNode.set("text", $("#text").val());
                    
                    $("#treePath").html( targetNode.getPath("text", "/") );
                    
                    var useYn = $("input[name=useYn]:checked").val();
                    if (useYn == "N") targetNode.set("cls", "no-use");
                    else targetNode.set("cls", "");
                    
                    me.smSetClsRecursiveChild(targetNode, useYn);
                });
            },
            /*-------------------------------------
             * 자료 삭제
             -------------------------------------*/
            smDelete: function(e, msg) {

                var me = this;
                
                var targetNode = me.smCurrentNode();
                
                var confirmMessage = "정말 삭제 하시겠습니까?";
                if ( targetNode.childNodes.length > 0 || targetNode.leaf == false)
                    confirmMessage = "하위 정보가 존재합니다.\n삭제 시 하위 정보가 모두 삭제됩니다.\n\n정말 삭제 하시겠습니까?";

                if (msg) confirmMessage = confirmMessage + "\n" + msg;
                
                var params = me.smDeleteParam(targetNode) || {};
                
                if ( confirm( confirmMessage ) ) {
                    
                    SM.submit(e, {
                        url: userOption.dataDeleteUrl,
                        data: params
                    }, function(messages, xhr) {

                        if (messages.code != 200) return;
                        
                        targetNode.remove();
                        
                        // 상세조회 화면 초기화
                        me.selectPath(me.getRootNode().getPath());
                        me.fireEvent("itemclick", me, me.getRootNode());
                    });
                }
            },
            /*-------------------------------------
             * 사용여부 수정값에 대한 자식노드 클래스 반영
             -------------------------------------*/
            smSetClsRecursiveChild: function(node, useYn) {

                var me = this;
                
                node.eachChild(function(child){

                    if (useYn == "N") child.set("cls", "no-use");
                    else child.set("cls", "");
                    
                    me.smSetClsRecursiveChild(child, useYn);
                });
            }
        });

        return treePanel;
    };
    
    //IE 에서 tools 한글이 짤림 현상 발생
    if (!Ext.isChrome) {
        Ext.override(Ext.tip.Tip, {
            minWidth: 65
        });
    }
    
})(jQuery);
