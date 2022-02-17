<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<html>
<head>
    <title>고객 관리</title>
    <meta name="title" content="고객 정보를 조회합니다." />
</head>

<body>

<div class="row">
    <div class="col-xs-4 list-lbox">
        <div id="treeDiv"></div>
    </div>
    <div class="col-xs-8">
        <div id="viewDiv">
            <table class="tbl-header">
                <tr>
                    <th style="width: 30%;">
                        <span class="title-big">고객목록</span>
                    </th>
                    <td class="tr">
                        <form name="dataForm" method="get" onsubmit="return js_search();">

                            <input type="text" name="searchVal" id="searchVal" value="${smp.searchVal }" class="smf-text" placeholder="고객명 입력"/>
                            <sm:button type="submit" glyph="search" cssClass="btn-default" value="검색"/>
                            <span id="resetSearchDiv" class="sr-hidden">
                                <sm:button value="해제" cssClass="btn-default" onclick="js_resetSearch();" />
                            </span>
                        </form>
                    </td>
                </tr>
            </table>
            <div id="gridDiv"></div>
            
            <sm:button-layout group="true">
                <sm:button value="엑셀" glyph="floppy-save" onclick="js_excelAction(this);"/>
                <sm:button value="추가" glyph="plus" onclick="js_formPop('');"/>
            </sm:button-layout>
        </div>
    </div>
</div>

<form:form id="csrfForm" name="csrfForm"></form:form>

