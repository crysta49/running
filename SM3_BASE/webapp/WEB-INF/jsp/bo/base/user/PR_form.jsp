<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="USER_UTIL" clazz="com.srpost.cm.bo.base.user.UserUtil"/>

<c:set var="exist" value="${not empty dataBean.userKey}" />

<html>
<head>
    <title>고객정보 ${exist ? "수정" : "등록"}</title>
</head>
 
<body>

<form:form commandName="dataBean" id="dataForm" name="dataForm" autocomplete="off">
    <form:hidden path="userKey"/>
    
    <table class="tbl-header">
        <tr>
            <th>
                <span class="title-big">고객정보 ${exist ? "수정" : "등록"}</span>
            </th>
            <td class="tr"><span class="required">표시는 필수입력 항목입니다.</span></td>
        </tr>
    </table>
    <table class="tbl-view tbl-form">
        <colgroup>
            <col class="th">
            <col>
            <col class="th">
            <col>
        </colgroup>
        <tr>
            <th>이름<em>&nbsp;</em></th>
            <td>
                <form:input path="userNm" size="20" cssClass="smf-text"/>
            </td>
            <th>ID</th>
            <td>
                <form:input path="userId" size="15" cssClass="smf-text" readonly="${exist ? 'true' : 'false'}"/>
            </td>
        </tr>
        <tr>
            <th>전화번호</th>
            <td><form:input path="userEncTelNum" size="15" cssClass="smf-text" placeholder="02-1111-1111"/></td>
            <th>고객유형</th>
            <td class="plain">
                <c:if test="${exist}">${dataBean.typeNm}</c:if>
                <c:if test="${!exist}">
                    ${USER_UTIL.MGR_REGIST_NM }
                    <input type="hidden" name="typeCd" value="${USER_UTIL.MGR_REGIST}" />
                </c:if>
            </td>
        </tr>
        <tr>
            <th>휴대폰</th>
            <td><form:input path="userEncMobile" size="15" cssClass="smf-text" placeholder="010-1111-1111"/></td>
            <th>이메일</th>
            <td><form:input path="userEncEmail" size="30" cssClass="smf-text" placeholder="user@email.com"/></td>
        </tr>
        <tr>
            <th>주소</th>
            <td colspan="3">
                <form:input path="postCd" size="8" maxlength="7" cssClass="smf-text" readonly="true"/>
                <sm:button value="검색" glyph="search" cssClass="btn-default" onclick="js_openDaumPost();" />
                <div>
                    <form:input path="addr1" size="70" cssClass="smf-text" readonly="true"/>
                </div>
                <div>
                    <form:input path="addr2" size="70" cssClass="smf-text"/>
                </div>
            </td>    
        </tr>
        <tr>
            <th>비밀번호</th>
            <td colspan="3">
                <form:password path="userEncPwd" size="20" maxlength="12" cssClass="smf-text"/>
                <c:if test="${exist}">
                    <span>변경이 없을 경우 입력하지 않으시면 됩니다.</span>
                </c:if> 
                <div>
                    <input type="password" name="userPwd2" id="userPwd2" maxlength="12" class="smf-text" />
                    <span>확인을 위해 비밀번호를 한번 더 입력하세요.</span> 
                </div>
            </td>
        </tr>
        <c:if test="${exist}">
            <tr>
                <th>사용 여부</th>
                <td colspan="3">
                    <form:radiobutton path="useYn" value="Y" label="사용" cssClass="smf-radio" />
                    <form:radiobutton path="useYn" value="N" label="미사용" cssClass="smf-radio"/>
                </td>
            </tr>
            <tr>
                <th>등록일</th>
                <td class="plain">${dataBean.regDt}</td>
                <th>최종 수정일</th>
                <td class="plain">${dataBean.modiDt}</td>
            </tr>
        </c:if>
    </table>

    <sm:button-layout>
        <sm:button type="submit" value="${exist ? '수정' : '등록'}" glyph="saved"/>
    </sm:button-layout>
</form:form>

<sm:js names="validation" />
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">

    Ext.onReady(function() {
    
        $("#dataForm").validate({
            rules: {
                userNm  : { required: true, minlength: 2, maxlength: 10 },
                userId  : { alphanumeric: true, minlength: 2, maxlength: 20, remote: "TR_duplicate.do" },
                userEncPwd : { required: false, minlength: 2, maxlength: 16 },
                userPwd2: { equalTo: "#userEncPwd" },
                userEncTelNum : { telephone: true, maxlength: 20 },
                userEncMobile : { mobile: true, maxlength: 20 },
                userEncEmail  : { email: true, maxlength: 100 },
                addr2   : { maxlength: 65 }
            },
            messages: {
                userId: { remote: $.validator.format("이미 존재하는 ID 입니다.") }
            },
            submitHandler: function(form) {

                SM.submit(form, {
                    url: "${exist ? 'TR_updateAction.do' : 'TR_insertAction.do'}"
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        var me =  parent.SM.getCmp("userPanel");
                        if (me) me.store.reload();

                        SM.modalClose();
                    }
                });
            }
        });
    });
    
    var js_openDaumPost = function() {
        
        new daum.Postcode({
            oncomplete: function(data) {
                
                var fullAddr = '';
                var extraAddr = '';

                if (data.userSelectedType === 'R') {
                    fullAddr = data.roadAddress;
                }
                else {
                    fullAddr = data.jibunAddress;
                }

                if(data.userSelectedType === 'R'){
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                $("#postCd").val(data.zonecode);
                $("#addr1").val(fullAddr);
                $("#addr2").focus();
            }
        }).open();
    };
</script>
                
</body>
</html>