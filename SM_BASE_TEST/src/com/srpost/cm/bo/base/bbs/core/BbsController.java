package com.srpost.cm.bo.base.bbs.core;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.cm.bo.base.bbs.conf.BbsConfBean;
import com.srpost.cm.bo.base.bbs.conf.BbsConfUtil;
import com.srpost.salmon.bean.BaseFileBean;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.FileUtil;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.web.mvc.controller.BaseController;

import static com.srpost.salmon.constant.StringPool.ONE;
import static com.srpost.salmon.constant.StringPool.Y;

/**
 * 내부단 게시판 컨트롤러
 *
 * @author  finkle
 * @date    2014-11-17
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/bbs/core")
public class BbsController extends BaseController {

    @Resource
    IBbsService service;

    /**
     * 게시판 메인
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public String index(BbsBean bean, HttpServletRequest request, ModelMap model) {
        
        Integer bbsCd = bean.getBbsCd();
        if ( StringUtil.isEmpty(bbsCd) ) {
            return alertAndBack(model, Message.BASE_BBS_FAIL_KEY);
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if ( StringUtil.isEmpty(confBean) ) {
            return alertAndBack(model, "bbs.conf.no.exist.fail");
        }
        
        model.addAttribute("confBean", confBean);
        model.addAttribute("hasAuth", BbsUtil.hasAuth(request, bean.getBbsCd()));
        model.addAttribute("pagerBean", service.list(bean, confBean));
        
        return baseUrl + BbsConfUtil.getFolderNm(confBean) + "/NR_index";
    }
    
    /**
     * 게시판 상세정보
     */
    @RequestMapping(value="NR_view.do", method=RequestMethod.GET)
    public String view(BbsBean bean, HttpServletRequest request, HttpServletResponse response, ModelMap model) {

        Integer bbsCd = bean.getBbsCd();
        if ( StringUtil.isEmpty(bbsCd) ) {
            return alertAndBack(model, Message.BASE_BBS_FAIL_KEY);
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if ( StringUtil.isEmpty(confBean) ) {
            return alertAndBack(model, "bbs.conf.no.exist.fail");
        }
        
        BbsBean dataBean = service.viewWithPrevNext(bean, confBean, BbsUtil.needUpdateReadCnt(bean, request, response));
        
        if ( StringUtil.isEmpty(dataBean) ) {
            return alertAndBack(model, Message.COMMON_NODATA_FAIL_KEY);
        }
        
        model.addAttribute("confBean", confBean);
        model.addAttribute("dataBean", dataBean);

        model.addAttribute("hasAuth", 
                BbsUtil.hasAuth(request, dataBean.getMgrId()) || 
                BbsUtil.hasAuth(request, bean.getBbsCd()));
        
        return baseUrl + BbsConfUtil.getFolderNm(confBean) + "/NR_view";
    }
    
    /**
     * 게시판 등록/수정 폼
     */
    @RequestMapping(value="NR_form.do", method=RequestMethod.GET)
    public String form(BbsBean bean, HttpServletRequest request, ModelMap model) {

        Integer bbsCd = bean.getBbsCd();
        if ( StringUtil.isEmpty(bbsCd) ) {
            return alertAndBack(model, Message.BASE_BBS_FAIL_KEY);
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if ( StringUtil.isEmpty(confBean) ) {
            return alertAndBack(model, "bbs.conf.no.exist.fail");
        }
        
        model.addAttribute("confBean", confBean);
        
        if (StringUtil.isEmpty(bean.getBbsSeq())) {
            bean.setOpenYn(Y);
            if (StringUtil.equals(Y, confBean.getHtmlYn()))
                bean.setHtmlYn(Y);
            model.addAttribute("dataBean", bean);
        }
        else {
            BbsBean dataBean = service.view(bean, confBean, false);        
            if ( StringUtil.isEmpty(dataBean) ) {
                return alertAndBack(model, Message.COMMON_NODATA_FAIL_KEY);
            }
            model.addAttribute("dataBean", dataBean == null ? bean : dataBean);
        }
        
        return baseUrl + BbsConfUtil.getFolderNm(confBean) + "/NR_form";
    }
    
    /**
     * 게시판 댓글/답변 폼
     */
    @RequestMapping(value={"NR_replyForm.do", "NR_endReplyForm.do"}, method=RequestMethod.GET)
    public String replyForm(BbsBean bean, ModelMap model) {

        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        
        model.addAttribute("confBean", confBean);
        
        BbsBean dataBean = service.view(bean, confBean, false);
        
        model.addAttribute("dataBean", dataBean);
        
        if (StringUtil.equals(BbsConfUtil.HIERARCHY, confBean.getTypeCd())) {
            dataBean.setTitle("RE: " + dataBean.getTitle());
            
            return baseUrl + BbsConfUtil.getFolderNm(confBean) + "/NR_replyForm";
        }
        
        return baseUrl + BbsConfUtil.getFolderNm(confBean) + "/NR_endReplyForm";
    }
    
    /**
     * 게시판 등록 액션
     */
    @RequestMapping(value="TR_insertAction.do", method=RequestMethod.POST)
    public ModelAndView insertAction(BbsBean bean, HttpServletRequest request, ModelMap model) {

        Integer bbsCd = bean.getBbsCd();
        if ( StringUtil.isEmpty(bbsCd) ) {
            return responseText(model, Message.fail(Message.BASE_BBS_FAIL_KEY));
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if ( StringUtil.isEmpty(confBean) ) {
            return responseText(model, Message.fail("bbs.conf.no.exist.fail"));
        }

        List<BaseFileBean> fileList = FileUtil.getUploadFile(request);
        bean.setFileList(fileList);

        int affected = service.insertAction(bean, confBean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_INSERT_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 게시판 수정 액션
     */
    @RequestMapping(value="TR_updateAction.do", method=RequestMethod.POST)
    public ModelAndView updateAction(BbsBean bean, HttpServletRequest request, ModelMap model) {
        
        Integer bbsCd = bean.getBbsCd();
        if ( StringUtil.isEmpty(bbsCd) ) {
            return responseText(model, Message.fail(Message.BASE_BBS_FAIL_KEY));
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if ( StringUtil.isEmpty(confBean) ) {
            return responseText(model, Message.fail("bbs.conf.no.exist.fail"));
        }
        
        BbsBean dataBean = service.view(bean, confBean, false);
        if ( StringUtil.isEmpty(dataBean) ) {
            return responseText(model, Message.fail(Message.COMMON_NODATA_FAIL_KEY));
        }
        
        if ( !BbsUtil.hasAuth(request, dataBean.getMgrId()) &&
                !BbsUtil.hasAuth(request, bean.getBbsCd()) ) {
            return responseText(model, Message.fail(Message.COMMON_ACCESS_FAIL_KEY));
        }
        
        List<BaseFileBean> fileList = FileUtil.getUploadFile(request);
        bean.setFileList(fileList);

        if (StringUtil.equals(BbsConfUtil.QNA, confBean.getTypeCd())) {
            bean.setAlertCds(BbsUtil.parseAlertCds(request));
        }
        
        int affected = service.updateAction(bean, confBean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 게시판 삭제 액션
     */
    @RequestMapping(value="TR_deleteAction.do", method=RequestMethod.POST)
    public ModelAndView deleteAction(BbsBean bean, HttpServletRequest request, ModelMap model) {

        Integer bbsCd = bean.getBbsCd();
        if ( StringUtil.isEmpty(bbsCd) ) {
            return responseText(model, Message.fail(Message.BASE_BBS_FAIL_KEY));
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if ( StringUtil.isEmpty(confBean) ) {
            return responseText(model, Message.fail("bbs.conf.no.exist.fail"));
        }

        if (StringUtil.isNotEmpty(bean.getBbsSeqs())) {
            if ( !BbsUtil.hasAuth(request, bean.getBbsCd()) ) {
                return responseText(model, Message.fail(Message.COMMON_ACCESS_FAIL_KEY));
            }
        }
        else {
            BbsBean dataBean = service.view(bean, confBean, false);
            if ( StringUtil.isEmpty(dataBean) ) {
                return responseText(model, Message.fail(Message.COMMON_NODATA_FAIL_KEY));
            }
            
            if ( !BbsUtil.hasAuth(request, dataBean.getMgrId()) ) {
                return responseText(model, Message.fail(Message.COMMON_ACCESS_FAIL_KEY));
            }
        }
        
        int affected = service.deleteAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_DELETE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
    
    /**
     * 엑셀 변환 팝업창
     */
    @RequestMapping(value="PR_excelForm.do", method=RequestMethod.GET)
    public String excelForm(BbsBean bean, ModelMap model) {
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        
        model.addAttribute("confBean", confBean);
        
        return baseUrl + BbsConfUtil.getFolderNm(confBean) + "/PR_excelForm";
    }
    
    /**
     * 엑셀 변환 액션
     */
    @RequestMapping(value="XR_excelAction.do", method=RequestMethod.POST)
    public ModelAndView excelAction(BbsBean bean, ModelMap model) {

        List<Map<String, Object>> dataList = 
                service.listExcel(bean, BbsUtil.getConfBean(bean.getBbsCd()));

        return responseExcel(model, dataList, bean);
    }
}
