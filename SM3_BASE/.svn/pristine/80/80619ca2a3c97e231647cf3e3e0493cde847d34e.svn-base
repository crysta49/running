/*
 * Salmon 공용 스크립트
 *
 * @author  finkles
 * @date    2014-10-14
 * @since   2.0
 */
Ext.Loader.setConfig({enabled: true});

Ext.Loader.setPath("Ext.ux", CTX_PATH + "/resources/spi/extjs/ux/");

(function ($) {

    /*-------------------------------------
     * Ajax 전송 : 글로벌 설정
     -------------------------------------*/

    // 중첩 배열 객체 직렬화를 사용하지 않음
    jQuery.ajaxSettings.traditional = true;
    
    $.ajaxSetup({
        beforeSend: function(xhr) {
            SM.ajaxStart();
        },
        success: function(response) {
        },
        error: function(xhr) {
            SM.ajaxError(xhr);
        },
        complete: function(xhr, status) {
            SM.ajaxDone();
        }
    });
    
    Ext.Ajax.on("beforerequest", function(){
        SM.ajaxStart();
    });
    Ext.Ajax.on("requestcomplete", function(){
        SM.ajaxDone();
    });
    Ext.Ajax.on("requestexception", function(conn, xhr){
        SM.ajaxError(xhr);
    });

    SM = {
        ajaxStart: function() {
            NProgress.start();
        },
        ajaxDone: function() {
            NProgress.done();
        },
        ajaxError: function(xhr) {
            
            var text = SM.crgRtn(xhr.responseText);
            if (text != "") alert(xhr.status + " : " + text);
            
            var statusCode = xhr.status;
            
            /* 페이지 없음 */
            if (statusCode == 404) {                
            }
            /* 권한 없음 */
            else if (statusCode == 401) {                
            }
            /* 대리인 접근 거부 URL */
            else if (statusCode == 406) {                
            }
            /* 로그인 세션 소멸 */
            else if (statusCode == 511) {
                top.location.href = CTX_PATH + "/login";
            }
            /* Server error */
            else if (statusCode == 500) {                
            }
            else {
            }
            
            NProgress.done();
        },
        /*-------------------------------------
         * AJAX 전송 : 폼 서브밋, 버튼 클릭 이벤트
         -------------------------------------*/
        submit: function(e, option, callback) {
            
            var me = this;
            var isClick = true, el, btn;
            var ignoreMsg = option.ignoreMsg || false;

            if (e) {
                /* type을 체크하므로 넘어오는 form에 input[name=type] 값이 있으면 안됨 */
                isClick = e.type ? true : false;
                el = isClick ? $(e) : $(e).find("button[type=submit]");
            }
            
            option = $.extend(true, {
                type: "POST",
                beforeSend: function(xhr) {
                    if (el) SM.showLoad(el);
                    //if (parent.statusBusy) parent.statusBusy();
                },
                success: function(response) {
                    //console.log("success : " + response);
                },
                error: function(xhr) {
                    //console.log("error : " + xhr.readyState + "_" + xhr.status);
                },
                complete: function(xhr) {

                    var messages = me.parseMsg(xhr.responseText);

                    if (messages.code == 200) {
                        if (!ignoreMsg) {
                            alert(messages.text);
                        }
                        //if (parent.statusClear) parent.statusClear();
                    }
                    else {
                        alert(messages.text);
                        //if (parent.statusError) parent.statusError(messages.text);
                    }
                    
                    if (el) SM.hideLoad(el);
                    
                    if (callback) {
                        callback(messages, xhr);
                    }
                }
            }, option);
            
            if (isClick) {
                $.ajax(option);
            }
            else {
                $(e).ajaxSubmit(option);
            }
        },
        /*-------------------------------------
         * 클릭 대상 버튼에  AJAX indicator 표시
         -------------------------------------*/
        showLoad: function(el) {
            //console.log("loading : " + el);
            el.button("loading");
        },
        /*-------------------------------------
         * AJAX indicator 숨김 (기존 버튼 표시)
         -------------------------------------*/
        hideLoad: function(el) {
            //console.log("reset : " + el);
            el.button("reset");
        },        
        /*-------------------------------------
         * 특정 selector 영역에 AJAX indicator 표시
         -------------------------------------*/
        showLoadDiv: function(el) {
            var loadLoader = "<div><span class='t3-loader'>&nbsp;</span></div>";
            $(el).html(loadLoader);
        },
        /*-------------------------------------
         * AJAX indicator 숨김
         -------------------------------------*/
        hideLoadDiv: function(el) {
            $(el).html("");
        },        
        /*-------------------------------------
         * AJAX 처리결과 메시지 파싱
         -------------------------------------*/
        parseMsg: function(msg) {
            
            var me = this;
            // console.log(msg);
            msg = me.cleanHtml(msg);
            
            var message = {};
            
            if ( !isNaN(msg) ) {
                message.code = 500;
                message.text = "처리결과 정보의 형식이 잘못되었습니다.\n\n결과정보 : " + msg;
            }
            else {
                var msgs = msg.split("|");
    
                if (1 == msgs.length) {
                    message.code = 500;
                    message.text = me.crgRtn(msgs[0]);
                }
                else if ( msgs.length == 2 ) {
                    message.code = msgs[0];
                    message.text = me.crgRtn(msgs[1]);
                }
                else if ( msgs.length == 3 ) {
                    message.code = msgs[0];
                    message.text = me.crgRtn(msgs[1]);
                    message.dummy = msgs[2];
                }
                else {
                    message.code = 500;
                    message.text = "처리결과 정보의 형식이 잘못되었습니다.\n\n결과정보 : " + msg;
                }
            }
            return message;
        },
        /*-------------------------------------
         * HTML 제거
         -------------------------------------*/
        cleanHtml: function(msg) {
            if (!msg) return "";
            return msg.replace(/<\/?[^>]+(>|$)/g, "");
        },
        /*-------------------------------------
         * 새 라인 문자를 자바스크립트가 해석할 수 있도록 변환
         -------------------------------------*/
        crgRtn: function(msg) {
            if (!msg) return "";
            return msg.split("\\n").join("\n");
        },
        /*-------------------------------------
         * Override Ext.getCmp
         -------------------------------------*/
        getCmp: function(id) {
            return Ext.getCmp(id);
        },
        /*-------------------------------------
         * 모달 창 띄우기
         -------------------------------------*/
        modal: function(paramOption) {
            var userOption = {
                width: "50%",
                height: "50%",
                y: -1,
                popup: false,
                popupId: "_pop_"
            };
            
            userOption = $.extend(true, userOption, paramOption);
            
            if ( isNaN(userOption.width) && userOption.width.indexOf("%") != -1 ) {
                var _w = parseFloat(userOption.width);
                userOption.width = Ext.getBody().getViewSize().width*(_w*0.01);
            }
            if ( isNaN(userOption.height) && userOption.height.indexOf("%") != -1 ) {
                var _h = parseFloat(userOption.height);
                userOption.height = Ext.getBody().getViewSize().height*(_h*0.01);
            }
            
            if (userOption.popup) {
                var top  = screen.height / 2 - userOption.height / 2 - 50;
                var left = screen.width / 2 - userOption.width / 2 ;
                var pwin = window.open(userOption.loadUrl, userOption.popupId,
                        'width=' + userOption.width + ', height=' + userOption.height + ', top=' + top +
                        ', left=' + left + ', scrollbars=yes, resizable=no, status=yes, toolbar=no, menubar=no');

                if (pwin) pwin.focus();
                
                return pwin;
            }
            else {
                return Ext.create("Ext.Window", {
                    id: "smmodal",
                    title: /* userOption.title || "" */ SYSTEM_NM || "",
                    width: userOption.width,
                    height: userOption.height,
                    layout: "fit",
                    y: userOption.y < 0 ? undefined : userOption.y,
                    plain: true,
                    modal: true,
                    autoShow: true,
                    constrainHeader: true,
                    /*-- items: [Ext.create("Ext.ux.IFrame", {
                        id: "kang",
                        border: false,
                        src: userOption.loadUrl,
                        listeners: {
                        	load: function() {
                                SM.getCmp("smmodal").setLoading(false);
                            }
                        }
                    })], IE8 firing 버그 발생 --*/
                    items: [{
                        xtype: "component",
                        autoEl: {
                            tag: "iframe",
                            frameborder: 0,
                            src : userOption.loadUrl,
                            onload: "SM.getCmp('smmodal').setLoading(false);"
                        }
                    }],
                    listeners: {
                    	show: function(panel, eOpts) {
                            this.setLoading("로딩중...");
                        },
                        close: function(panel, eOpts) {
                            if (userOption.close) {
                                userOption.close(panel);
                            }
                        },
                        destroy: function(panel, eOpts) {
                            if (userOption.destroy) {
                                userOption.destroy(panel);
                            }
                        },
                        move: function(panel) {
                        	// IE9에서 Window move시 iframe 내용 안보이는 버그 처리
                        	if (Ext.isIE9) {
                        		panel.items.getAt(0).el.show();
                        	}
                        }
                    }
                });
            }
        },
        /*-------------------------------------
         * 모달 창 닫기
         -------------------------------------*/
        modalClose: function() {            // 
            // 즉시 창 닫을 경우 output stream close 예외 발생함.
            Ext.Function.defer(function(){
                var me = parent.SM.getCmp("smmodal");
                if (me) me.close();
                else self.close();                
            }, 500);
        },
        /*-------------------------------------
         * POI 기반 : 엑셀 파일 다운로드
         -------------------------------------*/
        xlsDownload: function(url, option, callback) {
            
            var me = this;
            var btn;
            
            var _option = {
                httpMethod: "POST",
                target: $("#indicator")
            };
            
            var _option = $.extend(_option, option);
            if (_option.target) me.showLoadDiv(_option.target);
            if (_option.button) me.showLoad(_option.button);

            $.fileDownload(url, {
                httpMethod: _option.httpMethod,
                data: _option.data,
                successCallback: function (url) {
                    if (_option.target) me.hideLoadDiv(_option.target);
                    if (btn) me.hideLoad(btn);
                    if (callback) callback(true);
                },
                failCallback: function (responseHtml, url) {
                    if (_option.target) me.hideLoadDiv(_option.target);
                    if (_option.button) me.hideLoad(_option.button);
                    if (callback) callback(false);
                    alert("파일을 다운로드 하지 못했습니다.\n\n" + me.cleanHtml(responseHtml));
                }
            });
        },
        /*-------------------------------------
         * 공용 첨부파일 다운로드 로그 팝업
         -------------------------------------*/
        fileLogPop: function(fileSeq, fileId) {
            this.modal({
                title: "파일 다운로드 이력",
                width: 400,
                height: 360,
                y: -1,
                loadUrl: CTX_PATH + "/bo/base/file/PR_fileLogIndex.do?fileSeq=" + fileSeq + "&fileId=" + fileId
            });
        },
        /*-------------------------------------
         * jquery UI tabs reload
         -------------------------------------*/
        reloadTab: function(tabsObj, url) {
            var curIndex = tabsObj.tabs("option", "active");
            var curTabs = $(tabsObj.data("uiTabs").tabs[curIndex]);
            curTabs.find(".ui-tabs-anchor").attr("href", url);
            tabsObj.tabs("load", curIndex);
        },
        /*-------------------------------------
         * 통계 엑셀변환용 : 아이프레임/폼 생성
         -------------------------------------*/
        generateExcelForm: function() {
            
            $("<iframe />", {
                name  : "_hiddenFrame",
                id    : "_hiddenFrame",
                src   : "",
                style : "position: absolute; left: -100px; top: -100px; width:0px; height:0px;"
            }).appendTo("body");
            
            $("<form name='excelForm' action='XR_excel.do' method='post' target='_hiddenFrame' />")
            .appendTo("body")
            .append("<input type=\"hidden\" id=\"xlsStatCd\" name=\"xlsStatCd\" />")
            .append("<input type=\"hidden\" id=\"xlsData\" name=\"xlsData\" />")
            .append("<input type=\"hidden\" id=\"__gexssk__\" name=\"__gexssk__\" value=\"xlsData\" />");
        },
        /*-------------------------------------
         * 에디터 글 표시용 : 아이프레임 생성
         -------------------------------------*/
        generateViewFrame: function(el) {
            var iframe = $('<iframe frameborder="0"></iframe>').css({
                "width": "100%", "height": el.height()
            }).load(function(){
                $(this).contents().find("body").css({ "font-size": "12px" }).html( $("#contents-desc", el).html() );
                $(this).height( $(this).contents().height()+20 );
            });
            
            $("#contents-frame", el).append(iframe);
        }
    };
    
    /*-------------------------------------
     * jQuery $.load() 오버라이딩
     * 로드 대상 영역에 AJAX indicator 표시
     -------------------------------------*/
    $.fn.SM_LOAD = function(url, option, callback) {

        return this.each(function() {

            if (option && option.buttonEl)
                SM.showLoad($(option.buttonEl));
            
            SM.showLoadDiv($(this));

            $(this).load(url, option, function(respone, status, xhr) {
                
                if ( status == "error" ) {
                    SM.hideLoadDiv($(this));
                }
                else {
                    if (callback) callback(respone, status, xhr);
                }
                
                if (option && option.buttonEl) 
                    SM.hideLoad($(option.buttonEl));
                
                $(".qtip").remove();
            });
        });
    };
    
    /*-------------------------------------
     * ExtJS 기반 datefield 컴포넌트(날짜 선택) 바인드
     -------------------------------------*/
    $.fn.SM_DATEPICKER = function(option) {
        
        var _option = {
            cls: "smdatepicker",
            format: "Y-m-d",
            editable: false,
            margin: false,
            width: 100
        };
        
        var _option = $.extend(_option, option);
        
        return this.each(function() {
            var el = $(this);
            var elId = el.attr("id");
            var elValue = el.attr("data-value");
            
            _option.id = "__" + elId;
            _option.name = elId;
            _option.value = elValue;
            _option.renderTo = this;
            
            Ext.create("Ext.form.DateField", _option);
        });
    };
    
    $.fn.SM_MONTH_DATEPICKER = function(option) {
    	
    	var _option = {
    		cls: "smdatepicker",
    		format:"Y-m",
    		editable: false,
            margin: false,
    		width: 100
    	};
    	
    	var _option = $.extend(_option, option);
    	
    	 return this.each(function() {
             var el = $(this);
             var elId = el.attr("id");
             var elValue = el.attr("data-value");
             
             _option.id = "__" + elId;
             _option.name = elId;
             _option.value = elValue;
             _option.renderTo = this;
             
             Ext.create('Ext.form.field.Month', _option);
         });
    	 
    };
    
    /*-------------------------------------
     * ExtJS 기반 treecombo 컴포넌트 바인드
     -------------------------------------*/
    $.fn.SM_TREECOMBO = function(option) {
        
        return this.each(function() {
            var el = $(this);
            var elId = el.attr("id");
            var elValue = el.attr("data-value");

            var store;
            if (option.store) {
                store = option.store;
            }
            else {
                store = Ext.create("Ext.data.TreeStore", {
                    proxy: {
                        type: "ajax",
                        url: option.dataListUrl/*,
                        extraParams: option.extraParams || {}*/
                    },
                    root: {
                        expanded: true
                    }/*,
                    nodeParam: option.nodeParam */
                });
            }
            
            Ext.create("Ext.ux.TreePicker", { /* 옵션이 불충분해서 해당 소스 수정함 */
                id: "__" + elId,
                name: elId,
                cls: "smtreecombo",
                store: store,
                displayField: "text",
                value: option.value,
                maxPickerHeight: 200,
                renderTo: this,
                listeners : {
                    select : function(picker, record, eOpts) {
                        if (option.select) option.select(record, picker);
                    }
                }
            });
        });
    };
    
    /*-------------------------------------
     * 1000자리 콤마 찍어 주기 
     -------------------------------------*/
    $.SM_NUM_COMMA = function(number) {
    	
    	 // 숫자일 경우, 문자로 바꾸기.
	   	 var string = number + "";
	   	 
	   	 // ±기호, 소수점, 숫자가 아닌 부분은 지우기.
	   	 string = string.replace( /^\s+|\s+$|,|[^+-\.\d]/g, "" )
	   	 
	   	 //정규식
		 var regExp = /([+-]?\d+)(\d{3})(\.\d+)?/;
	
		 while ( regExp.test( string ) ){
			 string = string.replace( regExp, "$1" + "," + "$2" + "$3" );			 
		 }  
	
		 return string; 
    };
    
    /*-------------------------------------
     * $.browser was deprecated in version 1.3 and removed in 1.9
     * 참고 : http://api.jquery.com/jQuery.browser/
     -------------------------------------*/
    if (!$.browser && $.fn.jquery != "1.3.2") {
        $.extend({
            browser: {}
        });
        $.browser.init = function() {
            var a = {};
            try {
                navigator.vendor ?
                    /Chrome/.test(navigator.userAgent) ?
                    (a.browser = "Chrome", a.version = parseFloat(navigator.userAgent.split("Chrome/")[1].split("Safari")[0])) : /Safari/.test(navigator.userAgent) ? (a.browser = "Safari", a.version = parseFloat(navigator.userAgent.split("Version/")[1].split("Safari")[0])) : /Opera/.test(navigator.userAgent) && (a.Opera = "Safari", a.version = parseFloat(navigator.userAgent.split("Version/")[1])) : /Firefox/.test(navigator.userAgent) ? (a.browser = "mozilla",
                        a.version = parseFloat(navigator.userAgent.split("Firefox/")[1])) : (a.browser = "MSIE", /MSIE/.test(navigator.userAgent) ? a.version = parseFloat(navigator.userAgent.split("MSIE")[1]) : a.version = "edge")
            } catch (e) { a = e; }
            $.browser[a.browser.toLowerCase()] = a.browser.toLowerCase();
            $.browser.browser = a.browser;
            $.browser.version = a.version;
            $.browser.chrome = $.browser.browser.toLowerCase() == 'chrome';
            $.browser.safari = $.browser.browser.toLowerCase() == 'safari';
            $.browser.opera = $.browser.browser.toLowerCase() == 'opera';
            $.browser.msie = $.browser.browser.toLowerCase() == 'msie';
            $.browser.mozilla = $.browser.browser.toLowerCase() == 'mozilla';
        };
        $.browser.init();
    }
    
})(jQuery);