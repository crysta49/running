<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="CONSTANT" clazz="com.srpost.salmon.constant.Constant"/>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
    <meta charset="utf-8"/>
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible"/>
    <title><sitemesh:write property="title"/></title>
    <meta name="robots" content="noindex, nofollow" />
    <%-- <meta http-equiv="expires" content="-1">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache"> --%>
    <sm:css names="extjs, bootstrap, salmon, qtip2" />
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <sm:js names="core, jquery, extjs, bootstrap, salmon, qtip2" />
    <sitemesh:write property="head"/>
    <style type="text/css">
    </style>
</head>
 
<body class="srm srm-pop">
<%--
<c:import url="/WEB-INF/jsp/bo/common/include/incAuth.jsp" charEncoding="UTF-8"/>

<c:import url="/WEB-INF/jsp/bo/common/include/incDebug.jsp" charEncoding="UTF-8"/> 
 --%>

<div class="ct-container">
    <sitemesh:write property="body"/>
</div>

<script type="text/javascript">

    $(document).ready(function(){
        
    });
    
</script>

</body>
</html>
