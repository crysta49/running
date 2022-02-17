<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>이용안내</title>
</head>

<body>

<!--이용안내-->
    <div class="guide_cont">
        <!--상단인포-->
        <div class="tinfo">
            <p class="tit">상담 신청 접수 안내</p>
            고객님들의 각종 문의 및 건의 등을 접수할 수 있는 공간으로 광고성 또는 비방용 게시글 등 운영취지와 부합되지 않는<br />
            글들은 관리자에 의하여 삭제될 수 있습니다.
        </div>
        
        <h3 class="tit">문의 사항 해결을 위한 안내</h3>
        <div class="cont">
            <ol class="dialog02">
                <li class="box">
                    <p class="tit">1. 자주하는 질문 이용</p>
                    <p class="cont">자주 문의하시는 사항에 대한<br />
                    답변을 바로 확인 하실 수 있습니다.
                    </p>
                </li>
                <li><img src="<c:url value="/resources/front/FE2/images/customer/dialog_arrow02.gif"/>" alt="다음" /></li>
                <li class="box">
                    <p class="tit">2. 상담 접수 이용</p>
                    <p class="cont">
                    궁금하신 사항을 접수하시면<br />
                    신속하게 답변 드리겠습니다.
                    </p>
                </li>
                <li><img src="<c:url value="/resources/front/FE2/images/customer/dialog_arrow02.gif"/>" alt="다음" /></li>
                <li class="box">
                    <p class="tit">3. ARS 콜 센터 이용</p>
                    <p class="cont">
                   ARS 콜 센터로 연락주시면<br />
                    친절하게 도와드리겠습니다.
                    </p>
                </li>
            </ol>
        </div>
        
        <h3 class="tit">상담신청 처리절차</h3>
        <div class="cont">
            저희 기업은 상담 글이나 제안 등을 등록 시 본인확인 절차를 받고 있습니다.<br />
            입력하신 개인 정보는 고객님의 동의 없이 제 3자에게 제공되지 않으며, 개인정보취급지침에 따라 보호되고 있습니다.<br />
            <ol class="dialog">
                <li class="box"><p class="pdt10">상담등록</p></li>
                <li><img src="<c:url value="/resources/front/FE2/images/customer/dialog_arrow.gif"/>" alt="다음" /></li>
                <li class="box">접수 후<br />담당부서 이관</li>
                <li><img src="<c:url value="/resources/front/FE2/images/customer/dialog_arrow.gif"/>" alt="다음" /></li>
                <li class="box">담당자 확인 후<br />처리</li>
                <li><img src="<c:url value="/resources/front/FE2/images/customer/dialog_arrow.gif"/>" alt="다음" /></li>
                <li class="box">처리 결과 및<br />답변 게시</li>
            </ol>
        </div>
        
        <h3 class="tit">상담신청 처리 기간안내</h3>
        <div class="cont">
            상담신청 처리는 접수일로부터 7영업일 (토, 일요일, 공휴일 제외) 이내에 처리하는 것을 원칙으로 합니다. <br />
            다만, 민원서류의 보완에 소요되는 기간, 민원인의 귀책사유로 지연되는 기간 및 사정이 부득이 하다고 특별히 인정하는<br />
            기간은 처리기간에 산입하지 아니합니다
        </div>
        
    </div>
    <!--//이용안내-->


</body>

</html>