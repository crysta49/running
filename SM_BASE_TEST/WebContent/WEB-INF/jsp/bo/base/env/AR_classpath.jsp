<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<div class="panel-body panel-env"> 
    <fieldset>
        <legend>클래스 경로</legend>
        <ul class="bullet" style="margin: 0;">
            <li>시스템에 로드된 클래스 파일의 경로를 조회합니다.</li>
            <li>조회 대상 클래스의 전체 패키지명을 입력하세요.</li>
        </ul>
    </fieldset>
</div>

<div class="panel-body panel-env">
    <fieldset>
        <legend>클래스 경로 검색</legend>
        <div>
            <input type="text" name="clazz" id="clazz" class="smf-text" placeholder="ex) oracle.jdbc.driver.OracleDriver" size="60"/>
            <sm:button value="검색" cssClass="btn-default" glyph="search" onclick="js_findClassAction();"/>
            <div id="jarPathDiv" style="margin-top: 6px;" class="bg-box bg-danger text-danger sr-hidden"></div>
        </div>
    </fieldset>
</div>

<div class="panel-body panel-env">
    <fieldset>
        <legend>로드된 클래스 정보</legend>
        <div class="env-prop-wrap">
            <dl class="dl-horizontal">
                <dt>부트 경로</dt>
                <dd>${dataMap.mxBootPath}</dd>
                <dt>클래스 경로</dt>
                <dd>${dataMap.classPath}</dd>
                <dt>확장 경로</dt>
                <dd>${dataMap.extDirs}</dd>
                <dt>WAS 승인 경로</dt>
                <dd>${dataMap.endorsedDirs}</dd>
                <dt>시스템 라이브러리 경로</dt>
                <dd>${dataMap.libPath}</dd>
                <dt>웹 라이브러리 경로</dt>
                <dd>${dataMap.webappLibDir}</dd>
                <dt>웹 클래스 경로</dt>
                <dd>${dataMap.webappClassesDir}</dd>
            </dl>
        </div>
    </fieldset>
</div>

<script type="text/javascript">
    $(document).ready(function() {

        $("input[name=clazz]").focus();
    });
</script>
        