<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<html>
<head>
    <title>${curMenuBean.menuNm}</title>
    <meta name="title" content="시스템 동작 중 발생한 에러 정보를 조회, 관리합니다." />
</head>
 
<body>

<form:form id="csrfForm" name="csrfForm"></form:form>

<table class="tbl-header">
    <tr>
        <th style="width: 120px;">
            <span class="title-big">에러로그</span>
        </th>
        <td class="tr">
            <form name="dataForm" method="get" onsubmit="return js_search();">
                
                <div id="startDt" class="smf-date"></div>
                <div id="endDt" class="smf-date"></div>
                
                <select name="solvYn" id="solvYn" class="smf-select" onchange="js_search();">
                    <option value="">-- 해결여부 --</option>
                    <option value="Y">해결</option>
                    <option value="N">미해결</option>
                </select>
                <select name="searchKey" id="searchKey" class="smf-select">
                    <option value="1001">에러 메시지</option>
                    <option value="1000">에러 URL</option>
                    <option value="1002">에러 내용</option>
                </select>
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
        <sm:button value="엑셀" glyph="floppy-save" onclick="js_excelAction(this);"/>
    </div>
</sm:button-layout>

<div class="blank"></div>

<div id="viewDiv"></div>

<sm:css names="syntaxhighlighter" />
<sm:js names="smgrid, syntaxhighlighter" />
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
            dataField: ["seq", "title", "url", "regDt", "solvYn", "solvDt"],
            dataColumns: [
                { text: "에러 메시지", dataIndex: "title", sortable: false, minWidth: 250, flex: 1, locked : true, renderer: function(val) {
                    return val.replace(/</gi, '&gt;').replace(/>/gi, '&lt;');
                }},
                { text: "에러 URL", dataIndex: "url", sortable: false, minWidth: 200, flex: 3 },
                { text: "발생일", dataIndex: "regDt", width: 100 },
                { text: "해결여부", dataIndex: "solvYn", sortable: false, width: 100 },
                { text: "처리일", dataIndex: "solvDt", width: 100 }
            ],
            itemClick: function(record, panel) {

                $("#viewDiv").SM_LOAD("AR_view.do", {
                    seq: record.data.seq
                }, function(){
                    panel.setLoading(false);
                });
            }
        });
        
        $(".smf-date").SM_DATEPICKER();
    });
    
    var js_search = function() {

        var searchKey = $("#searchKey").val(),
            searchVal = $("#searchVal").val(),
            startDt = $("input[name=startDt]").val(),
            endDt = $("input[name=endDt]").val(),
            solvYn = $("#solvYn").val();
        
        if (startDt != "" && endDt != "") {
            var sDt = startDt.split("-").join("");
            var eDt = endDt.split("-").join("");
            if (sDt > eDt) {
                alert("검색 시작일자가 종료 일자보다 클 수 없습니다.\n\n검색 기한을 다시 확인하세요.");
                return false;
            }
        }
        
        SM.getCmp("gridPanel").reload({
            currentPage: 1
        }, {
            searchKey: searchKey,
            searchVal: searchVal,
            startDt: startDt,
            endDt: endDt,
            solvYn: solvYn
        }, function() {
            if ( startDt != "" || endDt != "" || (searchKey != "" && searchVal != "") )
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
            $("#searchVal, input[name=startDt], input[name=endDt]").val("");
            $("#solvYn option")[0].selected = true;
            $("#searchKey option")[0].selected = true;
            $("#viewDiv").html("");
        });
    };
    
    var js_excelAction = function() {

        var totalCount = SM.getCmp("gridPanel").store.totalCount;
        if (totalCount <= 0) {
            alert("대상 자료가 존재하지 않습니다."); return false; 
        }
        
        SM.modal({
            title: "엑셀 변환 옵션 선택",
            width: 570,
            height: 390,
            loadUrl: "PR_excelForm.do"
        });
    };

    var js_getSearchCondition = function() {
    	var gridStore = SM.getCmp("gridPanel").store;
        var sorter = gridStore.sorters.items[0] || {}; 
    	return {
    		currentPage: gridStore.currentPage,
    		rowPerPage: gridStore.pageSize,
            sortName: sorter.property,
            sortOrder: sorter.direction,
            searchKey: $("#searchKey").val(),
            searchVal: $("#searchVal").val(),
            startDt: $("input[name=startDt]").val(),
            endDt: $("input[name=endDt]").val(),
            solvYn: $("#solvYn").val()
    	};
    };
    
    var js_deleteAction = function(e) {
        
        var gridPanel = SM.getCmp("gridPanel");
        
        var seqs = gridPanel.getCheckes("seq");
        
        if (seqs.length == 0) {
            alert("삭제할 자료를 먼저 선택하세요."); return false;
        }
        if ( confirm("선택한 " + seqs.length +" 건의 자료를 삭제하시겠습니까?") ) {
            SM.submit(e, {
                url: "TR_deleteAction.do",
                data: {
                    seqs: seqs,
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
    
    var js_solvedAction = function(e, seq) {
        if ( confirm("해당 에러가 해결 되었습니까?") ) {
            
            SM.submit(e, {
                url: "TR_updateAction.do",
                data: {
                    seq: seq, 
                    solvYn: "Y",
                    CSRFToken: $("#csrfForm input[name=CSRFToken]").val()
                }
            }, 
            function(messages, xhr) {
                if (messages.code == 200) {
                    SM.getCmp("gridPanel").store.reload();
                	$("#viewDiv").SM_LOAD("AR_view.do", {
                        seq: seq
                    });
                }
            });
        }
    };
    
    var js_deleteOneAction = function(e, seq) {
        if ( confirm("정말 삭제하시겠습니까?") ) {
            
            SM.submit(e, {
                url: "TR_deleteAction.do",
                data: { 
                    seqs: [seq],
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
</script>
    
</body>
</html>