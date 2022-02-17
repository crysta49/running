<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<html>
<head>
    <title>${curMenuBean.menuNm}</title>
    <meta name="title" content="게시판 유형, 첨부 여부 등의 게시판 운영 정보를 관리합니다." />
</head>
 
<body>

<c:set var="cacheClass" value="BbsConfCache" scope="request" />
<c:import url="/WEB-INF/jsp/bo/common/include/incCacheReload.jsp" charEncoding="UTF-8"/>

<form:form id="csrfForm" name="csrfForm"></form:form>

<table class="tbl-header">
    <tr>
        <th>
            <span class="title-big">게시판 설정</span>
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
            <sm:button value="엑셀" glyph="floppy-save" onclick="js_excelAction(this);"/>
            <sm:button value="등록" glyph="plus" onclick="js_updateForm(this);"/>
        </div>
    </div>
</sm:button-layout>

<div class="blank"></div>

<div id="viewDiv"></div>

<sm:js names="validation, smgrid" />
<script type="text/javascript">

    // 지정된 분류, 관리자 정보 저장소
    var ctgDatas = [], mgrDatas = [];

    Ext.onReady(function() {

        SM_GRID({
            id: "gridPanel",
            renderTo: "dataGrid",
            dataListUrl: "JR_list.do",
            checkbox: true,
            height: 265,
            showRownum: true,
            //sorters: { property: "regDt", direction: "DESC" },
            pageSize: "<c:out value='${empty smp.rowPerPage ? CONSTANT.RPP_CNT : smp.rowPerPage}' />",
            dataField: ["bbsCd", "bbsNm", "typeNm", "folderNm", "cmtYn", "ctgYn",
                        "fileYn", "fileCnt", "admYn", "alimYn", "tableNm", "htmlYn", "useYn", "regDt" ],
            dataColumns: [
                { text: "게시판명", dataIndex: "bbsNm", minWidth: 150, flex: 1, locked : true },
                { text: "코드", dataIndex: "bbsCd", sortable: false, width: 40, locked : true },
                { text: "유형", dataIndex: "typeNm", sortable: false, width: 100 },
                { text: "폴더", dataIndex: "folderNm", sortable: false, width: 100 },
                { text: "확장테이블", dataIndex: "tableNm", sortable: false, width: 100 },
                { text: "분류", dataIndex: "ctgYn", sortable: false, width: 60, renderer: js_parseYn },
                { text: "관리전용", dataIndex: "admYn", sortable: false, width: 60, renderer: js_parseYn },
                { text: "의견글", dataIndex: "cmtYn", sortable: false, width: 60, renderer: js_parseYn },
                { text: "HTML", dataIndex: "htmlYn", sortable: false, width: 60, renderer: js_parseYn },
                { text: "알림", dataIndex: "alimYn", sortable: false, width: 60, renderer: js_parseYn },
                { text: "첨부", dataIndex: "fileYn", sortable: false, width: 60, renderer: js_parseYn },
                { text: "첨부수", dataIndex: "fileCnt", sortable: false, width: 60 },
                { text: "사용", dataIndex: "useYn", sortable: false, width: 60, renderer: js_parseYn },
                { text: "등록일", dataIndex: "regDt", width: 100 }
            ],
            itemClick: function(record, panel) {

                $("#viewDiv").SM_LOAD("AR_view.do", {
                    bbsCd: record.data.bbsCd
                }, function(){
                    panel.setLoading(false);
                });
            }
        });
    });
    
    var js_parseYn = function(val) {
        return val == "Y" ? "사용" : "미사용";
    };
    
    var js_search = function() {

        var searchKey = $("#searchKey").val(),
            searchVal = $("#searchVal").val();
        
        SM.getCmp("gridPanel").reload({
            currentPage: 1
        }, {
            searchKey: searchKey,
            searchVal: searchVal
        }, function() {
            if ( searchKey != "" && searchVal != "" )
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
    
    var js_excelAction = function() {

        var totalCount = SM.getCmp("gridPanel").store.totalCount;
        if (totalCount <= 0) {
            alert("대상 자료가 존재하지 않습니다."); return false; 
        }
        
        SM.modal({
            title: "엑셀 변환 옵션 선택",
            width: 560,
            height: 440,
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
            searchVal: $("#searchVal").val()
        };
    };
    
    var js_deleteAction = function(e) {
        
        var gridPanel = SM.getCmp("gridPanel");
        
        var bbsCds = gridPanel.getCheckes("bbsCd");
        
        if (bbsCds.length == 0) {
            alert("삭제할 자료를 먼저 선택하세요."); return false;
        }
        if ( confirm("선택한 " + bbsCds.length +" 건의 자료를 삭제하시겠습니까?") ) {
            SM.submit(e, {
                url: "TR_deleteAction.do",
                data: { 
                    bbsCds: bbsCds,
                    CSRFToken: $("#csrfForm input[name=CSRFToken]").val()
                }
            }, 
            function(messages, xhr) {
                if (messages.code == 200) {
                    gridPanel.store.reload();
                    $("#viewDiv").html("");
                    
                    js_cacheReloadAction(e, 'Y');
                }
            });
        }
    };
    
    var js_deleteOneAction = function(e, bbsCd) {
        if ( confirm("정말 삭제하시겠습니까?") ) {
            
            SM.submit(e, {
                url: "TR_deleteAction.do",
                data: {
                    bbsCds: [bbsCd],
                    CSRFToken: $("#csrfForm input[name=CSRFToken]").val() 
                }
            }, 
            function(messages, xhr) {
                if (messages.code == 200) {
                    SM.getCmp("gridPanel").store.reload();
                    $("#viewDiv").html("");
                    
                    js_cacheReloadAction(e, 'Y');
                }
            });
        }
    };
    
    var js_updateForm = function(e, bbsCd) {
        
        $("#viewDiv").SM_LOAD("AR_form.do", {
            buttonEl : $(e.target),
            bbsCd: bbsCd
        }, function(){
            
        });
    };
    
    var js_cancelAction = function(bbsCd) {
        if (bbsCd != "") {
            $("#viewDiv").SM_LOAD("AR_view.do", {
                bbsCd: bbsCd
            });
        }
        else {
            $("#viewDiv").html("");
            $(".qtip").qtip("hide");
        }
    };
    
    var js_showBbsCtgPop = function(bbsCd) {
        SM.modal({
            title: "게시판 분류 지정",
            width: 430,
            height: 400,
            y: -1,
            loadUrl: "PR_bbsCtgForm.do?bbsCd=" + bbsCd
        });
    };
    
    var js_showBbsMgrPop = function(bbsCd) {
        SM.modal({
            title: "게시판 관리자 지정",
            width: 670,
            height: 570,
            y: -1,
            loadUrl: "PR_bbsMgrForm.do?bbsCd=" + bbsCd
        });
    };
    
    var js_setBbsCtgValues = function(datas, fromModal) {

        if (fromModal) {
            var _datas = [];
            Ext.each(datas, function(item, i){
                _datas.push([item.ctgCd, item.ctgNm, item.orderNo, item.isNew]);
            });
            ctgDatas = _datas; 
        }
        else {
            ctgDatas = datas;
        }
        var _dataNms = [];
        Ext.each(ctgDatas, function(item, i){
            _dataNms.push(item[1]);
        });
        
        $("#bbsCtgDiv").html(_dataNms.join(", "));
    };
    
    var js_setBbsMgrValues = function(datas, fromModal) {

        if (fromModal) {
            var _datas = [];
            Ext.each(datas, function(item, i){
                _datas.push([item.deptNm, item.mgrId, item.mgrNm]);
            });
            mgrDatas = _datas; 
        }
        else {
            mgrDatas = datas;
        }
        var _dataNms = [];
        Ext.each(mgrDatas, function(item, i){
            _dataNms.push(item[2]);
        });
        
        $("#bbsMgrDiv").html(_dataNms.join(", "));
    };
    
    var js_initArray = function() {
        ctgDatas = [], mgrDatas = [];
    };
    
    var js_cacheReloadAction = function(e, menuReloadYn) {

        if ( confirm("변경된 정보를 시스템 전체에 반영하기 위해 캐시정보를 다시 읽으시겠습니까?") ) {
            SM.submit(e, {
                url: CTX_PATH + "/bo/base/cache/TR_reloadAction.do",
                data: { 
                    id: "${cacheClass}",
                    CSRFToken: $("#csrfForm input[name=CSRFToken]").val()
                }
            }, function(messages, xhr) {
                if (messages.code == 200) {
                    $("#reloadDt").html( new Date().toLocaleString() + "에 다시 읽음");
                    
                    if ( menuReloadYn == 'Y' ) {
                        
                        if ( confirm("게시판 설정정보가 등록/삭제된 경우 메뉴정보를 변경해야 반영됩니다.\n메뉴 관리로 이동하시겠습니까?") ) {
                            parent.location.href = CTX_PATH + '/bo/base/menu/NR_index.do';
                        }
                    }
                }
            });
        }
    };
</script>
    
</body>
</html>