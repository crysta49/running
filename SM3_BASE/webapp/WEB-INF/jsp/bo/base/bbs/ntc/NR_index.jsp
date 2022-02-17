<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<html>
<head>
    <title>공지글 관리</title>
</head>
 
<body>

<form:form id="csrfForm" name="csrfForm"></form:form>

<table class="tbl-header">
    <tr>
        <th style="width: 120px;">
            <span class="title-big">공지글 관리</span>
        </th>
        <td class="tr">
            <form name="dataForm" method="get" onsubmit="return js_search();">
                
                <div id="startDt" class="smf-date"></div>
                <div id="endDt" class="smf-date"></div>
                
                <select name="bbsCd" id="bbsCd" class="smf-select">
                    <option value="">-- 선택하세요 --</option>
                    <c:forEach items="${bbsList}" var="item">
                        <option value="${item.bbsCd}">${item.bbsNm}</option>
                    </c:forEach>
                </select>
                
                <select name="searchKey" id="searchKey" class="smf-select">
                    <option value="1000">제목</option>
                    <option value="2000">내용</option>
                </select>
                <input type="text" name="searchVal" id="searchVal" value="" class="smf-text"/>
                <sm:button type="submit" icon="b3-search" value="검색" />
                <span id="resetSearchDiv" class="hidden">
                    <sm:button value="해제" icon="b3-search-reset" onclick="js_resetSearch();" />
                </span>
            </form>
        </td>
    </tr>
</table>

<div id="dataGrid"></div>

<sm:button-layout align="both">
    <div class="col-xs-6">
        <sm:button value="선택 삭제" id="btnDelete" icon="b3-db-delete" onclick="js_deleteAction(this);" />
    </div>
    <div class="col-xs-6 text-right">
        <sm:button value="등록" icon="add" onclick="js_updateForm(this);"/>
    </div>
</sm:button-layout>

<div class="blank"></div>

<div id="viewDiv"></div>

<sm:js names="validation, multifile, smgrid, ckeditor" />
<script type="text/javascript" src="<c:url value="/resources/spi/jquery/wordcount/jquery.wordcount.js"/>"></script>
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
            dataField: ["title", "mgrNm", "fileCnt",
                        "bbsCd", "bbsNm", "ntcSeq", "readCnt", "regDt", "modiDt" ],
            dataColumns: [
                { text: "게시판", dataIndex: "bbsNm", sortable: false, width: 120, locked : true },
                { text: "제목", dataIndex: "title", sortable: false, width: 300, locked : true },
                { text: "작성자", dataIndex: "mgrNm", sortable: false, width: 80 },
                { text: "첨부", dataIndex: "fileCnt", sortable: false, width: 60 },
                { text: "조회", dataIndex: "readCnt", sortable: false, width: 60 },
                { text: "등록일", dataIndex: "regDt", sortable: false, width: 100 }
            ],
            itemClick: function(record, panel) {

                $("#viewDiv").SM_LOAD("AR_view.do", {
                    ntcSeq: record.data.ntcSeq
                }, function(){
                    panel.setLoading(false);
                });
            }
        });
        
        $("#bbsCd").change(function() {
            js_search();
        });
        
        $(".smf-date").SM_DATEPICKER();
    });
    
    var js_search = function() {

        var searchKey = $("#searchKey").val(),
            searchVal = $("#searchVal").val(),
            startDt = $("input[name=startDt]").val(),
            endDt = $("input[name=endDt]").val(),
            bbsCd = $("#bbsCd").val();
        
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
            bbsCd: bbsCd
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
            $("#searchVal, input[name=startDt], input[name=endDt], #bbsCd").val("");
            $("#searchKey option")[0].selected = true;
            $("#viewDiv").html("");
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
            bbsCd: $("#bbsCd").val()
        };
    };
    
    var js_deleteAction = function(e) {
        
        var gridPanel = SM.getCmp("gridPanel");
        
        var ntcSeqs = gridPanel.getCheckes("ntcSeq");
        
        if (ntcSeqs.length == 0) {
            alert("삭제할 자료를 먼저 선택하세요."); return false;
        }
        if ( confirm("선택한 " + ntcSeqs.length +" 건의 자료를 삭제하시겠습니까?") ) {
            SM.submit(e, {
                url: "TR_deleteAction.do",
                data: {
                    ntcSeqs: ntcSeqs,
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
    
    var js_deleteOneAction = function(e, ntcSeq) {
        if ( confirm("정말 삭제하시겠습니까?") ) {
            
            SM.submit(e, {
                url: "TR_deleteAction.do",
                data: {
                    ntcSeqs: [ntcSeq],
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
    
    var js_updateForm = function(e, ntcSeq) {
        
        $("#viewDiv").SM_LOAD("AR_form.do", {
            buttonEl : $(e.target),
            ntcSeq: ntcSeq
        }, function(){
            
        });
    };
    
    var js_cancelAction = function(ntcSeq) {
        if (ntcSeq != "") {
            $("#viewDiv").SM_LOAD("AR_view.do", {
                ntcSeq: ntcSeq
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