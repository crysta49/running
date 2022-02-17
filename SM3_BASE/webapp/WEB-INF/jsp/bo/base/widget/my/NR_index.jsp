<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<html>
<head>
    <title>초기화면 설정</title> 
    <style type="text/css">
        .widget, .dWidget {
            padding: 6px;
            border: 1px solid #E6E6E6;
            margin-bottom: 3px;
            cursor: move;
        }
        .wContainer {
            height: 90px;
            width: 47%;
            padding: 8px;
            border: 1px solid #E6E6E6;
        }
        .dWidget {
            background-color: #FCFCFC;
        }
        .active-widget { border: 2px solid #FDDBD4; }
        .hover-widget { border: 2px solid #F63832; }
    </style>
</head>
 
<body>

<form:form id="csrfForm" name="csrfForm"></form:form>

<fieldset>
    <legend>초기화면 설정</legend>
    <ul class="bullet">
        <li>초기화면에 표시되는 정보 위젯을 취향에 맞게 개인화 할 수 있습니다..</li>
        <li>좌측 설정가능 위젯목록에서 위젯을 선택해 각 표시영역으로 드래그 앤 드랍(Drag &amp; Drop) 하시면 됩니다. (각 표시영역당 <span class="emphasis">3</span>개까지 가능)</li>
        <li>표시영역에 등록된 위젯 항목을 위 아래로 옮겨서 표시 순서를 변경할 수 있습니다.</li>
    </ul>
</fieldset>

<div class="blank"></div>

<div class="smd-box">
    
    <div class="smd-tree-box">
        <div id="treeDiv" class="no-border" style="width: 190px;">
            <table class="tbl-header">
                <tr>
                    <th>
                        <span class="title-big">사용가능 위젯목록</span>
                    </th>
                </tr>
            </table>
            <div style="height: 465px; overflow: auto;">
                <c:forEach items="${dataList}" var="item">
                    <div id="${item.seq}" class="widget">${item.widgetNm}</div>
                </c:forEach>
                <c:if test="${empty dataList}">
                    <div class="smd-box"><span class="t3-exclamation text-warning">위젯 정보가 없습니다.</span></div>
                </c:if>
            </div>
        </div>
        <div id="viewDiv" style="margin-left: 210px;">
            <div>
                <table class="tbl-header">
                    <tr>
                        <th>
                            <span class="title-big">위젯 표시영역 1</span>
                        </th>
                        <td class="tr">영역별 <span class="emphasis">3</span>개 까지 지정가능</td>
                    </tr>
                </table>
                <div class="smd-box">
                    <div id="TOP1" class="wContainer fr"></div>
                    <div id="TOP2" class="wContainer"></div>
                </div>
            </div>
            <div style="margin-top:14px;">
                <table class="tbl-header">
                    <tr>
                        <th>
                            <span class="title-big">위젯 표시영역 2</span>
                        </th>
                        <td class="tr">영역별 <span class="emphasis">3</span>개 까지 지정가능</td>
                    </tr>
                </table>
                <div class="smd-box">
                    <div id="MID1" class="wContainer fr"></div>
                    <div id="MID2" class="wContainer"></div>
                </div>
            </div>
            <div style="margin-top:14px;">
                <table class="tbl-header">
                    <tr>
                        <th>
                            <span class="title-big">위젯 표시영역 3</span>
                        </th>
                        <td class="tr">영역별 <span class="emphasis">3</span>개 까지 지정가능</td>
                    </tr>
                </table>
                <div class="smd-box">
                    <div id="BOT1" class="wContainer fr"></div>
                    <div id="BOT2" class="wContainer"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<sm:button-layout>
    <sm:button id="btnPreview" icon="b3-tick" value="미리보기" onclick="js_previewPop(); "/>
    <sm:button id="btnSave" icon="b3-db-save" value="저장" onclick="js_insertAction(this);" />
</sm:button-layout>

<sm:js names="smdnd" />
<script type="text/javascript">

    Ext.onReady(function() {
        
        $(".wContainer").sortable({
            containment: "parent",
            stop: function(ev, ui) {
                
            }
        }).disableSelection();
        
        $(".widget").draggable({
            revert: true, 
            scroll: false,
            helper: "clone",
            appendTo: "body",
            containment: "window"
        });
        
        $(".wContainer").droppable({
            accept : ".widget",
            activeClass: "active-widget", 
            hoverClass: "hover-widget",
            drop: function(ev, ui) {
                
                var id = $(ui.draggable).attr("id");
                
                if ( $("#__" + id).size() != 0 ) {
                    alert("이미 추가된 위젯입니다."); return false;
                }
                
                /*--
                var exist = $("#__" + id, $(this)).size() != 0;
                if ( exist ) return false;
                --*/
                
                var childSize = $(this).children().length;
                if ( childSize >= 3 ) {
                    alert("표시영역당 최대 3개까지만 지정할 수 있습니다."); return false;
                }
                
                $(this).append("<div id='__" + id + "' class='dWidget'><a href='#' class='removal fr'><span class='t3-delete'>삭제</span></a>" + 
                        $(ui.draggable).html() + "</div>")
                .find("div.dWidget:last").fadeIn(400).find("a")
                .bind("click", function(){
                    $(this.parentNode).slideUp(
                        "fast", function() {
                            $(this).remove();
                        }
                    );
                    return false;
                });
            }
        });
        
        <c:forEach items="${myAssignMap}" var="item">
            <c:forEach items="${myAssignMap[item.key]}" var="bean">
                $("#${item.key}").append("<div id='__${bean.seq}' class='dWidget'><a href='#' class='removal fr'><span class='t3-delete'>삭제</span></a>" + 
                        "${bean.widgetNm}</div>")
                .find("div.dWidget:last").fadeIn(400).find("a")
                .bind("click", function(){
                    $(this.parentNode).slideUp(
                        "fast", function() {
                            $(this).remove();
                        }
                    );
                    return false;
                });
            </c:forEach>
        </c:forEach>
    });
    
    var js_previewPop = function() {

        SM.modal({
            title: "초기화면 미리보기",
            width: 1024,
            height: 700,
            popup: true,
            popupId: "_wpp_",
            loadUrl: "PR_preview.do?values=" + js_getWidgetValues()
        });
    };
    
    var js_insertAction = function(e) {
        
        SM.submit(e, {
            url: "TR_insertAction.do",
            data: { 
                values: js_getWidgetValues(),
                CSRFToken: $("#csrfForm input[name=CSRFToken]").val()
            }
        }, 
        function(messages, xhr) {
            if (messages.code == 200) {
                self.location.reload();
            }
        });
    };
    
    var js_getWidgetValues = function() {
        var idx = 0;
        var values = new Array();
        $.each(["TOP1", "TOP2", "MID1", "MID2", "BOT1", "BOT2"], function(i, value) {
            $("#" + value + " > .dWidget").each(function(j) {
                values[idx++] = value + "|" + $(this).attr("id") + "|" + (j+1);
            });
        });
        return values;
    };
    
</script>

</body>
</html>