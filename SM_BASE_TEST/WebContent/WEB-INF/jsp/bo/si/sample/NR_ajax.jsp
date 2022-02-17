<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>AJAX 샘플</title> 
    <style type="text/css">
    .smd-box div.cnt-class { color: #397D33; padding: 0 0 10px 0; }
    </style>
</head>
 
<body>

<table class="tbl-header">
    <tr>
        <th>
            <span class="title-big">AJAX 전송</span>
        </th>
        <td class="tr"><span>AJAX 샘플 입니다.</span></td>
    </tr>
</table>
<div class="smd-box">
    <div class="cnt-class">정상 처리 | 200</div>
    <sm:button value="등록" icon="b3-db-save" id="btn_200" />
    
    <div class="blank"></div>
    
    <div class="cnt-class">정상 처리, 딜레이 2초 | 201</div>
    <sm:button value="등록" icon="b3-db-save" id="btn_201" />
    
    <div class="blank"></div>
    
    <div class="cnt-class">예외 처리 | 500</div>
    <sm:button value="등록" icon="b3-db-save" id="btn_500" />
    
    <div class="blank"></div>
    
    <div class="cnt-class">실패 처리 | 999</div>
    <sm:button value="등록" icon="b3-db-save" id="btn_999" />
</div>

<div class="blank"></div>

<table class="tbl-header">
    <tr>
        <th>
            <span class="title-big">AJAX 폼 전송</span>
            <span class="title-small">using by jquery-validator</span>
        </th>
        <td class="tr"><span>AJAX 폼 전송 샘플 입니다.</span></td>
    </tr>
</table>
<div class="smd-box">
    <form:form name="dataForm" id="dataForm" method="post" action="TR_action.do">
        <input type="hidden" name="command" value="201" />
        <table class="tbl-view">
            <colgroup>
                <col class="th">
                <col>
            </colgroup>
            <tr>
                <th>작성자</th>
                <td>
                    <input type="text" name="writer" size="10" class="smf-text"/>
                </td>
            </tr>
            <tr>
                <th>제목<em>&nbsp;</em></th>
                <td>
                    <input type="text" name="title" size="40" value="제목입니다." class="smf-text"/>
                </td>
            </tr>
            <tr>
                <th>내용<em>&nbsp;</em></th>
                <td>
                    <textarea rows="4" name="contents" class="smf-ta">내용입니다</textarea>
                </td>
            </tr>
        </table>
        
        <sm:button-layout>
            <sm:button value="저장" icon="b3-db-save" type="submit"/>
        </sm:button-layout>
    </form:form> 
</div>

<div class="blank"></div>

<table class="tbl-header">
    <tr>
        <th>
            <span class="title-big">AJAX 페이지 로드</span>
        </th>
        <td class="tr"><span>AJAX 페이지 로드 샘플 입니다.</span></td>
    </tr>
</table>
<div class="smd-box">
    <div class="cnt-class">페이지 로드</div>
    <sm:button value="로드하기 (정상)" icon="b3-tick" id="btnLoad" />
    <sm:button value="로드하기 (404 예외)" icon="b3-tick" id="btnLoad2" />
    
    <div class="blank"></div>
    
    <div id="loadHtml"></div>
</div>


<sm:js names="validation" />
<script type="text/javascript">

    Ext.onReady(function() {

        $("input[id^=btn_]").click(function(e) {
            
            var ids = $(this).attr("id").split("_");
            
            SM.submit(e, {
                url: "TR_action.do",
                data: {
                    command: ids[1]
                }
            }, function(result, xhr) {
                console.log("[CLICK SUBMIT] code : " + result.code + ", text : " + result.text);
            });
        });
        
        $("#dataForm").validate({
            rules: {
                title: { required:true, minlength:2, maxlength:30 },
                contents: { required:true, minlength:2, maxlength:30 }
            }, 
            submitHandler: function(form) {
                
                SM.submit(form, {
                    url: "TR_action.do"
                }, function(result, xhr) {
                    console.log("[AJAX SUBMIT] code : " + result.code + ", text : " + result.text);
                });
            }
        });
        
        $("#btnLoad").click(function(e) {
            $("#loadHtml").SM_LOAD(
                "AR_load.do", { buttonEl : $(e.target) });
        });
        
        $("#btnLoad2").click(function(e) {
            $("#loadHtml").SM_LOAD(
                "AR_xxxx.do", { buttonEl : $(e.target) });
        });
    });
    
</script>


</body>
</html>