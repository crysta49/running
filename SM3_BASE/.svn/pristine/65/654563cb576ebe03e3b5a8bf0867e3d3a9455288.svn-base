<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>위젯 사용 직원 목록</title>
</head>
 
<body>

<table class="tbl-header">
    <tr>
        <th>위젯 사용 직원 목록</th>
        <td class="tr">
            <form name="dataForm" method="get" onsubmit="return js_search();">
                <input type="text" name="searchVal" id="searchVal" value="" class="smf-text"/>
                <sm:button type="submit" icon="b3-search" value="검색" />
                <span id="resetSearchDiv" class="hidden">
                    <sm:button value="해제" icon="b3-search-reset" onclick="js_resetSearch();" />
                </span>
            </form>
        </td>
    </tr>
</table>
<div id="mgrGridDiv"></div>

<sm:js names="smgrid" />
<script type="text/javascript">
    Ext.onReady(function() {
        
        SM_GRID({
            id: "mgrPanel",
            renderTo: "mgrGridDiv",
            dataListUrl: "JR_assignList.do",
            extraParams: {
                seq: "${smp.seq}"
            },
            height: 265,
            showRownum: true,
            //pagingInfo: false,
            pageSize: "<c:out value='${empty smp.rowPerPage ? CONSTANT.RPP_CNT : smp.rowPerPage}' />",
            dataField: ["deptNm", "mgrId", "mgrNm"],
            dataColumns: [
                { text: "부서", dataIndex: "deptNm", sortable: false, menuDisabled: true, width: 140 },
                { text: "이름", dataIndex: "mgrNm", sortable: false, menuDisabled: true, width: 90 },
                { text: "ID", dataIndex: "mgrId", sortable: false, menuDisabled: true, width: 80 }
            ]
        });
    });
    
    var js_search = function() {

        var searchVal = $("#searchVal").val();
        
        SM.getCmp("mgrPanel").reload({
            currentPage: 1
        }, {
            searchKey: "1001",
            searchVal: searchVal,
            seq: "${smp.seq}"
        }, 
        function() {
            if ( searchVal != "" )
                $("#resetSearchDiv").show();
        });
        
        return false;
    };
    
    var js_resetSearch = function() {
        
        SM.getCmp("mgrPanel").reload({
            currentPage: 1
        }, {
            seq: "${smp.seq}"
        },
        function() {
            $("#resetSearchDiv").hide();
            $("#searchVal").val("");
        });
    };
    
</script>

</body>
</html>