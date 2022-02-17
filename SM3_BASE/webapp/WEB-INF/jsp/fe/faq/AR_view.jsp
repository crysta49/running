<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:br data="${dataBean.contents}" />

<c:if test="${not empty dataBean.fileList}">
    <sm:file-list list="${dataBean.fileList}" noData="true" downCnt="false" fileType="false"/>
</c:if>

<div>
    <span>답변이 도움이 되셨나요?</span> : 
    <a href="#" onclick="FAQ.recomAction('${dataBean.seq}'); return false;">예</a> / 
    <a href="#" onclick="FAQ.decomAction('${dataBean.seq}'); return false;">아니오</a>
</div>