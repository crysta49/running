<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<html>
<head>
    <title>파일 다운로드 로그</title> 
</head>
 
<body>

<table class="tbl-header">
    <tr>
        <td class="tr">
            <form name="dataForm" method="get" onsubmit="return js_search();">

                <input type="text" name="searchVal" id="searchVal" value="" placeholder="작업자명" class="smf-text"/>
                <sm:button type="submit" glyph="search" value="검색" cssClass="btn-default"/>
                <span id="resetSearchDiv" class="sr-hidden">
                    <sm:button value="해제" cssClass="btn-default" onclick="js_resetSearch();" />
                </span>
            </form>
        </td>
    </tr>
</table>
<div id="gridDiv"></div>

<sm:js names="smgrid" />
<script type="text/javascript">
    Ext.onReady(function() {
        
        SM_GRID({
            id: "gridPanel",
            renderTo: "gridDiv",
            dataListUrl: "JR_fileLogList.do",
            extraParams: {
                fileSeq: "${smp.fileSeq}",
                fileId: "${smp.fileId}"
            },
            height: 265,
            showRownum: true,
            pagingInfo: false,
            pageSize: "<c:out value='${empty smp.rowPerPage ? CONSTANT.RPP_CNT : smp.rowPerPage}' />",
            sorters: { property: "regDt", direction: "DESC" },
            dataField: ["fileSeq", "workerNm", "regDt", "downCnt"],
            dataColumns: [
                { text: "작업자", dataIndex: "workerNm", width: 80 },
                { text: "다운횟수", dataIndex: "downCnt", width: 70 },
                { text: "최종 다운로드일시", dataIndex: "regDt", width: 130 }
            ],
            itemClick: function(record, panel) {
                panel.setLoading(false);
            }
        });
    });
    
    var js_search = function() {

        var searchVal = $("#searchVal").val();
        
        SM.getCmp("gridPanel").reload({
            currentPage: 1
        }, {
            searchVal: searchVal,
            fileSeq: "${smp.fileSeq}",
            fileId: "${smp.fileId}"
        }, function() {
            if ( searchVal != "" )
                $("#resetSearchDiv").show();
        });
        
        return false;
    };
    
    var js_resetSearch = function() {
        
        SM.getCmp("gridPanel").reload({
            currentPage: 1,
            useYn: "Y"
        }, {
            fileSeq: "${smp.fileSeq}",
            fileId: "${smp.fileId}"
        }, function() {
            $("#resetSearchDiv").hide();
            $("#searchVal").val("");
        });
    };
</script>

</body>
</html>