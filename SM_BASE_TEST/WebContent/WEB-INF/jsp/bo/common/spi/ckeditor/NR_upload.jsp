<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="salmon" %>

<html>
<head>
    <title>CKEditor 업로드 결과</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <script type="text/javascript">
        window.parent.CKEDITOR.tools.callFunction(${funcNum}, "${fileUrl}", "${message}");
    </script>
</head>

<body>

</body>
</html>