package com.srpost.cm.bo.base.bbs.comment;

import static com.srpost.salmon.constant.StringPool.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.FileUtil;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 내부단 게시판 의견글 컨트롤러
 *
 * @author  finkle
 * @date    2015-01-23
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/bbs/comment")
public class BbsCmtController extends BaseController {

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

        BbsCmtUtil.setWriterlValue(bean, request);
        bean.setFileList(FileUtil.getUploadFile(request));
        
    	int affected = service.insertAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_INSERT_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 의견글 수정, 답변 폼
     */
    @RequestMapping(value={"PR_updateForm.do", "PR_replyForm.do"}, method=RequestMethod.GET)
    public void updateForm(BbsCmtBean bean, ModelMap model) {

        model.addAttribute("dataBean", service.view(bean));
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
     * 의견글 답변 액션
     */
    @RequestMapping(value="TR_replyAction.do", method=RequestMethod.POST)
    public ModelAndView replyAction(BbsCmtBean bean, HttpServletRequest request, ModelMap model) {

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
