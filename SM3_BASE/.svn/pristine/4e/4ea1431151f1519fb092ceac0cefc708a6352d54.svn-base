(function( factory ) {
    if ( typeof define === "function" && define.amd ) {
        define( ["jquery", "jquery.validate"], factory );
    } else {
        factory( jQuery );
    }
}(function( $ ) {

/*
 * Translated default messages for the jQuery validation plugin.
 * Locale: KO (Korean; 한국어)
 */
$.extend($.validator.messages, {
    required: "필수 항목입니다.",
    remote: "항목을 수정하세요.",
    email: "유효하지 않은 E-Mail주소입니다.",
    url: "유효하지 않은 URL입니다.",
    date: "올바른 날짜를 입력하세요.",
    dateISO: "올바른 날짜(ISO)를 입력하세요.",
    number: "유효한 숫자가 아닙니다.",
    digits: "숫자만 입력 가능합니다.",
    creditcard: "신용카드 번호가 바르지 않습니다.",
    equalTo: "같은 값을 다시 입력하세요.",
    extension: "올바른 확장자가 아닙니다.",
    maxlength: $.validator.format("{0}자를 넘을 수 없습니다."),
    minlength: $.validator.format("{0}자 이상 입력하세요."),
    rangelength: $.validator.format("문자 길이가 {0} 에서 {1} 사이의 값을 입력하세요."),
    range: $.validator.format("{0} 에서 {1} 사이의 값을 입력하세요."),
    max: $.validator.format("{0} 이하의 값을 입력하세요."),
    min: $.validator.format("{0} 이상의 값을 입력하세요.")
});

/* UTF-8 한글 3byte 계산 */
$.validator.addMethod("maxword", function(value, element, param) {

    var fChar = value.match(/[^ㄱ-힣]/gi);
    var fLength = fChar != null ? fChar.length : 0;
    
    var lChar = value.match(/[ㄱ-힣]/g);
    var lLength = lChar != null ? lChar.length : 0;

    var total = fLength + (lLength * 3);

    return total <= param;
    
}, $.validator.format("{0} byte를 넘을 수 없습니다. (한글 3byte)"));

$.validator.addMethod("alphabetic", function(value, element) {
    return this.optional(element) || /^[a-zA-Z]+$/i.test(value) || value == $(element).attr("placeholder");
}, "영문자만 입력하세요.");

$.validator.addMethod("alphalower", function(value, element) {
    return this.optional(element) || /^[a-z]+$/.test(value) || value == $(element).attr("placeholder");
}, "영소문자만 입력하세요.");

$.validator.addMethod("alphaupper", function(value, element) {
    return this.optional(element) || /^[A-Z]+$/.test(value) || value == $(element).attr("placeholder");
}, "영대문자만 입력하세요.");

$.validator.addMethod("alphanumeric", function(value, element) {
    return this.optional(element) || /^[a-zA-Z\d]+$/.test(value) || value == $(element).attr("placeholder");
}, "영문자 또는 숫자만 입력하세요.");

$.validator.addMethod("codevalue", function(value, element) {
    return this.optional(element) || /^[_a-zA-Z\d]+$/.test(value) || value == $(element).attr("placeholder");
}, "영문자 또는 숫자, 언더바('_')만 입력하세요.");

$.validator.addMethod("phone", function(value, element) {
    return this.optional(element) || /^[\-?\d]+$/.test(value) || value == $(element).attr("placeholder");
}, "숫자, 대시('-')만 입력하세요.");

$.validator.addMethod("nowhitespace", function(value, element) {
    return this.optional(element) || /^\S+$/i.test(value) || value == $(element).attr("placeholder");
}, "공백문자는 입력할 수 없습니다.");

$.validator.addMethod("directory", function(value, element) {
    return this.optional(element) || /^[\/?a-z]+$/.test(value) || value == $(element).attr("placeholder");
}, "영문 또는 슬래시('/')만 입력하세요.");

$.validator.addMethod("telephone", function(value, element) {
    return this.optional(element) || /^(02|0[3-9]{1}[0-9]{1,2})-[0-9]{3,4}-[0-9]{4}$/.test(value) || value == $(element).attr("placeholder");
}, "[02-111-2222] 형식으로 입력하세요.");

$.validator.addMethod("mobile", function(value, element) {
    return this.optional(element) || /^(01[016789]{1})-[0-9]{3,4}-[0-9]{4}$/.test(value) || value == $(element).attr("placeholder");
}, "[010-1111-2222] 형식으로 입력하세요.");

$.validator.addMethod("zipcode", function(value, element) {
    return this.optional(element) || /^\d{3}-\d{3}$/.test(value) || value == $(element).attr("placeholder");
}, "[000-111] 형식으로 입력하세요.");

/* Set error placement */
jQuery.validator.setDefaults({
    errorPlacement: function(error, element) {
        var elem = $(element);
        if (!error.is(":empty")) {
            elem.filter(":not(.valid)").qtip({
                content: error,
                position: {
                    my: "bottom right",
                    at: "top right",
                    adjust: {
                        x: 2
                    }
                },
                show: {
                    event: "focus",
                    ready: true
                },
                hide: {
                    event: "blur unfocus mouseleave"
                },
                style: {
                    classes: "qtip-red"
                }
            })
            .qtip("option", "content.text", error);
        }
        else { elem.qtip("destroy"); }
    },
    success: function(error, placement) {
        $(".qtip-active:visible").fadeOut("fast");
    }
});

}));

