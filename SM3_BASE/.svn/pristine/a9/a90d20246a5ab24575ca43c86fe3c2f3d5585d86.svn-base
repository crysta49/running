<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="LOG_FILE_REPOSITORY" clazz="com.srpost.salmon.spi.env.repository.LogFileRepository"/>

<c:if test="${not empty error}">
    <div class="bg-box bg-danger text-danger">${error}</div>
</c:if>

<c:if test="${empty error}">

    <table class="tbl-header">
        <tr>
            <th title="${LOG_FILE_REPOSITORY.FILE_PATH}">
                <span class="title-big">로그 파일 목록</span>
            </th>
            <td class="tr"><span class="label label-success">${LOG_FILE_REPOSITORY.CLASS_NAME} (${LOG_FILE_REPOSITORY.APPENDER_NAME})</span></td>
        </tr>
    </table>
    
    <div id="logGridDiv"></div>
    
    <div class="blank"></div>

    <div id="logViewDiv"></div>
    
    <script type="text/javascript">
        Ext.onReady(function () {
    
            var logList = [];
            <c:forEach items="${dataList}" var="item">
                logList.push( ["${item.fileNm}", "${item.fileSize}", "${item.extension}"] );
            </c:forEach>
            
            SM_GRID({
                id: "logPanel",
                renderTo: "logGridDiv",
                height: 235,
                showRownum: true,
                enablePaging: false,
                remoteSort: false,
                dataField: ["fileNm", "fileSize", "extension"],
                store: Ext.create("Ext.data.ArrayStore", {
                    fields: ["fileNm", "fileSize", "extension"],
                    data: logList
                }),
                dataColumns: [
                    { text: "파일명", dataIndex: "fileNm", sortable: false, menuDisabled: true, width: 200 },
                    { text: "크기", dataIndex: "fileSize", sortable: false, menuDisabled: true, width: 90 },
                    { text: "수정일", dataIndex: "extension", sortable: false, menuDisabled: true, width: 140 },
                    { text: "내려받기", xtype: "actioncolumn", width: 70, align: "center", sortable: false, menuDisabled: true,
                      items: [{
                          icon: CTX_PATH + "/resources/spi/famfamfam/icons/download.gif",
                          tooltip: "내려받기", scope: this,
                          handler: function(grid, rowIndex, colIndex, item, event, record, row){
                            if (event) event.stopEvent();
                            js_logDownload(record.data.fileNm);
                          }
                      }
                ]}],
                itemClick: function(record, panel) {
        
                    $("#logViewDiv").SM_LOAD("AR_logView.do", {
                        file: record.data.fileNm
                    }, function(){
                        panel.setLoading(false);
                    });
                }
            });
        });
    </script>
</c:if>    