<sm:js names="validation, smgrid" />
<script type="text/javascript">
    Ext.onReady(function() {
        
        var typeList = [];
        typeList.push( ["", "전체"] );
        <c:forEach items="${typeList}" var="item">
            typeList.push( ["${item.prvCd}", "${item.prvNm}"] );
        </c:forEach>
        
        SM_GRID({
            id: "typePanel",
            title: "고객유형",
            renderTo: "treeDiv",
            enablePaging: false,
            remoteSort: false,
            height: 436,
            dataField: ["typeCd", "typeNm"],
            store: Ext.create("Ext.data.ArrayStore", {
                fields: ["typeCd", "typeNm"],
                data: typeList
            }),
            dataColumns: [
                { text: "유형목록", dataIndex: "typeNm", width: 180, sortable: false, menuDisabled: true }
            ],
            /*-------------------------------------
             * 유형코드 아이템 클릭 이벤트
             -------------------------------------*/
            itemClick : function(record, panel) {

                js_typeSearch(record.data.typeCd);
                panel.setLoading(false);
            }
        });
        
        SM_GRID({
            id: "userPanel",
            renderTo: "gridDiv",
            dataListUrl: "JR_list.do",
            pageSize: "<c:out value='${empty smp.rowPerPage ? CONSTANT.RPP_CNT : smp.rowPerPage}' />",
            height: 400,
            showRownum: true,
            dataField: ["typeNm", "userId", "userNm", "useYn", "regDt", "userKey"],
            dataColumns: [
                { text: "유형", dataIndex: "typeNm", sortable: false, width: 140, locked : true  },
                { text: "이름", dataIndex: "userNm", width: 90, locked : true  },
                { text: "아이디", dataIndex: "userId", width: 100 },
                { text: "사용", dataIndex: "useYn", width: 50, align: "center", renderer: js_parseYn },
                { text: "등록일", dataIndex: "regDt", width: 140 },
                { text: "작업", xtype: "actioncolumn", locked : true,
                  width: 90, align: "center", sortable: false, menuDisabled: true,
                  items: [{
                      icon: CTX_PATH + "/resources/spi/famfamfam/icons/accept.png",
                      tooltip: "상세", scope: this,
                      /*-------------------------------------
                       * 고객 Grid 상세 버튼 클릭 이벤트
                       -------------------------------------*/
                      handler: function(grid, rowIndex, colIndex, item, event, record, row){
                          if (event) event.stopEvent();
                          js_viewPop(record.data.userKey);
                      }
                  }, {
                      icon: CTX_PATH + "/resources/spi/famfamfam/icons/database_edit.png",
                      tooltip: "수정", scope: this,
                      /*-------------------------------------
                       * 고객 Grid 수정 버튼 클릭 이벤트
                       -------------------------------------*/
                      handler: function(grid, rowIndex, colIndex, item, event, record, row){
                          if (event) event.stopEvent();
                          js_formPop(record.data.userKey);
                      }
                  }, {
                      icon: CTX_PATH + "/resources/spi/famfamfam/icons/delete.png",
                      tooltip: "삭제", scope: this,
                      /*-------------------------------------
                       * 고객 Grid 삭제 버튼 클릭 이벤트
                       -------------------------------------*/
                      handler: function(grid, rowIndex, colIndex, item, event, record, row){
                          if (event) event.stopEvent();
                          if ( confirm("[" + record.data.userNm + "] 고객을 삭제하시겠습니까?") ) {
                              
                              SM.submit(null, {
                                  url: "TR_deleteAction.do",
                                  data: { 
                                      userKey: record.data.userKey,
                                      CSRFToken: $("#csrfForm input[name=CSRFToken]").val()
                                  }
                              }, function(messages, xhr) {
                                  if (messages.code == 200) {
                                      grid.getStore().removeAt(rowIndex);
                                  }
                              });
                          }
                      }
                  }, {
                      icon: CTX_PATH + "/resources/spi/famfamfam/icons/hourglass_link.png",
                      tooltip: "개인정보 조회 이력조회", scope: this,
                      /*-------------------------------------
                       * 고객 Grid 개인정보 조회 이력 버튼 클릭 이벤트
                       -------------------------------------*/
                      handler: function(grid, rowIndex, colIndex, item, event, record, row){
                          if (event) event.stopEvent();
                          js_logPop(record.data);
                      }
                  }]
                }
            ]
        });
    });
    
    var js_parseYn = function(val) {
        return val == "Y" ? "사용" : "미사용";
    };
    
    var js_typeSearch = function(typeCd) {

        SM.getCmp("userPanel").reload({
            currentPage: 1
        }, {
            typeCd: typeCd,
            searchKey: "1000",
            searchVal: $("#searchVal").val()
        }, 
        function() {
            if ( typeCd == "" && $("#searchVal").val() == "" ) {
                $("#resetSearchDiv").hide();
            }
            else {
                $("#resetSearchDiv").show();
            }
        });
        
        return false;
    };
    
    var js_search = function() {

        var searchVal = $("#searchVal").val();
        var gridStore = SM.getCmp("userPanel").store;
        
        SM.getCmp("userPanel").reload({
            currentPage: 1
        }, {
            searchKey: "1000",
            searchVal: searchVal,
            typeCd: gridStore.proxy.extraParams.typeCd
        }, 
        function() {
            if ( typeCd == "" && searchVal == "" ) {
                $("#resetSearchDiv").hide();
            }
            else {
                $("#resetSearchDiv").show();
            }
        });
        
        return false;
    };
    
    var js_resetSearch = function() {
        
        SM.getCmp("userPanel").reload({
            currentPage: 1
        }, {},
        function() {
            $("#resetSearchDiv").hide();
            $("#searchVal").val("");
            SM.getCmp("typePanel").reload();
            SM.getCmp("userPanel").reload();
        });
    };
    
    var js_excelAction = function() {

        var totalCount = SM.getCmp("userPanel").store.totalCount;
        if (totalCount <= 0) {
            alert("대상 자료가 존재하지 않습니다."); return false; 
        }
        
        SM.modal({
            title: "엑셀 변환 옵션 선택",
            width: 550,
            height: 430,
            loadUrl: "PR_excelForm.do"
        });
    };

    var js_getSearchCondition = function() {
        var gridStore = SM.getCmp("userPanel").store;
        var sorter = gridStore.sorters.items[0] || {};
        return {
            currentPage: gridStore.currentPage,
            rowPerPage: gridStore.pageSize,
            sortName: sorter.property,
            sortOrder: sorter.direction,
            searchKey: "1000",
            searchVal: $("#searchVal").val(),
            typeCd: gridStore.proxy.extraParams.typeCd || ""
        };
    };
    
    var js_viewPop = function(userKey) {

        SM.modal({
            title: "고객정보",
            width: 600, height: 330,
            loadUrl: "PR_view.do?userKey=" + userKey
        });
    };
    
    var js_formPop = function(userKey) {
  
        SM.modal({
            title: "고객정보",
            width: 700, height: (userKey != "" ? 560 : 490),
            loadUrl: "PR_form.do?userKey=" + userKey
        });
    };
    
    var js_logPop = function(data) {

        SM.modal({
            title: "고객정보 조회 이력 조회",
            width: 500, height: 400,
            loadUrl: "PR_listLog.do?userKey=" + data.userKey + "&userNm=" + data.userNm
        });
    };
</script>
    
</body>
</html>