/*
 * input[type=text], textarea의 단어 수 카운팅
 * 하단 Author에 표시된 2개의 오픈소스를 조합해서 수정함 2013-09-25
 * 
 * 사용 예:
 * <script type="text/javascript" src="/resources/spi/jquery/wordcount/jquery.wordcount.js"></script>
 * $(".wc").wordcount({
 *     kr_length: 3 || 2,
 *     type: "word" || "byte"
 * });
 * 
 * <input type="text" class="wc" data-wc="[입력제한_글자수]" .... />
 * <textarea class="wc" data-wc="[입력제한_글자수]" ....></textarea>
 * 
 * Author :
 * https://github.com/ethdemor/mOer-js/blob/master/jQuery/wordcount/jquery-wordcount.js
 * http://www.zurb.com/playground/jquery-text-change-custom-event
 */
(function ($, undefined) {
    
    $.fn.wordcount = function (options) {
        return this.each(function(index) {
            var opts = $.extend({}, $.fn.wordcount.defaults, options);
            opts.target = $(this);
            opts.limit = opts.target.attr("data-wc");

            if ( opts.limit ) {

                opts.id = opts.target.attr("id");
                opts.countElement = $("#" + opts.id + "_wc");
                
                $(this).bind('textchange', function (event, previousText) {
                    check(opts, previousText);
                });
                
                // check(opts, null);
            }
        });
    };

    $.fn.wordcount.defaults = {
        kr_length: 3,   // 한글 바이트 계산값 (3 or 2)
        type: "byte",   // 글자 수(word) 또는 바이트(byte)
        inverse: false  // 제한 글자 수 음수로 표시 여부 (true면 음수, false면 증가시킴)
    };
    
    function check(opts, previousText) {
        var total = 0;
        if (opts.type === "byte"){
            total = match(opts.target, /[^ㄱ-힣]/gi) + (match(opts.target, /[ㄱ-힣]/g) * opts.kr_length);
        }
        else{
            total = opts.target.val().length + match(opts.target, /\r\n/g);
        } 
        
        /*--
        if (opts.limit > 0 && total > opts.limit) {
            opts.target.val(previousText);
            return;
        }
        else {
            if (opts.countElement) {
                opts.countElement.text(opts.inverse ? opts.limit-total : total);
            }
        } --*/
        
        if (opts.countElement) {
            opts.countElement.text(opts.inverse ? opts.limit-total : total);
            
            if (opts.limit > 0 && total > opts.limit) opts.countElement.css("color", "red");
            else opts.countElement.css("color", "black");
        }
    }

    function match($target, pattern) {
        var inputStr = $target.val();
        var matchedChar = inputStr.match(pattern);
        return matchedChar != null ? matchedChar.length : 0;
    }
    
    $.event.special.textchange = {
            
        setup: function (data, namespaces) {
            $(this).data('lastValue', this.contentEditable === 'true' ? $(this).html() : $(this).val());
            $(this).bind('keyup.textchange', $.event.special.textchange.handler);
            $(this).bind('cut.textchange paste.textchange input.textchange', $.event.special.textchange.delayedHandler);
        },
        
        teardown: function (namespaces) {
            $(this).unbind('.textchange');
        },
        
        handler: function (event) {
            $.event.special.textchange.triggerIfChanged($(this));
        },
        
        delayedHandler: function (event) {
            var element = $(this);
            setTimeout(function () {
                $.event.special.textchange.triggerIfChanged(element);
            }, 25);
        },
        
        triggerIfChanged: function (element) {
            var current = element[0].contentEditable === 'true' ? element.html() : element.val();
            if (current !== element.data('lastValue')) {
                element.trigger('textchange',  [element.data('lastValue')]);
                element.data('lastValue', current);
            }
        }
    };
    
    /*--
    $.event.special.hastext = {
        
        setup: function (data, namespaces) {
            $(this).bind('textchange', $.event.special.hastext.handler);
        },
        
        teardown: function (namespaces) {
            $(this).unbind('textchange', $.event.special.hastext.handler);
        },
        
        handler: function (event, lastValue) {
            if ((lastValue === '') && lastValue !== $(this).val()) {
                $(this).trigger('hastext');
            }
        }
    };
    
    $.event.special.notext = {
        
        setup: function (data, namespaces) {
            $(this).bind('textchange', $.event.special.notext.handler);
        },
        
        teardown: function (namespaces) {
            $(this).unbind('textchange', $.event.special.notext.handler);
        },
        
        handler: function (event, lastValue) {
            if ($(this).val() === '' && $(this).val() !== lastValue) {
                $(this).trigger('notext');
            }
        }
    }; --*/
})(jQuery);