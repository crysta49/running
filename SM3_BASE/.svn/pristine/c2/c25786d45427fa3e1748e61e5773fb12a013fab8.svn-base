<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<sm:static var="Constant" clazz="com.srpost.salmon.constant.Constant"/>
<sm:static var="BbsConfUtil" clazz="com.srpost.cm.bo.base.bbs.conf.BbsConfUtil"/>
<c:set var="userSession" value="${sessionScope[Constant.USER_SESSION_KEY]}"/>

<html>
<head>
    <title>${confBean.bbsNm}</title>
    <sm:js names="validation, multifile, qtip2" />
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/spi/jquery/qtip2/jquery.qtip.css"/>" />
    <script type="text/javascript" src="<c:url value="/resources/front/FE2/js/bbs.js"/>"></script>
    <script type="text/javascript">
    $().ready(function(){

        $("#dataForm").validate({
            rules: {
                title: { required: true, maxlength: 100 },
                question: { required: true },
            }, 
            submitHandler: function(form) {
                
                var url = '${USER_ACTION}' == 'INSERT' ? 'TR_insertAction.do' : 'TR_updateAction.do';
                $(form).ajaxSubmit({
                    url      : url,
                    type     : "POST",
                    success  : function(response) {
                        alert(SM.parseMsg(response).text);
                        
                        if ('${USER_ACTION}' == 'INSERT') {
                            document.listForm.submit();
                        } else {
                            $("form[name=listForm] input[name=bbsSeq]").val('${dataBean.bbsSeq}');
                            $("form[name=listForm]").attr("action", "NR_view.do");
                            document.listForm.submit();
                        }
                    }
                });
            }
        });

        <%--
        $(".multifile").MultiFile({ max: '${confBean.fileCnt}'});
        --%>
    });
    </script>
</head>

<body>

<form:form commandName="dataBean" id="listForm" name="listForm" method="get" action="NR_list.do">
    
    <form:hidden path="bbsCd"/>
    <form:hidden path="bbsSeq"/>
    <input type="hidden" name="currentPage" value="${bbsBean.currentPage}" />
    <input type="hidden" name="searchKey" value="${bbsBean.searchKey}" />
    <input type="hidden" name="searchVal" value="${bbsBean.searchVal}" />
    <input type="hidden" name="_m" value="${smp._m}" />
</form:form>

<form:form commandName="dataBean" id="dataForm" name="dataForm" 
    action="TR_insertAction.do" method="post" enctype="multipart/form-data">
    <form:hidden path="bbsCd"/>
    <form:hidden path="bbsSeq"/>
    <input type="hidden" name="_m" value="${smp._m}" />
    
    <form:hidden path="userBean.userNm"/>
    <form:hidden path="userBean.userEncEmail"/>
    <form:hidden path="userBean.userEncTelNum"/>
    <form:hidden path="userBean.userEncMobile"/>
    
    <c:if test="${USER_ACTION eq 'INSERT' and confBean.typeCd eq BbsConfUtil.QNA}">
    <input type="hidden" name="statusCd" value="200" />
    </c:if>

    <!--칭찬격려글쓰기수정페이지-->
    <div id="write">
        <div class="write_info">
        우리 원은 고객님께 정성을 다하는 기관이 되기 위하여 노력하고 있습니다.<br />
        소중한 칭찬과 격려의 말씀 감사드리며, 더 사랑 받는 서비스로 보답하겠습니다.
        </div>
        <p class="pdb10"><img src="<c:url value="/resources/front/FE2/images/board/icon_essential.gif"/>" alt="필수" class="vm" />
        <span class="hide">(필수)</span> 항목은 필수항목입니다.
        </p>
        
        <table summary="공개여부, 성명, 제목, 내용으로 구성">
            <caption>칭찬격려 글쓰기</caption>
            <colgroup>
                <col style="width:120px" />
                <col style="width:*" />
            </colgroup>
            <tbody>
                <c:if test="${confBean.openYn == 'Y'}">
                <tr>
                    <th scope="row"><span class="essential">공개여부</span><span class="hide">(필수)</span></th>
                    <td>
                        <input type="radio" name="openYn" id="openYnY" value="Y" <c:if test="${dataBean.openYn eq 'Y'}">checked="checked"</c:if> class="rb"/> <label for="openYnY">공개</label>&nbsp;&nbsp;
                        <input type="radio" name="openYn" id="openYnN" value="N" <c:if test="${dataBean.openYn eq 'N' || USER_ACTION eq 'INSERT'}">checked="checked"</c:if> class="rb"/> <label for="openYnN">비공개</label>
                    </td>
                </tr>
                </c:if>
                <tr>
                    <th scope="row"><span class="essential">성명</span><span class="hide">(필수)</span></th>
                    <td>
                        <c:choose>
                            <c:when test="${USER_ACTION eq 'INSERT'}">
                            ${userSession.userNm}
                            </c:when>
                            <c:otherwise>
                            <sm:mask-word word="${dataBean.writerNm}" />
                            </c:otherwise>
                        </c:choose>
                        <span class="tip fr">글 등록 후에는 성명의 성만 노출됩니다. 예) 홍길동 -&gt; 홍OO</span>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><span class="essential">제목</span><span class="hide">(필수)</span></th>
                    <td><form:input path="title" size="60" cssClass="text" style="width:95%;" title="제목" /></td>
                </tr>
                <tr>
                    <th scope="row"><span class="essential">내용</span><span class="hide">(필수)</span></th>
                    <td><form:textarea path="question" rows="20" cols="100" title="내용"/></td>
                </tr>
                

                <%--
                <c:if test="${confBean.fileYn == 'Y'}">
                <tr>
                    <th scope="row">첨부파일</th>
                    <td>
                        <sm:file-list list="${dataBean.fileList}" checkbox="true" downCnt="false"/>
                        <form:hidden path="fileSeq" />
                         
                        <input type="file" name="files" class="text multifile" style="width:80%;" title="첨부파일" multiple="multiple" />
                        <div class="selected-file"></div>
                        <p>* 최대용량 : ${Constant.MAX_UPLOAD_SIZE} KB, 첨부파일 개수 : 최대 ${confBean.fileCnt}개
                        <br/>* 첨부가능한 형식 : ${Constant.PERMIT_EXTENSIONS_STRING}</p>
                    </td>
                </tr>
                </c:if>
                --%>
            </tbody>
        </table>
        
        <div class="write_btn">
            <c:set var="btn_name" value="${USER_ACTION eq 'INSERT' ? 'bt_write' : 'bt_wmodify'}" />
            <c:set var="btn_name_text" value="${USER_ACTION eq 'INSERT' ? '글쓰기' : '수정하기'}" />
            <a href="#" onclick="$('#dataForm').submit(); return false;"><img src="<c:url value="/resources/front/FE2/images/board/${btn_name}.gif"/>" class="cl" alt="${btn_name_text}" /></a>
            <a href="#" onclick="BBS.back(); return false;"><img src="<c:url value="/resources/front/FE2/images/board/bt_cancel.gif"/>" class="cl" alt="취소" /></a>
        </div>
    </div>
    <!--//칭찬격려글쓰기수정페이지-->
    
</form:form>

</body>
</html>