<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/functions' prefix='fn' %>

<html>
<head>
    <title></title>
    
    <script type='text/javascript'>
    $().ready(function() {
    	
        $("#rrn1").keyup(function() {
            if (this.value.length == 6) $("#rrn2").focus();
        });
        
        $('#ipin').hide();
        
        $('.cont > ul > li:first-child').click( function() {
        	$('#ipin').hide();
        	$('#realname').show();
        });
        $('.cont > ul > li:last-child').click( function() {
        	$('#realname').hide();
        	$('#ipin').show();
        });
    });
    
    window.name ="Parent_window";
    
    var jsRealnamePopup = function() {
        if ( jsIsAgree() ) {
            alert("기존에 사용하는 인증 시스템에 따라 적용될 예정입니다.");
        }
    };
    
    var jsIpinPopup = function() {
        if ( jsIsAgree() ) {
            alert("기존에 사용하는 인증 시스템에 따라 적용될 예정입니다.");
        }
    };
    
    var jsIsAgree = function() {
    	if ( !$("input[name=cbAgree]").is(':checked') ) {
    	    alert("먼저 개인정보수집에 동의하셔야 합니다."); 
    	    $('#cbAgree').focus();
    	    return false;
    	}
    	return true;
    };
    
    var jsTestLogin = function() {
        $.post('<c:url value="/fe2/login/NR_testLogin.do"/>', {
            userKey: $('#userId').val()
        }, function() {
            jsRedirectAfterLogin();
        });
    };
    
    var jsRedirectAfterLogin = function() {
        if ('${param.returnUrl}' == '') {
            self.location.href = '<c:url value="/fe2/main/NR_index.do"/>';
        }
        else {
            self.location.href = '${param.returnUrl}';
        }
    };
    </script>
</head>
<body>
    <input type='text' name='userId' id='userId' value='sasha'/>
    <input type='button' value='테스트 사용자 로그인' onclick='jsTestLogin(); return false;' style='height: 24px;'/>
    
    <!--본인실명인증-->
    <div id="certi">
        <ul class="info_top">
            <li>저희 기업은 상담 등의 글을 작성 시 본인확인 절차를 받고 있습니다.</li>
            <li>입력하신 개인 정보는 고객님의 동의 없이 제 3자에게 제공되지 않으며, <span class="blue">개인정보취급지침</span>에 따라 보호되고 있습니다.</li>
            <li class="red">※ 저희 기업에서는 실명인증을 위해 주민등록번호를 입력받고있으나, 별도 저장하지 않습니다.</li>
        </ul>
        
        <h3 class="stit">개인정보 수집,이용 및 제공동의서 
            <span>
                <a href="#" onclick="return false;" title="개인정보취급방침바로가기 새창으로">
                    <img src="<c:url value="/resources/front/FE2/images/certi/bt_certimore.gif"/>" alt="개인정보취급방침바로가기" />
                </a>
            </span>
        </h3>
        <div class="info_box">
            <p class="tit">개인정보의 수집.이용목적</p>
            - 작성내용에 따른 본인식별, 실명확인<br />
            - 민원처리 의사소통 경로 확보<br />
            - 기타 원활한 양질의 서비스 제공 등
            <p class="tit">수집하는 개인정보의 항목</p>
            - 성명, 전화번호, 휴대폰번호, 이메일 그 외 입력내용<br />
            <p class="tit">개인정보의 보유 및 이용기간</p>
            - 개인정보의 수집 또는 제공받은 목적 달성 시 및 작성자 요청 시 원칙적으로 파기<br />
            - 작성자의 내용 재 확인을 위해 다른 삭제 요청이 없을 시 일정기간 보존<br />
            ※ 고객은 개인정보 수집에 대해 동의하지 않을 권리가 있으며, 동의하지 않을 경우에는 일부 콘텐츠 이용제한 및 상담신청  등이 거부될 수 있습니다. 
        </div>
        <p class="certi_check"><input type="checkbox" name="cbAgree" id="cbAgree" />&nbsp;<label for="cbAgree">개인정보 수집,이용 및 제공동의서에 동의합니다.</label></p>
        
        <!--실명인증-->
        <div class="cont" id="realname">
            <ul class="certi_tab">
                <li class="cl"><a href="#" onclick="return false;"><img src="<c:url value="/resources/front/FE2/images/certi/tab01_on.gif"/>" alt="실명인증" /></a></li>
                <li class="cl"><a href="#" onclick="return false;"><img src="<c:url value="/resources/front/FE2/images/certi/tab02.gif"/>" alt="아이핀인증" /></a></li>
            </ul>
            
            <div class="contbox">
                <h3 class="hide">실명인증</h3>
                <ul>
                    <li class="red">입력하신 주민등록번호는 신용평가기관에 본인확인용으로 제공되며, 완료 후 이름만 저장 됩니다.</li>
                    <li>타인의 주민등록번호를 부정하게 사용하는 경우 3년 이하의 징역 또는 1천만 원 이하의 벌금에 처해지게 됩니다.</li> 
                    <li>정상적인 주민등록번호를 입력 했으나 실명확인에 문제가 있는 경우, 기업의 홈페이지를 참고해 주시기 바랍니다.</li> 
                </ul>
                
                <div class="cont">실명인증을 통한 본인확인을 원하시면, "실명인증하기" 버튼을 눌러 본인확인을 진행해 주십시오.</div>
                
                <p class="cbt"><a href="#" onclick="jsRealnamePopup(); return false;" title="새창"><img src="<c:url value="/resources/front/FE2/images/certi/bt_namecerti.gif"/>" alt="실명인증하기" /></a></p>
            </div>
            
        </div>
               
        <!-- I-PIN -->
        <div class="cont" id="ipin">
            <ul class="certi_tab">
                <li class="cl"><a href="#" onclick="return false;"><img src="<c:url value="/resources/front/FE2/images/certi/tab01.gif"/>" alt="실명인증" /></a></li>
                <li class="cl"><a href="#" onclick="return false;"><img src="<c:url value="/resources/front/FE2/images/certi/tab02_on.gif"/>" alt="아이핀인증" /></a></li>
            </ul>
            
            <div class="contbox">
                <h3 class="hide">아이핀인증</h3>
                <div class="cont">아이핀(I-PIN)인증을 통한 본인확인을 원하시면, "아이핀(I-PIN) 인증" 버튼을 눌러 본인확인을 진행해 주십시오.</div>
                
                <p class="cbt"><a href="#" onclick="jsIpinPopup(); return false;" title="새창"><img src="<c:url value="/resources/front/FE2/images/certi/bt_ipin.gif"/>" alt="아이핀인증하기" /></a></p>
            </div>
        </div>
        <!--//실명인증-->
        
        <div class="ars_call_sub">
            <dl>
                <dt class="sub_ars_tit">ARS 콜센터 안내</dt>
                <dd><p class="sub_ars_stit">일반문의</p> 1588-0000</dd>
                <dd><p class="sub_ars_stit">기업고객전용</p> 1588-0001</dd>
                <dd class="time">평일 09:00~18:00<br />
                    점심 12:00~13:00
                </dd>
            </dl>
        </div>
 
    </div>
    <!--//본인실명인증-->

</body>
</html>