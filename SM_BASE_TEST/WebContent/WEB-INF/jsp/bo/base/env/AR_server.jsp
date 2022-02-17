<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<div class="panel-body panel-env">
    <fieldset>
        <legend><img src="<c:url value="/resources/base/images/base/env/serverinfo_text.png"/>" /></legend>
        <div>
            <dl class="dl-horizontal">
                <dt>서버</dt>
                <dd>${dataMap.hostName} / ${dataMap.address}</dd>
                
                <dt>도메인 / 포트</dt>
                <dd>${pageContext.request.serverName} / ${pageContext.request.serverPort}</dd>
                
                <dt>언어셋 (OS)</dt>
                <dd>${dataMap.language} ${dataMap.country}</dd>
                
                <dt>인코딩</dt>
                <dd>${dataMap.osEncoding} (IO : ${dataMap.fileEncoding})</dd>
                
                <dt>USER</dt>
                <dd>${dataMap.userName} (${dataMap.userHome})</dd>
                
                <dt>USER 폴더</dt>
                <dd>${dataMap.userDir}</dd>
            </dl>
        </div>
        <div class="text-center" style="position: absolute; top: 30px; right: 25px;">
            <img src="<c:url value="/resources/base/images/base/env/${dataMap.osImage}.png"/>" /><br/>
            <strong>${dataMap.osName}</strong> (${dataMap.osVersion}, ${dataMap.osArch})
        </div>
    </fieldset>
</div>
    
<div class="blank-2x"></div>

<div class="panel-body panel-env">
    <fieldset>
        <legend><img src="<c:url value="/resources/base/images/base/env/cpuinfo_text.png"/>" /></legend>
        <div>
            <c:set value="${cpuList[0]}" var="cpu" />
            <dl class="dl-horizontal">
                <dt>프로세서</dt>
                <dd>${cpu.info} (${cpu.arch}, <strong>${cpu.core}</strong> core)</dd>
            </dl>
        </div>
    </fieldset>
</div>

<div class="blank-2x"></div>

<div class="panel-body panel-env">
    <fieldset>
        <c:set value="${memoryList[0]}" var="osmem" />
        <legend><img src="<c:url value="/resources/base/images/base/env/memoryinfo_text.png"/>" /></legend>
    
        <div class="progress">
            <div class="progress-bar progress-bar-striped progress-bar-info active" role="progressbar" aria-valuenow="0"
                aria-valuemin="0" aria-valuemax="100"
                style="min-width: 2em; width: ${osmem.usagePct}%;">${osmem.usagePct}%</div>
        </div>
        
        <dl class="dl-horizontal">
            <dt>OS 메모리</dt>
            <dd>${osmem.usage}/${osmem.total} (유휴 : ${osmem.free})</dd>
        </dl>
    </fieldset>
</div>

<div class="blank-2x"></div>

<div class="panel-body panel-env">
    <fieldset>
        <c:set value="${memoryList[1]}" var="vmmem" />
        <legend><img src="<c:url value="/resources/base/images/base/env/memoryinfo_text.png"/>" /></legend>
    
        <div class="progress">
            <div class="progress-bar progress-bar-striped progress-bar-warning active" role="progressbar" aria-valuenow="0"
                aria-valuemin="0" aria-valuemax="100"
                style="min-width: 2em; width: ${vmmem.usagePct}%;">${vmmem.usagePct}%</div>
        </div>
        
        <dl class="dl-horizontal">
            <dt>VM 메모리</dt>
            <dd>${vmmem.usage}/${vmmem.total} (유휴 : ${vmmem.free})</dd>
        </dl>
    </fieldset>
</div>

<div class="blank-2x"></div>

<div class="panel-body panel-env">
    <fieldset>
        <legend><img src="<c:url value="/resources/base/images/base/env/diskinfo_text.png"/>" /></legend>
        
        <c:forEach items="${diskList}" var="item" varStatus="status">
            <div style="margin-bottom: 6px;">
                ${item.dirName} (${item.usage}/${item.total})
            </div>
            <div class="progress">
                <div class="progress-bar progress-bar-striped progress-bar-success active" role="progressbar" aria-valuenow="0"
                    aria-valuemin="0" aria-valuemax="100"
                    style="min-width: 2em; width: ${item.usagePct}%;">${item.usagePct}%</div>
            </div>
            <c:if test="${!status.last}">
                <div class="blank"></div>
            </c:if>
        </c:forEach>
    </fieldset>
</div>
