/*
 * BBS 공용 스크립트
 *
 * @author  finkles
 * @date    2015-12-29
 * @since   3.0
 */
 
(function ($) {

    BBS = {
        /*-------------------------------------
         * 상세조회
         -------------------------------------*/
        view: function(bbsSeq) {
            document.listForm.elements["bbsSeq"].value = bbsSeq;
            document.listForm.action= "NR_view.do";
            document.listForm.submit();
        },
        /*-------------------------------------
         * 공지글 상세조회
         -------------------------------------
        ntcView: function(bbsCd, ntcSeq) {
            self.location.href = "NR_ntcView.do?bbsCd=" + bbsCd + "&ntcSeq=" + ntcSeq;
        }, */
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
            self.location.href = "NR_form.do?bbsCd=" + bbsCd;
        },
        /*-------------------------------------
         * 수정 폼
         -------------------------------------*/
        updateForm: function(bbsSeq) {
            document.listForm.elements["bbsSeq"].value = bbsSeq;
            document.listForm.action= "NR_form.do";
            document.listForm.submit();
        },
        /*-------------------------------------
         * 덧글 폼 (계층형)
         -------------------------------------*/
        replyForm: function(bbsSeq) {
            document.listForm.elements["bbsSeq"].value = bbsSeq;
            document.listForm.action= "NR_replyForm.do";
            document.listForm.submit();
        },
        /*-------------------------------------
         * 답변 폼 (답변형)
         -------------------------------------*/
        endReplyForm: function(bbsSeq) {
            document.listForm.elements["bbsSeq"].value = bbsSeq;
            document.listForm.action= "NR_endReplyForm.do";
            document.listForm.submit();
        },
        /*-------------------------------------
         * 삭제 액션
         -------------------------------------*/
        deleteOneAction: function(e, bbsCd, bbsSeq) {
            if ( confirm("정말 삭제하시겠습니까?") ) {
                SM.submit(null, {
                    url: "TR_deleteAction.do",
                    data: {
                        bbsCd: bbsCd, 
                        bbsSeq: bbsSeq,
                        bbsSeqs: [bbsSeq],
                        CSRFToken: $("#listForm input[name=CSRFToken]").val()
                    }
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        BBS.list();
                    }
                });
            }
        },
        /*-------------------------------------
         * 의견글 목록 로드
         -------------------------------------*/
        loadComment: function(bbsCd, bbsSeq) {
            
            $("#cmdListView").SM_LOAD(CTX_PATH + "/bo/base/bbs/comment/AR_list.do", {
                bbsCd: bbsCd,
                bbsSeq: bbsSeq
            });
        },
        /*-------------------------------------
         * 의견글 수정 폼 팝업창
         -------------------------------------*/
        updateCommentFormPop: function(bbsCd, bbsSeq, cmtSeq, hasFile) {
            
            SM.modal({
                width: 600, height: hasFile ? 305 : 260,
                loadUrl: CTX_PATH + "/bo/base/bbs/comment/PR_updateForm.do?bbsCd=" + bbsCd + "&bbsSeq=" + bbsSeq + "&cmtSeq=" + cmtSeq
            });
        },
        /*-------------------------------------
         * 의견글 댓글 폼 팝업창
         -------------------------------------*/
        replyCommentFormPop: function(bbsCd, bbsSeq, cmtSeq, hasFile) {
            
            SM.modal({
                width: 600, height: hasFile ? 440 : 415,
                loadUrl: CTX_PATH + "/bo/base/bbs/comment/PR_replyForm.do?bbsCd=" + bbsCd + "&bbsSeq=" + bbsSeq + "&cmtSeq=" + cmtSeq
            });
        },
        /*-------------------------------------
         * 의견글 삭제 액션
         -------------------------------------*/
        commentDeleteAction: function(bbsCd, bbsSeq, cmtSeq) {
            
            if ( confirm("의견글을 삭제 하시겠습니까?") ) {
                SM.submit(null, {
                    url: CTX_PATH + "/bo/base/bbs/comment/TR_deleteAction.do",
                    data: {
                        bbsCd: bbsCd, 
                        bbsSeq: bbsSeq, 
                        cmtSeq: cmtSeq,
                        CSRFToken: $("#commentForm input[name=CSRFToken]").val()
                    }
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        BBS.loadComment(bbsCd, bbsSeq);
                    }
                });
            }
        }
    };

})(jQuery);