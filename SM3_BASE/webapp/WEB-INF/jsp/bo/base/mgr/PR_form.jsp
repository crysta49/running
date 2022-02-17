<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<c:set var="exist" value="${not empty dataBean.mgrId}" />

<html>
<head>
    <title>직원정보 ${exist ? "수정" : "등록"}</title>
</head>
 
<body>

<form:form commandName="dataBean" id="dataForm" name="dataForm" >
    <form:hidden path="deptCd"/>
    
    <table class="tbl-header">
        <tr>
            <th>
                <span class="title-big">직원정보 ${exist ? "수정" : "등록"}</span>
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
                <form:input path="mgrNm" size="20" cssClass="smf-text"/>
            </td>
            <th>ID (사번)<em>&nbsp;</em></th>
            <td>
                <form:input path="mgrId" size="15" cssClass="smf-text" readonly="${exist ? 'true' : 'false'}"/>
            </td>
        </tr>
        <tr>
            <th>부서<em>&nbsp;</em></th>
            <td class="plain">
                <div class="deptTreeDiv" id="deptNm"></div>
            </td>
            <th>직급</th>
            <td><form:input path="gradeNm" size="25" cssClass="smf-text"/></td>
        </tr>
        <tr>
            <th>전화번호</th>
            <td><form:input path="telNum" size="15" cssClass="smf-text" placeholder="02-1111-1111"/></td>
            <th>역할</th>
            <td><form:input path="roleNm" size="30" cssClass="smf-text"/></td>
        </tr>
        <tr>
            <th>휴대폰번호</th>
            <td><form:input path="mobile" size="15" cssClass="smf-text" placeholder="010-1111-1111"/></td>
            <th>팩스번호</th>
            <td><form:input path="faxNum" size="15" cssClass="smf-text" placeholder="02-1111-1111"/></td>
        </tr>
        <tr>
            <th>이메일</th>
            <td><form:input path="email" size="30" cssClass="smf-text" placeholder="user@email.com"/></td>
            <th>알림</th>
            <td>
                <form:checkbox path="smsYn" value="Y" label="휴대폰" cssClass="smf-checkbox" />
                <form:checkbox path="emailYn" value="Y" label="이메일" cssClass="smf-checkbox"/>
                <%-- <form:checkbox path="alimYn" value="Y" label="메신저" cssClass="smf-checkbox"/> --%>
            </td>
        </tr>
        <tr>
            <th>비밀번호<em>&nbsp;</em></th>
            <td colspan="3">
                <form:password path="mgrEncPwd" size="20" maxlength="12" cssClass="smf-text"/>
                <c:if test="${exist}">
                    <span>변경이 없을 경우 입력하지 않으시면 됩니다.</span>
                </c:if> 
                <div>
                    <input type="password" name="mgrPwd2" id="mgrPwd2" maxlength="12" class="smf-text" /> 
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
                <th>접속일</th>
                <td class="plain">${dataBean.loginDt}</td>
                <th>접속</th>
                <td class="plain">${dataBean.loginCnt} 회</td>
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
<script type="text/javascript">

    $(document).ready(function(){
        
        $("input[name=mgrNm]").focus();
    
        $("#dataForm").validate({
            rules: {
                mgrNm  : { required: true, minlength: 2, maxlength: 10 },
                deptCd : { required: true },
                mgrId  : { required: true, alphanumeric: true, minlength: 2, maxlength: 20
                           ${exist ? '' : ', remote: \'TR_duplicate.do\''}},
                mgrEncPwd : { required: ${exist ? 'false' : 'true'}, minlength: 2, maxlength: 16 },
                mgrPwd2: { equalTo: "#mgrEncPwd" },
                gradeNm: { maxlength: 30 },
                roleNm : { maxlength: 60 },
                telNum : { telephone: true, maxlength: 20 },
                faxNum : { telephone: true, maxlength: 20 },
                mobile : { mobile: true, maxlength: 20 },
                email  : { email: true, maxlength: 100 }
            },
            messages: {
                mgrId: { remote: $.validator.format("이미 존재하는 ID 입니다.") }
            },
            submitHandler: function(form) {
                
                var deptCd = $("#deptCd").val();
                if ( deptCd == "" ) {
                    alert("부서를 선택하세요.");
                    $("input[name=deptNm]").focus(); return false;
                }
                
                var mailChcked = $("input[name=emailYn]").is(":checked");
                var smsChecked = $("input[name=smsYn]").is(":checked");

                if ( mailChcked ) {
                    var emailVal = $("#email").val();
                    if ( !emailVal ) {
                        alert("이메일 알림을 선택했을 경우 이메일 주소는 필수입력 항목입니다.\n\n올바른 이메일 주소를 입력하세요."); 
                        $("#email").focus(); return false;
                    } 
                }
                
                if ( smsChecked ) {
                    var mobileVal = $("#mobile").val();
                    if ( mobileVal.length < 12 ) {
                        alert("휴대폰 알림을 선택했을 경우 휴대폰은 필수입력 항목입니다.\n\n올바른 휴대폰 번호를 입력하세요."); 
                        $("#mobile").focus(); return false;
                    } 
                }

                SM.submit(form, {
                    url: "${exist ? 'TR_updateAction.do' : 'TR_insertAction.do'}"
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        var me =  parent.SM.getCmp("mgrPanel");
                        if (me) me.store.reload();

                        SM.modalClose();
                    }
                });
            }
        });
        
        $(".deptTreeDiv").SM_TREECOMBO({
            dataListUrl: CTX_PATH + "/bo/base/dept/JR_listAll.do",
            value: "${empty dataBean.deptCd ? smp.deptCd : dataBean.deptCd}",
            select: function(record) {
                $("#deptCd").val(record.data.id);
                return false;
            }
        });
    });
    
</script>
                
</body>
</html>