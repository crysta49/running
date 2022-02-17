<%@ page contentType="text/html;charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>


<div class="panel-body panel-env">
    <fieldset>
        <legend>변경된 정보 시스템 반영 (캐시정보 다시읽기) 안내</legend>
        <div>
            <span class="text-info">정보가 변경되었을 경우에는 캐시정보를 다시 읽어야 시스템에 변경된 정보가 반영됩니다.</span>&nbsp;
            <sm:button value="다시 읽기" btnSize="btn-xs" cssClass="btn-warning" glyph="repeat" onclick="js_cacheReloadAction(this);"/>&nbsp;
            <span id="reloadDt" class="text-danger"></span>
        </div>
    </fieldset>
</div>

<script type="text/javascript">

    var js_cacheReloadAction = function(e) {
        
        // 게시판 설정은 변경 후 메뉴관리로 이동하기 위해 제외
        if ( "${cacheClass}" != "BbsConfCache" ) {
            
            if ( confirm("변경된 정보를 시스템 전체에 반영하기 위해 캐시정보를 다시 읽으시겠습니까?") ) {
                SM.submit(e, {
                    url: CTX_PATH + "/bo/base/cache/TR_reloadAction.do",
                    data: { 
                        id: "${cacheClass}",
                        CSRFToken: $("#csrfForm input[name=CSRFToken]").val()
                    }
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        $("#reloadDt").html( new Date().toLocaleString() + "에 다시 읽음");
                    }
                });
            }
        }
    };
</script>