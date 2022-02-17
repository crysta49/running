<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<%-- <c:set var="mgrSession" value="${sessionScope[CONSTANT.MGR_SESSION_KEY]}" /> --%>
<sm:static var="BBS_CONF_UTIL" clazz="com.srpost.cm.bo.base.bbs.conf.BbsConfUtil"/>

<html>
<head>
    <title>${CONSTANT.SYSTEM_NM}</title>
    <%-- <link rel="stylesheet" href="<c:url value="/resources/spi/jquery/jqcloud/jqcloud.min.css"/>" /> --%>
</head>

<body>

<div class="row ds-notice">
    <div class="col-xs-2 ds-notice-01">
    </div>
</div>

<div class="row ds-top">
    <div class="col-xs-3 ds-tleft">
        <div class="ds-tleft-ct">
            
            <div class="title">새글 등록 현황</div>
            <table class="tbl-view" id="totCount">
                <tr>
                    <th><a href="<c:url value="/bo/base/bbs/core/NR_index.do?bbsCd=1"/>">${recentBbsCount.bbsCd_1.BBSNM}</a></th>
                    <td>${recentBbsCount.bbsCd_1.CNT}</td>
                </tr>
                <tr>
                    <th><a href="<c:url value="/bo/base/bbs/core/NR_index.do?bbsCd=2"/>">${recentBbsCount.bbsCd_2.BBSNM}</a></th>
                    <td>${recentBbsCount.bbsCd_2.CNT}</td>
                </tr>
                <tr>
                    <th><a href="<c:url value="/bo/base/bbs/core/NR_index.do?bbsCd=3"/>">${recentBbsCount.bbsCd_3.BBSNM}</a></th>
                    <td>${recentBbsCount.bbsCd_3.CNT}</td>
                </tr>
            </table>
            
            <div class="blank-2x"></div>
            
            <div class="title">질문답변 게시판 현황</div>
            <div class="row ds-tleft-ct-01">
                <div class="col-xs-4">
                    <a href="<c:url value="/bo/base/bbs/core/NR_index.do?bbsCd=3&statusCd=${BBS_CONF_UTIL.RECEIVE}"/>">
                        <div class="tleft-ct-img01"></div>
                        <div class="tleft-ct-tit">접수</div>
                        <div id="noReceiveCnt" class="f-serif f-bold f-19 cnt">${qnaStatusCount[BBS_CONF_UTIL.RECEIVE].CNT}</div>
                    </a>
                </div>
                <div class="col-xs-4">
                    <a href="<c:url value="/bo/base/bbs/core/NR_index.do?bbsCd=3&statusCd=${BBS_CONF_UTIL.WORKING}"/>">
                        <div class="tleft-ct-img02"></div>
                        <div class="tleft-ct-tit">처리중</div>
                        <div id="dealingCnt" class="f-serif f-bold f-19 cnt">${qnaStatusCount[BBS_CONF_UTIL.WORKING].CNT}</div>
                    </a>
                </div>
                <div class="col-xs-4">
                    <a href="<c:url value="/bo/base/bbs/core/NR_index.do?bbsCd=3&statusCd=${BBS_CONF_UTIL.COMPLETE}"/>">
                        <div class="tleft-ct-img03"></div>
                        <div class="tleft-ct-tit">처리완료</div>
                        <div id="completeCnt" class="f-serif f-bold f-19 cnt">${qnaStatusCount[BBS_CONF_UTIL.COMPLETE].CNT}</div>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xs-9 ds-tcenter">
        <div class="ds-tcenter-ct">
            <div class="ds-tcenter-ct-01">
                <ul class="nav nav-tabs nav-justified" id="statusCtg">
                    <li class="active"><a href="#" onclick="js_bbsList(1)">공지사항</a></li>
                    <li><a href="#" onclick="js_bbsList(2)">자료실</a></li>
                    <li><a href="#" onclick="js_bbsList(3)">질문답변</a></li>
                </ul>
            </div>
            <div id="statusView" class="status">
                <%-- ajax load --%>
            </div>
        </div>
    </div>
</div>


<div class="blank-2x"></div>

