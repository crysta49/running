<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="BBS_CONF_UTIL" clazz="com.srpost.cm.bo.base.bbs.conf.BbsConfUtil"/>

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
<div class="smd-box">
    <fieldset>
        <legend>범위 선택</legend>
        <div>
            <input type="radio" name="xlsScope" id="total" value="total" class="smf-radio" />
                <label for="total">전체 검색된 페이지 자료 변환</label>&nbsp;&nbsp;
            <input type="radio" name="xlsScope" id="current" value="current" class="smf-radio" checked="checked" />
                <label for="current">현재 조회중인 자료만 변환</label>
        </div>
    </fieldset>

    <div class="blank"></div>

    <fieldset>
        <legend>항목 선택</legend>
        <div>
            <table class="tbl-excel">
                <tr>
                    <td><input type="checkbox" name="chk" id="title" class="smf-checkbox" value="title" /><label for="title">제목</label></td>
                    <td><input type="checkbox" name="chk" id="writerNm" class="smf-checkbox" value="writerNm" /><label for="writerNm">작성자</label></td>
                    <td><input type="checkbox" name="chk" id="readCnt" class="smf-checkbox" value="readCnt" /><label for="readCnt">조회수</label></td>
                </tr>
                <tr>
                    <td><input type="checkbox" name="chk" id="openYn" class="smf-checkbox" value="openYn" 
                        <c:if test="${confBean.openYn != 'Y'}">disabled="disabled"</c:if>/><label for="openYn">공개여부</label>
                    </td>
                    <td><input type="checkbox" name="chk" id="fileCnt" class="smf-checkbox" value="fileCnt"  
                        <c:if test="${confBean.fileYn != 'Y'}">disabled="disabled"</c:if>/><label for="fileCnt">첨부 수</label>
                    </td>
                    <td><input type="checkbox" name="chk" id="commentCnt" class="smf-checkbox" value="commentCnt"  
                        <c:if test="${confBean.cmtYn != 'Y'}">disabled="disabled"</c:if>/><label for="commentCnt">의견글 수</label>
                    </td>
                </tr>
                <tr>
                    <td><input type="checkbox" name="chk" id="ctgNm" class="smf-checkbox" value="ctgNm"   
                        <c:if test="${confBean.ctgYn != 'Y'}">disabled="disabled"</c:if>/><label for="ctgNm">분류</label>
                    </td>
                    <td><input type="checkbox" name="chk" id="replyNm" class="smf-checkbox" value="replyNm"  
                        <c:if test="${confBean.typeCd != BBS_CONF_UTIL.QNA}">disabled="disabled"</c:if>/><label for="replyNm">답변자</label>
                    </td>
                    <td><input type="checkbox" name="chk" id="statusNm" class="smf-checkbox" value="statusNm"  
                        <c:if test="${confBean.typeCd != BBS_CONF_UTIL.QNA}">disabled="disabled"</c:if>/><label for="statusNm">처리상태</label>
                    </td>
                </tr>
                <tr>
                    <td><input type="checkbox" name="chk" id="regDt" class="smf-checkbox" value="regDt" /><label for="regDt">등록일</label></td>
                    <td><input type="checkbox" name="chk" id="modiDt" class="smf-checkbox" value="modiDt" /><label for="modiDt">최종 수정일</label></td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>
    </fieldset>
    
    <sm:button-layout align="both">
        <div>
            <sm:button value="엑셀 변환" icon="b3-excel" onclick="js_excelConvertAction(this);"/>
        </div>
        <div class="left">
            <sm:button value="기본선택" id="btnDefaultSelect" />
            <sm:button value="전체선택" id="btnTotalSelect" />
        </div>
    </sm:button-layout>
</div>

<div class="blank-2x"></div>

<div>엑셀 변환 자료의 수가 <span class="emphasis">3,000건</span>을 초과할 경우 처리시간이 많이 소요될 수 있습니다.</div>

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
                if (!this.disabled) this.checked = true;
            });
        });

        js_checkDefault();
    });
    
    var js_checkDefault = function() {

        $("#title, #writerNm, #readCnt, #regDt").prop("checked", true);
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
                var condition = parent.js_getSearchCondition();
                condition.xlsColumns = columnsCd + "|" + columnsNm; 
                condition.xlsScope = xlsScope;
                condition.xlsName = "게시물_목록";
                condition.CSRFToken = $("#csrfForm input[name=CSRFToken]").val();
                
                SM.xlsDownload("XR_excelAction.do", {
                	target: $("#indicator"),
                	button: $(btn),
                    data: condition
                }, function(success) {
                    if (success) {
                        Ext.defer(function() {
                            SM.modalClose();
                        }, 1500);
                    }
                });
                
                return false;
            }
        }
    };
</script>
                
</body>
</html>