package com.srpost.cm.bo.base.code;

import static com.srpost.salmon.constant.StringPool.*;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.salmon.constant.Message;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 내부단 공통코드 컨트롤러
 *
 * @author  finkle
 * @date    2014-09-26
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/code")
public class CodeController extends BaseController {

    @Resource
    ICodeService service;
    
    /**
     * 그룹코드 메인
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public void index() {
    }
    
    /**
     * 그룹/개별코드 목록
     */
    @RequestMapping(value="JR_list.do", method=RequestMethod.GET)
    public ModelAndView list(CodeBean bean, ModelMap model) {

        return responseJson(model, service.list(bean));
    }

    /**
     * 그룹/개별코드 상세정보
     */
    @RequestMapping(value="AR_view.do", method=RequestMethod.POST)
    public void view(CodeBean bean, ModelMap model) {

        model.addAttribute("dataBean", service.view(bean));
    }
    
    /**
     * 그룹코드 등록 액션
     */
    @RequestMapping(value="TR_insertAction.do", method=RequestMethod.POST)
    public ModelAndView insertAction(CodeBean bean, ModelMap model) {

        CodeBean oldBean = service.view(bean);
        if (oldBean != null) {
            return responseText(model, Message.failMessage("코드값이 중복됩니다."));
        }

        int affected = service.insertAction(bean);

        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_INSERT_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 그룹코드 수정 액션
     */
    @RequestMapping(value="TR_updateAction.do", method=RequestMethod.POST)
    public ModelAndView updateAction(CodeBean bean, ModelMap model) {

        int affected = service.updateAction(bean);

        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 공통코드 삭제 액션
     */
    @RequestMapping(value="TR_deleteAction.do", method=RequestMethod.POST)
    public ModelAndView deleteAction(CodeBean bean, ModelMap model) {

        int affected = service.deleteAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_DELETE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
    
    /**
     * 개별코드 일괄 CRUD 액션
     */
    @RequestMapping(value="TR_crudAction.do", method=RequestMethod.POST)
    public ModelAndView crudAction(
            @RequestParam(required=false, value="inserts") String[] inserts,
            @RequestParam(required=false, value="updates") String[] updates,
            @RequestParam(required=false, value="deletes") String[] deletes, 
            ModelMap model) {

        int affected = service.crudAction(inserts, updates, deletes);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
    
    /**
     * 개별코드 일괄 순서변경 액션
     */
    @RequestMapping(value="TR_orderAction.do", method=RequestMethod.POST)
    public ModelAndView orderAction(
            @RequestParam(value="grpCd") String grpCd,
            @RequestParam(value="orders") String[] orders,
            ModelMap model) {

        int affected = service.orderAction(grpCd, orders);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
}
