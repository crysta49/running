<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<%-- 내 쪽지함 --%>

<table class="tbl-list tbl-ds-note">
    <colgroup>
        <col width="30%" />
        <col width="70%" />
    </colgroup>
    <tr>
        <td><a href="#" onclick="js_link('note');"><span class="t3-note-rcv">받은 쪽지함</span></a></td>
        <td class="tr">
            <strong>${dataMap['RCV_NO_READ_COUNT']}</strong>/${dataMap['RCV_TOTAL_COUNT']} (미수신/전체)
        </td>
    </tr>
    <tr>
        <td><a href="#" onclick="js_link('note', '?openIndex=1');"><span class="t3-note-send">보낸 쪽지함</span></a></td>
        <td class="tr">
            <strong>${dataMap['SND_NO_READ_COUNT']}</strong>/${dataMap['SND_TOTAL_COUNT']} (미수신/전체)
        </td>
    </tr>
</table>

<sm:button-layout>
    <sm:button icon="b3-tick" value="쪽지 보내기" onclick="js_link('note', '?openIndex=2');"/>
</sm:button-layout>