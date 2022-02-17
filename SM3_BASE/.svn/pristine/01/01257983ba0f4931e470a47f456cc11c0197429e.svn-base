<?xml version="1.0" encoding="EUC-KR"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/">

<html>
<head>
    <title>통합민원시스템</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr"/>
    <style>
        * { font-family: 'Malgun Gothic','lucida grande',tahoma,arial,sans-serif; font-size: 14px; line-height: 1.6; }
        html, body { height: 100%; margin: 0; padding: 0px; margin-top:16px; text-align:center; }
        table { width:90%; border:1px solid #000; border-collapse: collapse; table-layout:fixed; }
        th, td { border:1px solid #000; }
        th.header { background-color: #DAE6F3; }
        th { background-color: #e6ffc0; }
        textarea { width:100%; border: none; }
    </style>
</head>

<body> 
<xsl:for-each select="ITEMS/ITEM">
    <table>
        <colgroup>
            <col width="100" />
            <col class="*" />
            <col width="100" />
            <col class="*" />
        </colgroup>
        <tr>
            <th colspan="4" class="header">
                <span>민원 접수 내용</span>
            </th>
        </tr>
        <tr>
            <th>접수번호</th>
            <td>
                <span><xsl:value-of select="RCV_NO"/></span>
            </td>
            <th>작성일</th>
            <td>
                <span><xsl:value-of select="REG_DT"/></span>
            </td>
        </tr>
        <tr>
            <th>민원인</th>
            <td>
                <span><xsl:value-of select="USER_NM"/></span>
            </td>
            <th>처리기한</th>
            <td>
                <span><xsl:value-of select="LMT_DT"/></span>
            </td>
        </tr>
        <tr>
            <th>제목</th>
            <td colspan="3">
                <strong><xsl:value-of select="TITLE"/></strong>
            </td>
        </tr>
        <tr>
            <th>민원내용</th>
            <td colspan="3">
                <textarea rows="8" readonly="true"><xsl:value-of select="QUESTION"/></textarea>
            </td>
        </tr>

        <tr>
            <th colspan="4" class="header">
                <span>민원 답변 내용</span>
            </th>
        </tr>
        <tr>
            <th>민원분류</th>
            <td>
                <span><xsl:value-of select="TYPE_NM"/></span>
            </td>
            <th>처리기한</th>
            <td>
                <span><xsl:value-of select="LMT_DT"/></span>
            </td>
        </tr>
        <tr>
            <th>담당자</th>
            <td>
                <span><xsl:value-of select="MGR_NM"/></span>
            </td>
            <th>답변일</th>
            <td>
                <span><xsl:value-of select="END_DT"/></span>
            </td>
        </tr>
        <tr>
            <th>답변내용</th>
            <td colspan="3">
                <textarea rows="8" readonly="true"><xsl:value-of select="REPLY"/></textarea>
            </td>
        </tr>
    </table>
</xsl:for-each>

</body>
</html>

</xsl:template>
</xsl:stylesheet> 
