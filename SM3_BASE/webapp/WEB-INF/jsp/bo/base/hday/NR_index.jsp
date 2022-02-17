<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>
<sm:static var="HDAY_UTIL" clazz="com.srpost.cm.bo.base.hday.HdayUtil"/>

<html>
<head>
    <title>${curMenuBean.menuNm}</title>
    <meta name="title" content="공휴일 정보를 관리합니다." />
</head>
 
<body>

<c:set var="cacheClass" value="HdayCache" scope="request" />
<c:import url="/WEB-INF/jsp/bo/common/include/incCacheReload.jsp" charEncoding="UTF-8"/>

<form:form id="csrfForm" name="csrfForm"></form:form>

<div class="row">
    <div class="col-xs-4 list-lbox">
        <div id="hdayGridDiv"></div>
        <div class="btn-blank">
            <sm:button value="공휴일 추가" glyph="plus" onclick="js_insertForm();"/>
        </div>
    </div>
    <div class="col-xs-8">
        <div id="viewDiv">
            <div class="bg-box bg-info text-info">좌측에서 공휴일을 선택하면 상세내용을 조회할 수 있습니다.</div>
        </div>
    </div>
</div>

<sm:js names="validation, smgrid" />
<script type="text/javascript">
  
    Ext.onReady(function() {

        SM_GRID({
            id: "hdayPanel",
            title: "공휴일",
            renderTo: "hdayGridDiv",
            dataListUrl: "JR_list.do",
            enablePaging: false,
            remoteSort: false,
            height: 400,
            dataField: ["seq", "hdayNm", "startDd", "useYn"],
            dataColumns: [
                { text: "공휴일", dataIndex: "hdayNm", width: 100 },
                { text: "시작일", dataIndex: "startDd", width: 80, renderer: function(val) {
                    return val ? val : "매주";
                }},
                { text: "사용여부", dataIndex: "useYn", width: 60, renderer: function(val) {
                    return val == "Y" ? "사용" : "미사용";
                }}
            ],
            tools: [{
                type: "refresh",
                qtip: "다시읽기",
                scope: this,
                handler: function(event, toolEl, panel) {
                    var me = SM.getCmp("hdayPanel");
                    me.store.reload();
                }
            }],
            /*-------------------------------------
             * 공휴일 아이템 클릭 이벤트
             -------------------------------------*/
            itemClick : function(record, panel) {

                $("#viewDiv").SM_LOAD("AR_view.do", {
                    seq: record.data.seq
                }, function(){
                    panel.setLoading(false);
                });
            }
        });
    });
    
    var js_insertForm = function() {

        $("#viewDiv").SM_LOAD("AR_view.do", {});
    };
    
    var js_deleteAction = function(e, seq) {
        
        var me = SM.getCmp("hdayPanel");

        if ( confirm("삭제 하시겠습니까?") ) {
            SM.submit(e, {
                url: "TR_deleteAction.do",
                data: { 
                    seq: seq,
                    CSRFToken: $("#dataForm input[name=CSRFToken]").val()
                }
            }, function(messages, xhr) {
                if (messages.code == 200) {
                    me.store.reload();
                    $("#viewDiv").html("");
                    
                    js_cacheReloadAction(e);
                }
            });
        }
    };

    var js_changeCycle = function(value) {
        
        $("#TR_${HDAY_UTIL.EVERY_WEEK}, #TR_${HDAY_UTIL.EVERY_YEAR}, #TR_DT").hide(); 
        
        if ( value == "${HDAY_UTIL.EVERY_WEEK}" ) {
            $("#TR_${HDAY_UTIL.EVERY_WEEK}").show(); 
        }
        else if ( value == "${HDAY_UTIL.EVERY_YEAR}" ) {
            $("#TR_${HDAY_UTIL.EVERY_YEAR}, #TR_DT").show();
        }
        else {
            $("#TR_DT").show();
        }
    };
</script>
    
</body>
</html>