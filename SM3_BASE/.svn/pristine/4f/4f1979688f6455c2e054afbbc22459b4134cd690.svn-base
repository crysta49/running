<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<html>
<head>
    <title>${curMenuBean.menuNm}</title>
    <meta name="title" content="접속가능한 IP를 관리합니다." />
</head>
 
<body>

<form:form id="csrfForm" name="csrfForm"></form:form>

<table class="tbl-header">
    <tr>
        <th>
            <span class="title-big">접속가능 IP 목록</span>
        </th>
        <td class="tr">
            <form name="dataForm" method="get" onsubmit="return js_search();">
                <input type="hidden" name="searchKey" id="searchKey" value="1000" />
                <input type="text" name="searchVal" id="searchVal" value="" class="smf-text"/>
                <sm:button type="submit" glyph="search" value="검색" cssClass="btn-default"/>
                <span id="resetSearchDiv" class="sr-hidden">
                    <sm:button value="해제" cssClass="btn-default" onclick="js_resetSearch();" />
                </span>
            </form>
        </td>
    </tr>
</table>

<div id="dataGrid"></div>

<sm:button-layout align="both">
    <div class="col-xs-6">
        <sm:button value="선택 삭제" id="btnDelete" glyph="remove" onclick="js_deleteAction(this);" />
    </div>
    <div class="col-xs-6 text-right">
        <div class="btn-group">
            <sm:button value="등록" glyph="plus" onclick="js_updateForm(this);"/>
        </div>
    </div>
</sm:button-layout>

<div class="blank"></div>

<div id="viewDiv"></div>

<sm:js names="validation, smgrid" />
<script type="text/javascript">

    Ext.onReady(function() {

        SM_GRID({
            id: "gridPanel",
            renderTo: "dataGrid",
            dataListUrl: "JR_list.do",
            checkbox: true,
            height: 265,
            showRownum: true,
            pageSize: "<c:out value='${empty smp.rowPerPage ? CONSTANT.RPP_CNT : smp.rowPerPage}' />",
            dataField: ["ipSeq", "ipNm", "startIp", "endIp", "regNm", "useYn", "regDt", "modiDt" ],
            dataColumns: [
                { text: "IP명", dataIndex: "ipNm", sortable: false, width: 100 },
                { text: "IP주소", dataIndex: "ipAddr", sortable: false, width: 250,
                    renderer: function(val, meta, rec) {
                        var startIp = rec.data.startIp;
                        var endIp = rec.data.endIp;
                        return startIp == endIp ? startIp : startIp + " ~ " + endIp;
                }},
                { text: "등록자", dataIndex: "regNm", sortable: false, width: 100 },
                { text: "사용여부", dataIndex: "useYn", sortable: false, width: 100,
                    renderer: function(val, meta, rec) {
                        var useYn = rec.data.useYn;
                        return useYn == "Y"? "사용" : "미사용";    
                }},
                { text: "등록일", dataIndex: "regDt", width: 100 },
                { text: "수정일", dataIndex: "modiDt", width: 100 }
            ],
            itemClick: function(record, panel) {

                $("#viewDiv").SM_LOAD("AR_view.do", {
                    ipSeq: record.data.ipSeq
                }, function(){
                    panel.setLoading(false);
                });
            }
        });
    });
    
    var js_search = function() {
        
        var searchKey = $("#searchKey").val();
        var searchVal = $("#searchVal").val();
    
        SM.getCmp("gridPanel").reload({
            currentPage : 1
        }, {
            searchKey: searchKey,
            searchVal: searchVal,
        }, function() {
            if ( searchVal != "" )
                $("#resetSearchDiv").show();
            $("#viewDiv").html("");
            
        });
        
        return false;
    };
    
    var js_resetSearch = function() {
        
        SM.getCmp("gridPanel").reload({
            currentPage: 1
        }, {
        }, function() {
            $("#resetSearchDiv").hide();
            $("#searchVal").val("");
            $("#viewDiv").html("");
        });  
    };
    
    var js_deleteAction = function(e) {
        
        var gridPanel = SM.getCmp("gridPanel");
        
        var ipSeqs = gridPanel.getCheckes("ipSeq");
        
        if (ipSeqs.length == 0) {
            alert("삭제할 자료를 먼저 선택하세요."); return false;
        }
        if ( confirm("선택한 " + ipSeqs.length +" 건의 자료를 삭제하시겠습니까?") ) {
            SM.submit(e, {
                url: "TR_deleteAction.do",
                data: { 
                    ipSeqs: ipSeqs,
                    CSRFToken: $("#csrfForm input[name=CSRFToken]").val()
                }
            }, 
            function(messages, xhr) {
                if (messages.code == 200) {
                    gridPanel.store.reload();
                    $("#viewDiv").html("");
                }
            });
        }
    };
    
    var js_deleteOneAction = function(e, ipSeq) {
        if ( confirm("정말 삭제하시겠습니까?") ) {
            
            SM.submit(e, {
                url: "TR_deleteAction.do",
                data: {
                    ipSeqs: [ipSeq],
                    CSRFToken: $("#csrfForm input[name=CSRFToken]").val() 
                }
            }, 
            function(messages, xhr) {
                if (messages.code == 200) {
                    SM.getCmp("gridPanel").store.reload();
                    $("#viewDiv").html("");
                }
            });
        }
    };
    
    var js_updateForm = function(e, ipSeq) {
        
        $("#viewDiv").SM_LOAD("AR_form.do", {
            buttonEl : $(e.target),
            ipSeq: ipSeq
        }, function(){
            
        });
    };
    
    var js_cancelAction = function(ipSeq) {
        if (ipSeq != "") {
            $("#viewDiv").SM_LOAD("AR_view.do", {
                ipSeq: ipSeq
            });
        }
        else {
            $("#viewDiv").html("");
            $(".qtip").qtip("hide");
        }
    };
    
    
</script>
    
</body>
</html>