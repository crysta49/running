package com.srpost.cm.fe2.bbs;

import static com.srpost.salmon.constant.StringPool.*;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.cm.bo.base.bbs.comment.BbsCmtBean;
import com.srpost.cm.bo.base.bbs.comment.IBbsCmtService;
import com.srpost.cm.bo.base.bbs.conf.BbsConfBean;
import com.srpost.cm.bo.base.bbs.core.BbsBean;
import com.srpost.cm.bo.base.bbs.core.BbsUtil;
import com.srpost.cm.bo.base.bbs.core.IBbsService;
import com.srpost.cm.bo.base.user.UserBean;
import com.srpost.cm.bo.base.user.UserUtil;
import com.srpost.salmon.bean.BaseFileBean;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.FileUtil;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 고객단 게시판 컨트롤러
 *
 * @author  finkle
 * @date    2015-02-05
 * @since   2.0
 */
@Controller
@RequestMapping(value="/fe2/bbs")
public class Fe2BbsController extends BaseController {

    @Resource
    IBbsService service;
    @Resource
    IBbsCmtService cmtService;
    
    /**
     * 게시판 목록
     */
    @RequestMapping(value="NR_list.do", method=RequestMethod.GET)
    public String list(BbsBean bean, ModelMap model) {
        
        if (StringUtil.isEmpty(bean.getBbsCd())) {
            return alertAndBack(model, Message.COMMON_PARAM_FAIL_KEY);
        }        
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());        
        if (confBean == null) {
            return alertAndBack(model, Message.BASE_BBS_FAIL_KEY);
        }
        
        model.addAttribute("confBean", confBean);
        model.addAttribute("pagerBean", service.list(bean, confBean));
        
        return baseUrl + confBean.getFolderNm() + "/NR_list";
    }
    
    /**
     * 게시판 상세정보
     */
    @RequestMapping(value="NR_view.do", method=RequestMethod.GET)
    public String view(BbsBean bean, 
            HttpServletRequest request, HttpServletResponse response, ModelMap model) {

        if (StringUtil.isEmpty(bean.getBbsCd())) {
            return alertAndBack(model, Message.COMMON_PARAM_FAIL_KEY);
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if (confBean == null) {
            return alertAndBack(model, Message.BASE_BBS_FAIL_KEY);
        }
        
        BbsBean dataBean = service.view(bean, confBean, BbsUtil.needUpdateReadCnt(bean, request, response));
        
        if (dataBean == null) {
            return alertAndBack(model, Message.COMMON_NODATA_FAIL_KEY);
        }
        
        // 비공개글 체크
        if (StringUtil.equals("N", dataBean.getOpenYn())) {
            
            UserBean userBean = UserUtil.getSession(request);
            if (null == userBean || !StringUtil.equals(userBean.getUserKey(), dataBean.getUserKey())) {
                return alertAndBack(model, Message.FRONT_OPENYN_KEY);
            }
        }
        
        // 의견글 목록
        if (StringUtil.equals("Y", confBean.getCmtYn())) {
            BbsCmtBean bbsCmtBean = new BbsCmtBean();
            bbsCmtBean.setBbsCd(dataBean.getBbsCd());
            bbsCmtBean.setBbsSeq(dataBean.getBbsSeq());
            dataBean.setCommentList(cmtService.list(bbsCmtBean));
        }
        
        model.addAttribute("confBean", confBean);
        model.addAttribute("dataBean", dataBean);

        return baseUrl + confBean.getFolderNm() + "/NR_view";
    }
    
    /**
     * 게시판 등록/수정 폼
     */
    @RequestMapping(value="NR_form.do", method=RequestMethod.GET)
    public String form(BbsBean bean, HttpServletRequest request, ModelMap model) {

        if (StringUtil.isEmpty(bean.getBbsCd())) {
            return alertAndBack(model, Message.COMMON_PARAM_FAIL_KEY);
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if (confBean == null) {
            return alertAndBack(model, Message.BASE_BBS_FAIL_KEY);
        }
        
        // 로그인 여부 확인
        if (!UserUtil.hasSession(request)) {
            return alertAndBack(model, Message.FRONT_LOGIN_REQUIRE_KEY);
        }
        
        model.addAttribute("confBean", confBean);
        
        if (StringUtil.isEmpty(bean.getBbsSeq())) {
            model.addAttribute("dataBean", bean);
        }
        else {
            BbsBean dataBean = service.view(bean, confBean, false);
            model.addAttribute("dataBean", dataBean == null ? bean : dataBean);
        }
        
        model.addAttribute("USER_ACTION", StringUtil.isEmpty(bean.getBbsSeq()) ? "INSERT" : "UPDATE");
        bean.setUserBean(UserUtil.getSession(request.getSession()));

        return baseUrl + confBean.getFolderNm() + "/NR_form";
    }
    
    /**
     * 게시판 댓글 폼
     */
    @RequestMapping(value="NR_replyForm.do", method=RequestMethod.GET)
    public String replyForm(BbsBean bean, ModelMap model) {

        if (StringUtil.isEmpty(bean.getBbsCd())) {
            return alertAndBack(model, Message.COMMON_PARAM_FAIL_KEY);
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if (confBean == null) {
            return alertAndBack(model, Message.BASE_BBS_FAIL_KEY);
        }
        
        model.addAttribute("confBean", confBean);
        
        BbsBean dataBean = service.view(bean, confBean, false);
        dataBean.setTitle("RE: " + dataBean.getTitle());
        
        model.addAttribute("dataBean", dataBean);

        return baseUrl + confBean.getFolderNm() + "/NR_replyForm";
    }
    
    /**
     * 게시판 등록 액션
     */
    @RequestMapping(value="TR_insertAction.do", method=RequestMethod.POST)
    public ModelAndView insertAction(BbsBean bean, HttpServletRequest request, ModelMap model) {

        if (StringUtil.isEmpty(bean.getBbsCd())) {
            return responseText(model, Message.fail(Message.COMMON_PARAM_FAIL_KEY));
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if (confBean == null) {
            return responseText(model, Message.fail(Message.BASE_BBS_FAIL_KEY));
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
        
        if (StringUtil.isEmpty(bean.getBbsCd())) {
            return responseText(model, Message.fail(Message.COMMON_PARAM_FAIL_KEY));
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if (confBean == null) {
            return responseText(model, Message.fail(Message.BASE_BBS_FAIL_KEY));
        }
        
        List<BaseFileBean> fileList = FileUtil.getUploadFile(request);
        bean.setFileList(fileList);

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
    public ModelAndView deleteAction(BbsBean bean, ModelMap model) {

        if (StringUtil.isEmpty(bean.getBbsCd())) {
            return responseText(model, Message.fail(Message.COMMON_PARAM_FAIL_KEY));
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if (confBean == null) {
            return responseText(model, Message.fail(Message.BASE_BBS_FAIL_KEY));
        }

        int affected = service.deleteAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_DELETE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
    
}
