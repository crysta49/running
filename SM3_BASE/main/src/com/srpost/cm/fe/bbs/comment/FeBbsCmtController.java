package com.srpost.cm.fe.bbs.comment;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.cm.bo.base.bbs.comment.BbsCmtBean;
import com.srpost.cm.bo.base.bbs.comment.BbsCmtUtil;
import com.srpost.cm.bo.base.bbs.comment.IBbsCmtService;
import com.srpost.cm.bo.base.bbs.conf.BbsConfBean;
import com.srpost.cm.bo.base.bbs.core.BbsUtil;
import com.srpost.cm.bo.base.user.UserBean;
import com.srpost.cm.bo.base.user.UserUtil;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.FileUtil;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.web.mvc.controller.BaseController;

import static com.srpost.salmon.constant.StringPool.ONE;

/**
 * 내부단 게시판 의견글 컨트롤러
 *
 * @author  finkle
 * @date    2015-01-23
 * @since   2.0
 */
@Controller
@RequestMapping(value="/fe/bbs/comment")
public class FeBbsCmtController extends BaseController {

    @Resource
    IBbsCmtService service;
    
    /**
     * 의견글 목록 조회
     */
    @RequestMapping(value="AR_list.do", method=RequestMethod.POST)
    public void list(BbsCmtBean bean, ModelMap model) {

        model.addAttribute("dataList", service.list(bean));
    }

    /**
     * 의견글 등록 액션
     */
    @RequestMapping(value="TR_insertAction.do", method=RequestMethod.POST)
    public ModelAndView insertAction(BbsCmtBean bean, HttpServletRequest request, ModelMap model) {

        Integer bbsCd = bean.getBbsCd();
        if ( StringUtil.isEmpty(bbsCd) ) {
            return responseText(model, Message.fail(Message.BASE_BBS_FAIL_KEY));
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if ( StringUtil.isEmpty(confBean) ) {
            return responseText(model, Message.fail("bbs.conf.no.exist.fail"));
        }

        UserBean userBean = UserUtil.getSession(request);
        if (userBean == null) {
            return responseText(model, Message.fail("bbs.login.require.fail"));
        }
        
        BbsCmtUtil.setWriterlValue(bean, request);
        bean.setFileList(FileUtil.getUploadFile(request));
        
    	int affected = service.insertAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_INSERT_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 의견글 수정 폼
     */
    @RequestMapping(value="PR_updateForm.do", method=RequestMethod.GET)
    public String updateForm(BbsCmtBean bean, HttpServletRequest request, ModelMap model) {

        Integer bbsCd = bean.getBbsCd();
        if ( StringUtil.isEmpty(bbsCd) ) {
            return alertAndClose(model, Message.BASE_BBS_FAIL_KEY);
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if ( StringUtil.isEmpty(confBean) ) {
            return alertAndClose(model, "bbs.conf.no.exist.fail");
        }
        
        model.addAttribute("confBean", confBean);
        
        BbsCmtBean dataBean = service.view(bean);
        if ( StringUtil.isEmpty(dataBean) ) {
            return alertAndClose(model, Message.COMMON_NODATA_FAIL_KEY);
        }
        
        if ( !BbsCmtUtil.isOwner(dataBean, request) ) 
            return alertAndClose(model, Message.BASE_AUTH_CRUD_FAIL_KEY);
        
        model.addAttribute("dataBean", dataBean);
        
        return baseUrl + "/PR_updateForm";
    }
    
    /**
     * 의견글 수정 액션
     */
    @RequestMapping(value="TR_updateAction.do", method=RequestMethod.POST)
    public ModelAndView updateAction(BbsCmtBean bean, HttpServletRequest request, ModelMap model) {

    	BbsCmtBean dataBean = service.view(bean);
        if ( StringUtil.isEmpty(dataBean) ) {
            return responseText(model, Message.fail(Message.COMMON_NODATA_FAIL_KEY));
        }
        
    	if ( !BbsCmtUtil.isOwner(dataBean, request) ) 
            return responseText(model, Message.fail(Message.BASE_AUTH_CRUD_FAIL_KEY));
    	
        bean.setFileList(FileUtil.getUploadFile(request));
        
    	int affected = service.updateAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
    
    /**
     * 의견글 답변 폼
     */
    @RequestMapping(value="PR_replyForm.do", method=RequestMethod.GET)
    public String replyForm(BbsCmtBean bean, HttpServletRequest request, ModelMap model) {

        Integer bbsCd = bean.getBbsCd();
        if ( StringUtil.isEmpty(bbsCd) ) {
            return alertAndClose(model, Message.BASE_BBS_FAIL_KEY);
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if ( StringUtil.isEmpty(confBean) ) {
            return alertAndClose(model, "bbs.conf.no.exist.fail");
        }
        
        model.addAttribute("confBean", confBean);
        
        BbsCmtBean dataBean = service.view(bean);
        if ( StringUtil.isEmpty(dataBean) ) {
            return alertAndClose(model, Message.COMMON_NODATA_FAIL_KEY);
        }
        
        UserBean userBean = UserUtil.getSession(request);
        if (userBean == null) {
            return alertAndClose(model, "bbs.login.require.fail");
        }
        
        model.addAttribute("dataBean", dataBean);
        
        return baseUrl + "/PR_replyForm";
    }
    
    /**
     * 의견글 답변 액션
     */
    @RequestMapping(value="TR_replyAction.do", method=RequestMethod.POST)
    public ModelAndView replyAction(BbsCmtBean bean, HttpServletRequest request, ModelMap model) {

        Integer bbsCd = bean.getBbsCd();
        if ( StringUtil.isEmpty(bbsCd) ) {
            return responseText(model, Message.fail(Message.BASE_BBS_FAIL_KEY));
        }
        
        BbsConfBean confBean = BbsUtil.getConfBean(bean.getBbsCd());
        if ( StringUtil.isEmpty(confBean) ) {
            return responseText(model, Message.fail("bbs.conf.no.exist.fail"));
        }
        
        UserBean userBean = UserUtil.getSession(request);
        if (userBean == null) {
            return responseText(model, Message.fail("bbs.login.require.fail"));
        }
        
        BbsCmtUtil.setWriterlValue(bean, request);
        bean.setFileList(FileUtil.getUploadFile(request));
        
    	int affected = service.replyAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_INSERT_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 의견글 삭제 액션
     */
    @RequestMapping(value="TR_deleteAction.do", method=RequestMethod.POST)
    public ModelAndView deleteAction(BbsCmtBean bean, HttpServletRequest request, ModelMap model) {

    	BbsCmtBean dataBean = service.view(bean);
        if ( StringUtil.isEmpty(dataBean) ) {
            return responseText(model, Message.fail(Message.COMMON_NODATA_FAIL_KEY));
        }

    	if ( !BbsCmtUtil.isOwner(dataBean, request) ) 
    		return responseText(model, Message.fail(Message.BASE_AUTH_CRUD_FAIL_KEY));
    	
    	int affected = service.deleteAction(bean);
    	if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_DELETE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
}
