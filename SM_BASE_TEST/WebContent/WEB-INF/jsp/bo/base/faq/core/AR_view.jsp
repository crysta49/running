<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<div class="row" id="viewDivSub_${dataBean.seq}">
    <div class="col-xs-1">
        <span class="mark f-bold">A</span>
    </div>
    <div class="col-xs-11 answer-content">
        ${dataBean.contents}
        <sm:file-list list="${dataBean.fileList}"/>
        
        <div class="score-box">
            <div class="score-title f-bold">위 내용이 도움이 되었다면 추천해 주세요.</div>
            <sm:button-layout align="left">
                <sm:button value="네. 도움이 되었습니다." glyph="thumbs-up" cssClass="btn-plain" onclick="FAQ.recomAction('${dataBean.seq}'); return false;"/>
                <sm:button value="아니오. 도움이 되지 않았습니다." glyph="thumbs-down" cssClass="btn-plain" onclick="FAQ.decomAction('${dataBean.seq}'); return false;"/>
            </sm:button-layout>
        </div>
    </div>
</div>