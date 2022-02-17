<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<html>
<head>
    <title>AJAX 샘플</title> 
    <style type="text/css">
    div.cnt-class { color: #397D33; padding: 0 0 10px 0; }
    </style>
</head>
 
<body>

<table class="tbl-header">
    <tr>
        <th>
            <span class="title-big">업로드</span>
            <span class="title-small">파일 업로드 샘플 입니다.</span>
        </th>
        <td class="tr"><span class="required">표시는 필수입력 항목입니다.</span></td>
    </tr>
</table>
<form:form name="dataForm" id="dataForm" method="post" action="TR_action.do"
    enctype="multipart/form-data">
    
    <input type="hidden" name="command" value="201" />
    <input type="hidden" name="${CONSTANT.UPLOAD_FOLDER_PARAM_KEY}" value="sample" />
    
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
            <th>첨부파일</th>
            <td style="line-height: 24px;">
                <div class="cnt-class">※ 허용 확장자 : <strong>
                <c:forEach items="${CONSTANT.PERMIT_EXTENSIONS}" var="item" varStatus="status">
                    ${item}${status.last ? "" : ","} 
                </c:forEach></strong> (최대 크기 : ${CONSTANT.MAX_UPLOAD_SIZE} KB)
                </div>
                <input type="file" name="files" /><br/>
                <input type="file" name="files" /><br/>
                <input type="file" name="files" /><br/>
                <input type="file" name="files" />
            </td>
        </tr>
    </table>
    
    <sm:button-layout>
        <sm:button value="저장" icon="b3-db-save" type="submit"/>
    </sm:button-layout>
</form:form>  

<sm:js names="validation" />
<script type="text/javascript">

    Ext.onReady(function() {

        $("#dataForm").validate({
            rules: {
                title: { required:true, minlength:2, maxlength:30 }
            }, 
            submitHandler: function(form) {
                
                SM.submit(form, {
                    url: "TR_upload.do"
                }, function(result, xhr) {
                    console.log("[AJAX SUBMIT] code : " + result.code + ", text : " + result.text);
                });
            }
        });
    });
    
</script>


</body>
</html>