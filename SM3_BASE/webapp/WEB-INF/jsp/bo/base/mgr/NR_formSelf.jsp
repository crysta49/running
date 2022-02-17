<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>
<c:set var="mgrSession" value="${sessionScope[CONSTANT.MGR_SESSION_KEY]}" />

<sm:static var="MGR_UTIL" clazz="com.srpost.cm.bo.base.mgr.MgrUtil"/>
<c:set var="imgExtends" value="jpg, jpeg, gif, png, bmp" />

<html>
<head>
    <title>${curMenuBean.menuNm}</title>
    <meta name="title" content="개인정보를 수정합니다." />
</head>
 
<body>

<form:form commandName="dataBean" id="dataForm" name="dataForm" autocomplete="off" enctype="multipart/formdata">

    <table class="tbl-header">
        <tr>
            <th>
                <span class="title-big">${curMenuBean.menuNm}</span>
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
            <th rowspan="3">
                <img src="<c:url value="${dataBean.photo}"/>" class="photo"/>
            </th>
            <td class="plain">
                ${dataBean.mgrNm}
            </td>
            <th>ID (사번)</th>
            <td class="plain">
                ${dataBean.mgrId}
            </td>
        </tr>
        <tr>
            <td class="plain">
                ${dataBean.deptNm}
            </td>
            <th>직급</th>
            <td>
                <c:if test="${!CONSTANT.IS_DEPT_CONNECT}">
                    <form:input path="gradeNm" size="30" cssClass="smf-text" />
                </c:if>
                <c:if test="${CONSTANT.IS_DEPT_CONNECT}">
                    ${dataBean.gradeNm}
                </c:if>
            </td>
        </tr>
        <tr>
            <td>
                <c:if test="${!CONSTANT.IS_DEPT_CONNECT}">
                    <form:input path="telNum" size="15" cssClass="smf-text" placeholder="02-1111-1111"/> (전화번호)
                </c:if>
                <c:if test="${CONSTANT.IS_DEPT_CONNECT}">
                    ${dataBean.telNum}
                </c:if>
            </td>
            <th>역할</th>
            <td>
                <c:if test="${!CONSTANT.IS_DEPT_CONNECT}">
                    <form:input path="roleNm" size="30" cssClass="smf-text"/>
                </c:if>
                <c:if test="${CONSTANT.IS_DEPT_CONNECT}">
                    ${dataBean.roleNm}
                </c:if>
            </td>
        </tr>
        <tr>
            <th>휴대폰번호</th>
            <td>
                <c:if test="${!CONSTANT.IS_DEPT_CONNECT}">
                    <form:input path="mobile" size="15" cssClass="smf-text" placeholder="010-1111-1111"/>
                </c:if>
                <c:if test="${CONSTANT.IS_DEPT_CONNECT}">
                    ${dataBean.mobile}
                </c:if>
            </td>
            <th>팩스번호</th>
            <td>
                <c:if test="${!CONSTANT.IS_DEPT_CONNECT}">
                    <form:input path="faxNum" size="15" cssClass="smf-text" placeholder="02-1111-1111"/>
                </c:if>
                <c:if test="${CONSTANT.IS_DEPT_CONNECT}">
                    ${dataBean.faxNum}
                </c:if>
            </td>
        </tr>
        <tr>
            <th>이메일</th>
            <td>
                <c:if test="${!CONSTANT.IS_DEPT_CONNECT}">
                    <form:input path="email" size="30" cssClass="smf-text" placeholder="user@email.com"/>
                </c:if>
                <c:if test="${CONSTANT.IS_DEPT_CONNECT}">
                    ${dataBean.email}
                </c:if>
            </td>
            <th>알림</th>
            <td>
                <form:checkbox path="smsYn" value="Y" label="휴대폰" cssClass="smf-checkbox" />
                <form:checkbox path="emailYn" value="Y" label="이메일" cssClass="smf-checkbox"/>
                <%-- <form:checkbox path="alimYn" value="Y" label="메신저" cssClass="smf-checkbox"/> --%>
            </td>
        </tr>
        <c:if test="${!CONSTANT.IS_DEPT_CONNECT}">
            <tr>
                <th>비밀번호</th>
                <td colspan="3">
                    <form:password path="mgrEncPwd" size="20" maxlength="12" cssClass="smf-text"/>
                    <span>변경이 없을 경우 입력하지 않으면 됩니다.</span>
                    <div>
                        <input type="password" name="mgrPwd2" id="mgrPwd2" maxlength="12" class="smf-text" /> 
                        <span>확인을 위해 비밀번호를 한번 더 입력하세요.</span> 
                    </div>
                </td>
            </tr>
        </c:if>
        <tr>
            <th>사진</th>
            <td colspan="3">
                <div class="tagit">
                    <c:if test="${dataBean.photo != MGR_UTIL.DEFAULT_PHOTO}">
                        <span class="text-warning">등록한 사진을 삭제하시려면 <a href="#" class="bold" onclick="js_photoDelete();">여기</a>를 클릭하세요.</span><br/>
                    </c:if>
                    <span class="text-info">사진 크기는 <span class="text-danger bold">200 x 200</span>로 조절하신 후 등록해야 왜곡없이 표시됩니다.</span><br/>
                    <span class="text-info">첨부 가능한 파일 확장자는 <span class="text-danger bold">${imgExtends}</span> 입니다.</span>
                </div>
                <input type="file" name="files" multiple="multiple" class="multifile"/>
                <div class="selected-file"></div>
                <input type="hidden" name="${CONSTANT.UPLOAD_FOLDER_PARAM_KEY}" value="mgr_photo" />
            </td>
        </tr>
        <tr>
            <th>할당권한</th>
            <td class="plain" colspan="3">
                <c:forEach items="${mgrSession.authList}" var="item" varStatus="status">
                    ${item.authNm}${status.last ? '' : ', '}
                </c:forEach>
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
    </table>

    <sm:button-layout>
        <sm:button type="submit" value="저장" glyph="saved" />
    </sm:button-layout>
</form:form>

<sm:js names="validation, multifile" />
<script type="text/javascript">

    $(document).ready(function(){
        
        //파일
        $(".multifile").MultiFile({
            max: "1",
            accept: "${imgExtends}"
        });
        
        $("#dataForm").validate({
            rules: {
                <c:if test="${!CONSTANT.IS_DEPT_CONNECT}">
                    mgrNm  : { required: true, minlength: 2, maxlength: 10 },
                    mgrEncPwd : { required: false, minlength: 2, maxlength: 16 },
                    mgrPwd2: { equalTo: "#mgrEncPwd" },
                </c:if>
                gradeNm: { maxlength: 30 },
                roleNm : { maxlength: 60 },
                telNum : { telephone: true, maxlength: 20 },
                faxNum : { telephone: true, maxlength: 20 },
                mobile : { mobile: true, maxlength: 20 },
                email  : { email: true, maxlength: 100 }
            },
            submitHandler: function(form) {

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
                    url: "TR_updateSelfAction.do"
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        self.location.reload();
                    }
                });
            }
        });
    });
    
    var js_photoDelete = function() {
        
        if ( confirm("사진을 삭제 하시겠습니까?") ) {
            SM.submit(null, {
                url: CTX_PATH + "/bo/base/mgr/TR_photoDeleteAction.do",
                data: {
                    CSRFToken: $("#dataForm input[name=CSRFToken]").val()
                }
            }, function(messages, xhr) {
                if (messages.code == 200) {
                    self.location.reload();
                }
            });
        }
    };
    
</script>
                
</body>
</html>