<%@ page contentType="text/html;charset=utf-8" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<c:set var="reqUri" value="${requestScope['javax.servlet.forward.request_uri']}" />
<c:set var="isFront" value="${fn:indexOf(reqUri, '/fe/') != -1 or fn:indexOf(reqUri, '/fe2/') != -1}" />

<c:forEach items="${__items__}" var="item">

    <c:choose>
    
        <c:when test="${item == 'core'}">
            <script type="text/javascript">
                var CTX_PATH = "${pageContext.request.contextPath}";
                var SYSTEM_NM = "${CONSTANT.SYSTEM_NM}";
                if (!window.console){ console = {log: function() {}} };
            </script>
        </c:when>
        
        <c:when test="${item == 'extjs'}">
            <script type="text/javascript" src="<c:url value="/resources/spi/extjs/ext-all.js"/>"></script>
            <script type="text/javascript" src="<c:url value="/resources/spi/extjs/packages/ext-locale/build/ext-locale-ko.js"/>"></script>
            <script type="text/javascript" src="<c:url value="/resources/spi/extjs/packages"/>/ext-theme-${CONSTANT.EXTJS_THEME}/build/ext-theme-${CONSTANT.EXTJS_THEME}.js"></script>
            <script type="text/javascript">
                Ext.onReady(function() {
                    Ext.tip.QuickTipManager.init();
                });
            </script>
        </c:when>
        
        <c:when test="${item == 'jquery'}">
            <script type="text/javascript" src="<c:url value="/resources/spi/jquery/jquery-1.11.1.min.js"/>"></script>
        </c:when>
        
        <c:when test="${item == 'bootstrap'}">
            <script type="text/javascript" src="<c:url value="/resources/spi/bootstrap-3.3.7-dist/js/bootstrap.min.js"/>"></script>
        </c:when>
        
        <c:when test="${item == 'explorer'}">
            <script type="text/javascript" src="<c:url value="/resources/salmon/explorer/Sm.App.js"/>"></script>
            <script type="text/javascript" src="<c:url value="/resources/salmon/explorer/Sm.App.WestPanel.js"/>"></script>
            <script type="text/javascript" src="<c:url value="/resources/salmon/explorer/Sm.App.CenterPanel.js"/>"></script>
        </c:when>

        <c:when test="${item == 'salmon'}">
            <script type="text/javascript" src="<c:url value="/resources/spi/jquery/nprogress/nprogress.js"/>"></script>
            <script type="text/javascript" src="<c:url value="/resources/salmon/jquery.salmon-3.0.js"/>"></script>
        </c:when>

        <c:when test="${item == 'qtip2'}">
            <script type="text/javascript" src="<c:url value="/resources/spi/jquery/qtip2/jquery.qtip.min.js"/>"></script>
        </c:when>
        
        <c:when test="${item == 'validation'}">
            <script type="text/javascript" src="<c:url value="/resources/spi/jquery/validation/jquery.form.min.js"/>"></script>
            <script type="text/javascript" src="<c:url value="/resources/spi/jquery/validation/jquery.validate.min.js"/>"></script>
            <script type="text/javascript" src="<c:url value="/resources/salmon/plugins/jquery.salmon.validate.js"/>"></script>
            <c:if test="${isFront}">
                <script type="text/javascript" src="<c:url value="/resources/front/FE/js/jquery.front.validate.js"/>"></script>
            </c:if>
        </c:when>
        
        <c:when test="${item == 'smtree'}">
            <script type="text/javascript" src="<c:url value="/resources/salmon/plugins/jquery.salmon.tree.js"/>"></script>
        </c:when>
        <c:when test="${item == 'smgrid'}">
            <script type="text/javascript" src="<c:url value="/resources/salmon/plugins/jquery.salmon.grid.js"/>"></script>
        </c:when>
        <c:when test="${item == 'smtab'}">
            <script src="<c:url value="/resources/spi/jquery/ui.tabs/jquery-ui.min.js"/>"></script>
        </c:when>
        <c:when test="${item == 'monthDate'}">
        	<script type="text/javascript" src="<c:url value="/resources/salmon/plugins/jquery.salmon.monthPicker.js"/>"></script>        	
        </c:when>
        <c:when test="${item == 'smdnd'}">
            <script src="<c:url value="/resources/spi/jquery/ui.dnd/jquery-ui.min.js"/>"></script>
        </c:when>
        
        
        <c:when test="${item == 'multifile'}">
            <script type="text/javascript">
                var __MF_ACCEPT_EXTENSION = "${CONSTANT.PERMIT_EXTENSIONS_STRING}".replace(/\, +/g, '|');
                var __MF_MAX_SIZE = ${CONSTANT.MAX_UPLOAD_SIZE}; // KB
            </script>
            <script type="text/javascript" src="<c:url value="/resources/spi/jquery/multifile/jquery.MultiFile.min.js"/>"></script>
        </c:when>
        
        <c:when test="${item == 'syntaxhighlighter'}">
            <script type="text/javascript" src="<c:url value="/resources/spi/syntax-highlighter/Scripts/shCore.js"/>"></script>
            <script type="text/javascript" src="<c:url value="/resources/spi/syntax-highlighter/Scripts/shBrushJava.js"/>"></script>
        </c:when>
        
        <c:when test="${item == 'highchart'}">
            <script src="<c:url value="/resources/spi/highchart/highcharts.js"/>"></script>
            <script src="<c:url value="/resources/spi/highchart/modules/exporting.js"/>"></script>
        </c:when>
        
        <c:when test="${item == 'highlight'}">
            <script type="text/javascript" src="<c:url value="/resources/spi/jquery/highlight/jquery.highlight-4.js"/>"></script>
        </c:when>
        
        <c:when test="${item == 'jsencrypt'}">
            <script type="text/javascript" src="<c:url value="/resources/spi/jquery/JSEncrypt/script.js"/>"></script>
        </c:when>
        
        <c:when test="${item == 'ckeditor'}">
            <script src="<c:url value="/resources/spi/ckeditor/ckeditor.js"/>"></script>
            <script src="<c:url value="/resources/spi/ckeditor/adapters/jquery.js"/>"></script>
            <script type="text/javascript">
                // IE9 이상부터 autogrow 플러그인 사용 시 한글 자음 분리되는 버그 있음. 해당 브라우저에서는 autogrow 미적용 처리함.
                var isGT_IE8 = false;
                if ( $.browser.msie ) {
                    if ( $.browser.version == "edge" || $.browser.version == "10" || $.browser.version == "9" )
                        isGT_IE8 = true;
                }
                var CKEDITOR_CONFIG = {
                    extraPlugins : (isGT_IE8 ? "" : "autogrow"),
                    filebrowserUploadUrl : "<c:url value="/common/file/NR_ckeditorUpload.do" />", 
                    autoGrow_maxHeight : 400,
                    toolbar: [
                        { name: 'document', items: ['Source', '-',  'Preview', 'Maximize'] },
                        { name: 'basicstyles', items: [ 'Bold', 'Italic', 'Underline', 'Strike', '-', 'Undo', 'Redo' ] },
                        { name: 'paragraph', items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight'] },
                        { name: 'links', items: [ 'Image', 'Flash'] },
                        { name: 'styles', items: [ 'Font', 'FontSize','TextColor', 'BGColor'/*, '-', 'About'*/ ] }
                    ]
                };
        
                /*-- $('textarea.smeditor').ckeditor(CKEDITOR_CONFIG); --*/
            </script>
            <!--[if IE]>
            <style type="text/css">
                span.cke_toolbar span.cke_toolbar_separator { float:left; }
            </style><![endif]-->
        </c:when>
        
    </c:choose>
</c:forEach>
    
