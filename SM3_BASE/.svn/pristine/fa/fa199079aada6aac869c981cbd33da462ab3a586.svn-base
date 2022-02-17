<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>
 
<c:forEach items="${bbsList}" var="item" varStatus="index">
    <div class="row">
        <div class="col-xs-10 text-overflow">
            <span class="f-bold f-15">
                <a href="<c:url value="/bo/base/bbs/core/NR_view.do?bbsCd=${item.bbsCd}&bbsSeq=${item.bbsSeq}"/>">${item.title}</a>
            </span>
        </div>
        <div class="col-xs-2 text-right">
            <c:if test="${not empty item.statusNm }">
                <span class="label label-status-${item.statusCd}">${item.statusNm}</span>
            </c:if>
            
        </div>                
        <div class="col-xs-12" style="margin-top: 2px;">
            <div class="col-xs-2">
                <span class="date f-11">${item.regDt}</span>
            </div>
            <div class="col-xs-10 text-overflow">
                <%-- <c:if test="${not empty item.vocNm }"><span class="mark text-overflow label label-info">${item.vocNm}</span></c:if>
                <c:if test="${not empty item.ctgNm1 }"> &nbsp; ${item.ctgNm1 }</c:if>
                <c:if test="${not empty item.ctgNm2 }"> &gt; ${item.ctgNm2 }</c:if>
                <c:if test="${not empty item.ctgNm3 }"> &gt; ${item.ctgNm3 }</c:if> --%>
            </div>
        </div>
    </div>
    <c:if test="${!index.last}"><hr/></c:if>
</c:forEach>
