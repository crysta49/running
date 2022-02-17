<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.srpost.co.kr/jsp/taglib" prefix="sm" %>

<sm:static var="BBS_CONF_UTIL" clazz="com.srpost.cm.bo.base.bbs.conf.BbsConfUtil"/>

<c:set var="exist" value="${not empty dataBean.bbsCd}" />

<form:form commandName="dataBean" id="dataForm" name="dataForm" autocomplete="off">
    
    <table class="tbl-header">
        <tr>
            <th><span class="title-big">게시판 설정 ${exist ? "수정" : "등록"}</span></th>
            <td class="tr"><span class="required">표시는 필수입력 항목입니다.</span></td>
        </tr>
    </table>

    <table class="tbl-view tbl-form">
        <colgroup>
            <col width="140">
            <col>
            <col width="140">
            <col>
        </colgroup>
        <tr>
            <th>게시판 명<em>&nbsp;</em></th>
            <td>
                <form:input path="bbsNm" cssClass="smf-text" size="40"/>
            </td>
            <th>게시판 코드</th>
            <td>
                <c:if test="${exist}">
                    <form:input path="bbsCd" cssClass="smf-text" readonly="true" size="4"/>
                </c:if>
                <c:if test="${!exist}">
                    <span class="tagit">자동할당</span>
                </c:if>
            </td>
        </tr>
        <tr>
            <th>게시판 유형<em>&nbsp;</em></th>
            <td>
                <sm:code id="typeCd" grpCd="BBS_TYPE" defaultValues="${dataBean.typeCd}"/>
            </td>
            <th>게시판 폴더<em>&nbsp;</em>
                <span class="t3-help smtip">&nbsp;</span>
                <div class="sr-hidden">
                    <div class="smtip-title">게시판 폴더</div>
                    <div class="smtip-text">
                        <div>게시판 유형에 따라 기본형 /normal, 계층형 /hir, 답변형 /qna 입니다.
                        <br/>기본 폴더를 사용하지 않을 경우에는 /myfolder 형식으로 입력하세요.</div>
                    </div>
                </div>
            </th>
            <td>
                <form:input path="folderNm" cssClass="smf-text" size="20"/>
            </td>
        </tr>
        <tr>
            <th>분류 여부<em>&nbsp;</em>
                <span class="t3-help smtip">&nbsp;</span>
                <div class="sr-hidden">
                    <div class="smtip-title">분류 여부</div>
                    <div class="smtip-text">
                        <div>게시판 분류를 지정하실려면 사용 선택 후 분류지정 버튼을 클릭하세요.</div>
                    </div>
                </div>
            </th>
            <td>
                <form:radiobutton path="ctgYn" value="Y" label="사용" cssClass="smf-radio"/>
                <form:radiobutton path="ctgYn" value="N" label="미사용" cssClass="smf-radio"/> 
                <span class="btn-span ctgYnClass ${dataBean.ctgYn == 'Y' ? '' : 'sr-hidden'}" style="line-height: 30px;"><sm:button value="분류지정" btnSize="btn-xs" cssClass="btn-info" onclick="js_showBbsCtgPop('${dataBean.bbsCd}');"/></span>
                <div id="bbsCtgDiv" class="smd-sub-box ctgYnClass tagit"></div>
                <input type="hidden" name="ctgDatas" id="ctgDatas" />
            </td>
            <th>관리전용 여부<em>&nbsp;</em>
                <span class="t3-help smtip">&nbsp;</span>
                <div class="sr-hidden">
                    <div class="smtip-title">관리전용 여부</div>
                    <div class="smtip-text">
                        <div>지정된 관리자에 한해 글을 등록하실려면 사용 선택 후 관리자지정 버튼을 클릭하세요.</div>
                    </div>
                </div>
            </th>
            <td>
                <form:radiobutton path="admYn" value="Y" label="사용" cssClass="smf-radio"/>
                <form:radiobutton path="admYn" value="N" label="미사용" cssClass="smf-radio"/>
                <span class="btn-span admYnClass ${dataBean.admYn == 'Y' ? '' : 'sr-hidden'}" style="line-height: 30px;"><sm:button value="관리자지정" btnSize="btn-xs" cssClass="btn-info" onclick="js_showBbsMgrPop('${dataBean.bbsCd}');"/></span>
                <div id="bbsMgrDiv" class="smd-sub-box admYnClass tagit"></div>
                <input type="hidden" name="mgrDatas" id="mgrDatas" />
            </td>
        </tr>
        <tr>
            <th>의견글 여부<em>&nbsp;</em>
                <span class="t3-help smtip">&nbsp;</span>
                <div class="sr-hidden">
                    <div class="smtip-title">의견글 여부</div>
                    <div class="smtip-text">
                        <div>사용 선택 시 게시물에 대해 의견글을 등록할 수 있습니다.</div>
                    </div>
                </div>
            </th>
            <td>
                <form:radiobutton path="cmtYn" value="Y" label="사용" cssClass="smf-radio"/>
                <form:radiobutton path="cmtYn" value="N" label="미사용" cssClass="smf-radio"/>
            </td>
            <th>공개 여부<em>&nbsp;</em>
                <span class="t3-help smtip">&nbsp;</span>
                <div class="sr-hidden">
                    <div class="smtip-title">공개 여부</div>
                    <div class="smtip-text">
                        <div>사용 선택 시 게시물에 등록 시 공개/비공개를 선택해 등록할 수 있습니다. 
                        <br/>비공개 글은 고객단 화면에 표시되지 않습니다. (내부단 전용)</div>
                    </div>
                </div>
            </th>
            <td>
                <form:radiobutton path="openYn" value="Y" label="사용" cssClass="smf-radio"/>
                <form:radiobutton path="openYn" value="N" label="미사용" cssClass="smf-radio"/>
            </td>
        </tr>
        <%-- <tr>
            <th>공지 여부<em>&nbsp;</em>
                <span class="t3-help smtip">&nbsp;</span>
                <div class="sr-hidden">
                    <div class="smtip-title">공지 여부</div>
                    <div class="smtip-text">
                        <div>사용 선택 시 게시물 목록 상단에 항상 표시되는 공지글을 등록할 수 있습니다. (내부단 전용)</div>
                    </div>
                </div>
            </th>
            <td>
                <form:radiobutton path="ntcYn" value="Y" label="사용" cssClass="smf-radio"/>
                <form:radiobutton path="ntcYn" value="N" label="미사용" cssClass="smf-radio"/>
            </td>
            <th>알림 여부<em>&nbsp;</em>
                <span class="t3-help smtip">&nbsp;</span>
                <div class="sr-hidden">
                    <div class="smtip-title">알림 여부</div>
                    <div class="smtip-text">
                        <div>사용 선택 시 신규 게시물이 등록되었을 때 지정된 관리자에게 새글 알림 메시지가 전송됩니다.</div>
                    </div>
                </div>
            </th>
            <td>
                <form:radiobutton path="alimYn" value="Y" label="사용" cssClass="smf-radio"/>
                <form:radiobutton path="alimYn" value="N" label="미사용" cssClass="smf-radio"/>
            </td>
        </tr> --%>
        <tr>
            <th>첨부 여부<em>&nbsp;</em></th>
            <td>
                <form:radiobutton path="fileYn" value="Y" label="사용" cssClass="smf-radio"/>
                <form:radiobutton path="fileYn" value="N" label="미사용" cssClass="smf-radio"/>
            </td>
            <th>첨부 수</th>
            <td>
                <form:input path="fileCnt" cssClass="smf-text" size="1" maxlength="2" readonly="${dataBean.fileYn == 'Y' ? false : true}"/> 개
            </td>
        </tr>
        <tr>
            <th>HTML 여부<em>&nbsp;</em>
                <span class="t3-help smtip">&nbsp;</span>
                <div class="sr-hidden">
                    <div class="smtip-title">HTML 여부</div>
                    <div class="smtip-text">
                        <div>사용 선택 시 게시물 입력할 때 웹 에디터를 이용할 수 있습니다. (내부단 전용)</div>
                    </div>
                </div>
            </th>
            <td>
                <form:radiobutton path="htmlYn" value="Y" label="사용" cssClass="smf-radio"/>
                <form:radiobutton path="htmlYn" value="N" label="미사용" cssClass="smf-radio"/>
            </td>
            <th>확장 테이블
                <span class="t3-help smtip">&nbsp;</span>
                <div class="sr-hidden">
                    <div class="smtip-title">확장 테이블</div>
                    <div class="smtip-text">
                        <div>사용자 정의 필드를 게시판에서 사용할 경우 지정합니다. 
                        <br/>확장 테이블 이름은 CO_BBS_EXT_* 형식으로 미리 생성해야 본 화면에 표시됩니다.</div>
                    </div>
                </div>
            </th>
            <td>
                <select id="tableNm" name="tableNm" class="smf-select">
                    <option value="">-- 선택하세요. --</option>
                    <c:forEach items="${tableList}" var="item">
                        <option value="${item}" ${item == dataBean.tableNm ? 'selected=selected' : ''}>${item}</option>
                    </c:forEach>
                </select>
            </td>
        </tr>
        <c:if test="${exist}">
        <tr>
            <th>사용 여부<em>&nbsp;</em></th>
            <td colspan="3">
                <form:radiobutton path="useYn" value="Y" label="사용" cssClass="smf-radio"/>
                <form:radiobutton path="useYn" value="N" label="미사용" cssClass="smf-radio"/>
            </td>
        </tr>
        <tr>
            <th>등록일</th>
            <td class="plain">
                ${dataBean.regDt}
            </td>
            <th>최종 수정일</th>
            <td class="plain">
                ${dataBean.modiDt}
            </td>
        </tr>
        </c:if>
    </table>
    
    <sm:button-layout>
        <sm:button value="취소" glyph="" cssClass="btn-link" onclick="js_cancelAction('${dataBean.bbsCd}');" />
        <sm:button type="submit" value="${exist ? '수정' : '등록'}" glyph="saved" />
    </sm:button-layout>
