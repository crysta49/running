<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<%-- 개인정보 변경 --%>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>
<c:set var="mgrSession" value="${sessionScope[CONSTANT.MGR_SESSION_KEY]}" />

<div class="smd-box" style="position: relative;">
    <div class="ds-mgr-update-image">
        <a href="#" onclick="js_link('myForm');" title="개인정보 변경">
            <img src="<c:url value="/resources/base/images/base/ds/user-big.gif"/>" alt="개인정보 변경" />
        </a>
    </div>
    
    <div>
        <div style="display: inline-block; padding-top: 2px;">
            <span class="t3-user bold">${mgrSession.mgrNm}</span>님, 안녕하세요.
        </div>
        <a href="#" onclick="js_link('mgrAbsence');" title="부재설정">
            <img src="<c:url value="/resources/base/images/base/ds/btn-absence.gif"/>" alt="부재설정" align="top"/>
        </a>
    </div>
    
    <div class="blank"></div>
    
    <ul class="bullet">
        <li>부서 : ${mgrSession.deptNm}</li>
        <li>직급 : ${mgrSession.gradeNm}</li>
        <li>이메일 : ${mgrSession.email}</li>
        <li>전화 : ${mgrSession.telNum}</li>
        <li>최종 접속일 : ${mgrSession.loginDt}</li>
        <li>할당권한 : 
            <span class="green">
            <c:forEach items="${mgrSession.authList}" var="item" varStatus="status">
                ${item.authNm}${status.last ? '' : ', '}
            </c:forEach>
            </span>
        </li>
    </ul>
</div>