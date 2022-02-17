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
            
            document.listForm.elements["seq"].value = seq;
            document.listForm.action= "NR_view.do";
            document.listForm.submit();
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
        getSearchCondition: function() {
            
            var formArray = $("form[name=listForm]").serializeArray();
            var condition = {};
            $.each(formArray,
                function(i, v) {
                    condition[v.name] = v.value;
                }
            );
            return condition;
        },
        /*-------------------------------------
         * 등록 폼
         -------------------------------------*/
        insertForm: function(bbsCd) {
            self.location.href = "NR_form.do";
        },
        /*-------------------------------------
         * 수정 폼
         -------------------------------------*/
        updateForm: function(seq) {
            document.listForm.elements["seq"].value = seq;
            document.listForm.action= "NR_form.do";
            document.listForm.submit();
        },
        /*-------------------------------------
         * 삭제 액션
         -------------------------------------*/
        deleteOneAction: function(e, seq) {
            if ( confirm("정말 삭제하시겠습니까?") ) {
                SM.submit(null, {
                    url: "TR_deleteAction.do",
                    data: {
                        seqs: [seq],
                        CSRFToken: $("#listForm input[name=CSRFToken]").val()
                    }
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        FAQ.list();
                    }
                });
            }
        }
    };

})(jQuery);