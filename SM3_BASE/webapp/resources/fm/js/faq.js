/*
 * FAQ 공용 스크립트
 *
 * @author  finkles
 * @date    2015-12-29
 * @since   3.0
 */
 
(function ($) {

    FAQ = {
        /*-------------------------------------
         * 상세조회
         -------------------------------------*/
        view: function(seq) {
            
            $el = $("#viewDivSub_" + seq);
            
            if ( $el.length ) {
                if ( $el.is(":visible") ) {
                    $el.hide();
                }
                else {
                    $el.show();
                }
            }
            else {
                $("#viewDiv_" + seq).SM_LOAD("AR_view.do", {
                    seq: seq
                }, function() {
                    $("#viewDiv_" + seq).attr("tabindex", -1).focus();
                });
            }
        },
        /*-------------------------------------
         * 목록
         -------------------------------------*/
        list: function() {
            document.listForm.action= "NR_index.do";
            document.listForm.submit();
        },
        /*-------------------------------------
         * 페이지 이동
         -------------------------------------*/
        move: function(cpage) {
            document.listForm.elements["currentPage"].value = cpage;
            document.listForm.action= "NR_index.do";
            document.listForm.submit();
        },
        /*-------------------------------------
         * 검색
         -------------------------------------*/
        search: function() {
            if ( $("#searchVal").val() == "" ) {
                alert("검색어를 입력하세요."); $("#searchVal").focus(); return false;
            }
            if ( $("#searchKey").val() == "" ) {
                alert("검색 조건을 선택하세요."); $("#searchKey").focus(); return false;
            }
            document.listForm.action = "NR_index.do";
            document.listForm.elements["currentPage"].value = "0";
            return true;
        },
        /*-------------------------------------
         * 검색
         -------------------------------------*/
        autoSearch: function() {
            document.listForm.elements["currentPage"].value = "0";
            document.listForm.action= "NR_index.do";
            document.listForm.submit();
        },
        /*-------------------------------------
         * 검색 초기화
         -------------------------------------*/
        resetSearch: function() {            
            document.listForm.action = "NR_index.do";
            document.listForm.elements["currentPage"].value = "0";
            document.listForm.elements["ctgCd"].value = "";
            document.listForm.elements["searchKey"].value = "";
            document.listForm.elements["searchVal"].value = "";
            document.listForm.submit();
        },
        /*-------------------------------------
         * 추천 액션
         -------------------------------------*/
        recomAction : function(seq) {
            
            $.post(CTX_PATH + "/bo/base/faq/core/TR_scoreAction.do", {
                seq: seq,
                recomCnt: 1,
                CSRFToken: $("#listForm input[name=CSRFToken]").val()
            }, 
            function(result) {
                var messages = SM.parseMsg(result);
                alert(messages.text);
                if (messages.code == 200) {
                    var el = $("#recom-cnt_" + seq);
                    el.text(parseInt(el.text())+1);
                }
            });
        },
        /*-------------------------------------
         * 비추천 액션
         -------------------------------------*/
        decomAction : function(seq) {
            
            $.post(CTX_PATH + "/bo/base/faq/core/TR_scoreAction.do", {
                seq: seq,
                oppCnt: 1,
                CSRFToken: $("#listForm input[name=CSRFToken]").val()
            }, 
            function(result) {
                var messages = SM.parseMsg(result);
                alert(messages.text);
                if (messages.code == 200) {
                    var el = $("#recom-cnt_" + seq);
                    el.text(parseInt(el.text())-1);
                }
            });
        }
    };

})(jQuery);