</form:form>

<script type="text/javascript">

    Ext.onReady(function() {
        
        $("input[name=bbsNm]").focus();

        $("#dataForm").validate({
            rules: {
                bbsNm: { required: true, minlength: 2, maxlength: 60 },
                typeCd: { required: true },
                folderNm: { required: true, directory: true, maxlength: 50 },
                fileCnt: { number: true },
                ctgYn : { required: true },
                admYn : { required: true },
                cmtYn : { required: true },
                openYn : { required: true },
                ntcYn : { required: true },
                alimYn : { required: true },
                fileYn : { required: true },
                htmlYn : { required: true },
                useYn : { required: true }
            }, 
            submitHandler: function(form) {

                var ctgYn = $("input[name=ctgYn]:checked").val();
                if ( ctgYn == "Y" && ctgDatas.length == 0 ) {
                    alert("분류 여부 '사용' 선택 시 분류를 지정해야 합니다.");
                    return false;
                }

                var admYn = $("input[name=admYn]:checked").val();
                if ( admYn == "Y" && mgrDatas.length == 0 ) {
                    alert("관리전용 여부 '사용' 선택 시 관리자를 지정해야 합니다.");
                    return false;
                }
                
                var _bbsCtgs = [];
                Ext.each(ctgDatas, function(item, i){
                    _bbsCtgs.push(item[0] + "^" + item[1] + "^" + item[2]);
                });
                $("input[name=ctgDatas]").val(_bbsCtgs);
                
                var _bbsMgrs = [];
                Ext.each(mgrDatas, function(item, i){
                    _bbsMgrs.push(item[1] + "^" + item[2]);
                });
                $("input[name=mgrDatas]").val(_bbsMgrs);
                
                var useYn = $("input[name=useYn]:checked").val();
                SM.submit(form, {
                    url: "${exist ? 'TR_updateAction.do' : 'TR_insertAction.do'}"
                }, function(messages, xhr) {
                    if (messages.code == 200) {
                        SM.getCmp("gridPanel").store.reload();
                        js_cancelAction("${dataBean.bbsCd}");
                        
                        if ( "${dataBean.bbsCd}" == "" || "${dataBean.useYn}" != useYn ) {
                            js_cacheReloadAction(form, 'Y');
                        }
                        else {
                            js_cacheReloadAction(form);
                        }
                    }
                });
            }
        });
        
        $("#typeCd").change(function() {
            if( this.value == "${BBS_CONF_UTIL.NORMAL}" ) {
                $("#folderNm").val("/normal");
            }
            else if( this.value == "${BBS_CONF_UTIL.HIERARCHY}" ) {
                $("#folderNm").val("/hir");
            }
            else if( this.value == "${BBS_CONF_UTIL.QNA}" ) {
                $("#folderNm").val("/qna");
            }
            else {
                $("#folderNm").val("");
            }
        });
        
        // 분류, 관리전용 여부 선택 
        $("input[name=ctgYn], input[name=admYn]").click(function() {
            var value = this.value;
            if (value == "Y") $("." + this.name + "Class").show();
            else $("." + this.name + "Class").hide();
        });

        // 첨부 여부 선택 
        $("input[name=fileYn]").click(function() {
            var value = this.value;
            if (value == "Y") $("input[name=fileCnt]").prop("readonly", null);
            else $("input[name=fileCnt]").attr("readonly", "readonly");
        });
        
        $(".smtip").each(function() {
            $(this).qtip({
                content: {
                    title: $(this).next().find(".smtip-title"),
                    text: $(this).next().find(".smtip-text")
                },
                position: {
                    my: "bottom left",
                    at: "top center"
                }
            });
        });

        js_initArray();
        
        // 기존 설정된 분류, 관리자 지정
        <c:if test="${dataBean.ctgYn == 'Y'}">
            <c:forEach items="${dataBean.ctgList}" var="item">
                ctgDatas.push(["${item.ctgCd}", "${item.ctgNm}", ${item.orderNo}, false]);
            </c:forEach>
            js_setBbsCtgValues(ctgDatas);
        </c:if>
    
        <c:if test="${dataBean.admYn == 'Y'}">
            <c:forEach items="${dataBean.mgrList}" var="item">
                mgrDatas.push( ["${item.deptNm}", "${item.mgrId}", "${item.mgrNm}"] );
            </c:forEach>
            js_setBbsMgrValues(mgrDatas);
        </c:if>
    });
</script>

        
        