<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>엑셀변환</title>
</head>
 
<body>

<form:form id="csrfForm" name="csrfForm"></form:form>

<table class="tbl-header">
    <tr>
        <th>
            <span class="title-big">엑셀 변환 범위와 항목을 선택하세요.</span>
        </th>
        <td class="tr"><div id="indicator"></div></td>
    </tr>
</table>

<div class="panel panel-default">
    <div class="panel-body">
        <fieldset>
            <legend>범위 선택</legend>
            <div>
                <input type="radio" name="xlsScope" id="total" value="total" class="smf-radio" />
                    <label for="total">전체 검색된 페이지 자료 변환</label>&nbsp;&nbsp;
                <input type="radio" name="xlsScope" id="current" value="current" class="smf-radio" checked="checked" />
                    <label for="current">현재 조회중인 자료만 변환</label>
            </div>
        </fieldset>
    
        <fieldset>
            <legend>항목 선택</legend>
            <div>
                <table class="tbl-excel">
                    <tr>
                        <td><input type="checkbox" name="chk" id="ctgNm" class="smf-checkbox" value="ctgNm" /><label for="ctgNm">분류</label></td>
                        <td><input type="checkbox" name="chk" id="title" class="smf-checkbox" value="title" /><label for="title">제목</label></td>
                        <td><input type="checkbox" name="chk" id="mgrNm" class="smf-checkbox" value="mgrNm" /><label for="mgrNm">작성자</label></td>
                        <td><input type="checkbox" name="chk" id="readCnt" class="smf-checkbox" value="readCnt" /><label for="readCnt">조회수</label></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" name="chk" id="recomCnt" class="smf-checkbox" value="recomCnt" /><label for="recomCnt">추천수</label></td>
                        <td><input type="checkbox" name="chk" id="oppCnt" class="smf-checkbox" value="oppCnt" /><label for="oppCnt">비추천수</label></td>
                        <td><input type="checkbox" name="chk" id="fileCnt" class="smf-checkbox" value="fileCnt" /><label for="fileCnt">첨부 수</label></td>
                        <td><input type="checkbox" name="chk" id="regDt" class="smf-checkbox" value="regDt" /><label for="regDt">등록일</label></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox" name="chk" id="modiDt" class="smf-checkbox" value="modiDt" /><label for="modiDt">최종 수정일</label></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </div>
        </fieldset>
        
        <sm:button-layout align="both">
            <div class="col-xs-6 btn-group">
                <sm:button value="기본선택" glyph="check" cssClass="btn-default" id="btnDefaultSelect" />
                <sm:button value="전체선택" glyph="ok" cssClass="btn-default" id="btnTotalSelect" />
            </div>
            <div class="col-xs-6 text-right">
                <sm:button value="엑셀 변환" glyph="floppy-save" onclick="js_excelConvertAction(this);"/>
            </div>
        </sm:button-layout>
    </div>        
</div>

<div class="bg-box bg-info text-info">엑셀 변환 자료의 수가 <span class="text-danger bold">5,000건</span>을 초과할 경우 처리시간이 많이 소요될 수 있습니다.</div>

<script type="text/javascript" src="<c:url value="/resources/spi/jquery/fileDownload/jquery.fileDownload.min.js"/>"></script>
<script type="text/javascript">

    Ext.onReady(function() {
    
        $("#btnDefaultSelect").click(function() {
            $(".smf-checkbox").each(function() {
                this.checked = false;
            });
            js_checkDefault();
        });
        
        $("#btnTotalSelect").click(function() {
            $(".smf-checkbox").each(function() {
                this.checked = true;
            });
        });
    
        js_checkDefault();
    });
    
    var js_checkDefault = function() {
    
        $("#ctgNm, #title, #mgrNm, #regDt").prop("checked", true);
    };
    
    var js_excelConvertAction = function(btn) {
    
        var columnsCd = [];
        var columnsNm = [];
        $(".smf-checkbox:checked").each(function(){ 
            columnsCd.push($(this).val());
            columnsNm.push($(this).next().text());
        });
    
        if ( columnsCd.length < 1 ) {
            alert("한 개 이상의 항목을 선택하세요."); return;
        }
        else {
            var xlsScope = $("input[name=xlsScope]:checked").val();
            
            if ( confirm("엑셀파일로 내려받으시겠습니까?") ) {
    
                // 부모 페이지 검색조건 획득
                var condition = parent.FAQ.getSearchCondition();
                condition.xlsColumns = columnsCd + "|" + columnsNm; 
                condition.xlsScope = xlsScope;
                condition.xlsName = "지식_목록";
                condition.CSRFToken = $("#csrfForm input[name=CSRFToken]").val();
    
                SM.xlsDownload("XR_excelAction.do", {
                	target: $("#indicator"),
                	button: $(btn),
                    data: condition
                }, function(success) {
                    if (success) {
                        SM.modalClose();
                    }
                });
                
                return false;
            }
        }
    };
</script>
                
</body>
</html>