<div class="row">
    <div class="col-xs-9 ds-mid">
        
    </div>
    <div class="col-xs-6" style="margin-top: 15px; padding-left: 20px;">
        <div class="row">
            <div class="col-xs-8 s-title f-bold f-15">최근 등록 FAQ</div>
            <div class="col-xs-4 text-right more f-11"><a href="<c:url value="/bo/base/faq/core/NR_index.do"/>">더보기 &nbsp;<i class="glyphicon glyphicon-plus"></i></a></div>
        </div>
        <div class="sr-short-list">
            <ul id="faqList">
            </ul>
        </div>
        <hr/>
    </div>
    <div class="col-xs-6" style="margin-top: 15px; padding-left: 20px;">
        <div class="row">
            <div class="col-xs-8 s-title f-bold f-15">자료실</div>
            <div class="col-xs-4 text-right more f-11"><a href="<c:url value="/bo/base/bbs/core/NR_index.do?bbsCd=2"/>">더보기 &nbsp;<i class="glyphicon glyphicon-plus"></i></a></div>
        </div>
        <div class="sr-short-list">
            <c:forEach items="${bbsList}" var="item">
            <div class="row">
                <div class="col-xs-10 text-overflow"><b>ㆍ</b> <a href="<c:url value="/bo/base/bbs/core/NR_view.do?bbsCd=${item.bbsCd}&bbsSeq=${item.bbsSeq}"/>" title="${item.title}">${item.title}</a></div>
                <div class="col-xs-2 text-right">
                    <%-- <c:if test="${not empty item.fileList}">
                        <a href="<c:url value="/common/file/download.do?id=${item.fileList[0].fileId}"/>" title="${item.fileList[0].orgFileNm}"><i class="glyphicon glyphicon-download-alt"></i></a>
                    </c:if> --%>
                     <c:forEach items="${item.fileList}" var="_file">
                        <a href="<c:url value="/common/file/NR_download.do?id=${_file.fileId}"/>" title="${_file.orgFileNm}"><i class="glyphicon glyphicon-download-alt"></i></a>
                     </c:forEach>
                </div>
            </div>
            </c:forEach>
            <c:if test="${empty bbsList}">
                <div class="row">
                    <div class="col-xs-10 text-overflow"><b>ㆍ</b> 등록된 자료가 없습니다.</div>
                </div>
            </c:if>
        </div>
        <hr/>
    </div>
</div>

<%--
${CONSTANT.CLIENT_NM} ${CONSTANT.SYSTEM_NM}, ${CONSTANT.APP_NAME} version ${CONSTANT.APP_VERSION} (Build ${CONSTANT.APP_BUILD})
<hr/>

<hr/>

<h3>${mgrSession.mgrId}</h3>
<h3>${mgrSession.deptNm}/${mgrSession.mgrNm}</h3>
<h3>${mgrSession.loginDt}</h3>

--%>

<script type="text/javascript" src="<c:url value="/resources/spi/jquery/syaku.rolling/jquery.syaku.rolling.js"/>"></script>
<%-- <script type="text/javascript" src="<c:url value="/resources/spi/jquery/jqcloud/jqcloud.min.js"/>"></script> --%>
<sm:js names="validation, highchart" />
<script type="text/javascript">
	$(document).ready(function(){

        js_bbsList(1);

	    $("#ntcRolling").jrolling({ 
	        items: ".rolling", 
	        width: "640px", 
	        height: "25px", 
	        move: "up", 
	        auto: true,
	        delay: 3000
	    });
	    
	    $("#faqList").SM_LOAD(CTX_PATH + "/bo/base/explorer/AR_faqList.do");

        $("#statusCtg li").click(function(){
            $("#statusCtg li").removeClass();
            $(this).addClass("active");
        });
    });

    var js_onlineMenu = function(){    	
    	SM.modal({
            width: 1100, 
            height: 700, 
            popup: true,
            popupId: "_vochelp_",
            loadUrl: CTX_PATH + "/help/index.htm"
        });
    };

    var js_bbsList = function(bbsCd) {
        $("#statusView").SM_LOAD(CTX_PATH + "/bo/base/explorer/AR_bbsList.do?rowPerPage=5&bbsCd=" + bbsCd );
    };
    
</script>

</body>
</html>