<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<html>
<head>
    <title>${curMenuBean.menuNm}</title>
    <meta name="title" content="시스템 접속 이력을 조회합니다." />
</head>
 
<body>

<form:form id="csrfForm" name="csrfForm"></form:form>

<table class="tbl-header">
    <tr>
        <th style="width: 120px;">
            <span class="title-big">접속 이력</span>
        </th>
        <td class="tr">
            <form name="dataForm" method="get" onsubmit="return js_search();">
                
                <div id="startDt" class="smf-date"></div>
                <div id="endDt" class="smf-date"></div>

                <select name="searchKey" id="searchKey" class="smf-select">
                    <option value="1001">이름</option>
                    <option value="1000">ID</option>
                    <option value="1002">접속 IP</option>
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

<sm:button-layout>
	<sm:button value="엑셀" glyph="floppy-save" onclick="js_excelAction(this);"/>
</sm:button-layout>

<div id="viewDiv"></div>

<sm:js names="smgrid" />
<script type="text/javascript" src="<c:url value="/resources/spi/jquery/fullcalendar/lib/moment.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/spi/jquery/fullcalendar/lib/moment.precise.range.js"/>"></script>
<script type="text/javascript">

    Ext.onReady(function() {

        SM_GRID({
            id: "gridPanel",
            renderTo: "dataGrid",
            dataListUrl: "JR_list.do",
            height: 265,
            showRownum: true,
            pageSize: "<c:out value='${empty smp.rowPerPage ? CONSTANT.RPP_CNT : smp.rowPerPage}' />",
            dataField: ["seq", "mgrNm", "mgrId", "ipAddr", "loginDt", "logOutDt", "agencyNm"],
            dataColumns: [
                { text: "이름", dataIndex: "mgrNm", sortable: false, width: 120, renderer: function(val, meta, rec){
                    var agencyNm = rec.data.agencyNm;
                    return val + (agencyNm && agencyNm != "" ? " <span class='label label-primary'>" + agencyNm +"</span>" : "");
                }},
                { text: "아이디(ID)", dataIndex: "mgrId", sortable: false, width: 100 },
                { text: "접속 IP", dataIndex: "ipAddr", sortable: false, width: 100 },
                { text: "접속일", dataIndex: "loginDt", sortable: false, width: 140 },
                { text: "접속해제일", dataIndex: "logOutDt", sortable: false, width: 140 },
                { text: "사용시간", dataIndex: "logOutDt", sortable: false, width: 100, renderer: function(val, meta, rec){
                    var loginDt = rec.data.loginDt;
                 	return val && val != "" ? moment.preciseDiff(loginDt, val) : "";   
                }}
            ],
            itemClick: function(record, panel) {

                $("#viewDiv").SM_LOAD("AR_view.do", {
                    mgrId: record.data.mgrId
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
            endDt = $("input[name=endDt]").val();
        
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
            endDt: endDt
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
            endDt: $("input[name=endDt]").val()
    	};
    };
</script>
    
</body>
</html>