package com.srpost.cm.bo.base.faq.ctg;

import static com.srpost.salmon.constant.StringPool.*;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.salmon.constant.Message;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 내부단 FAQ분류 관리 컨트롤러
 *
 * @author  finkle
 * @date    2014-11-20
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/faq/ctg")
public class FaqCtgController extends BaseController {

    @Resource
    IFaqCtgService service;

    /**
     * FAQ분류 메인
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public void index() {
    }
    
    /**
     * FAQ분류 TREE 목록
     */
    @RequestMapping(value="JR_list.do", method=RequestMethod.GET)
    public ModelAndView list(FaqCtgBean bean, ModelMap model) {

        return responseJson(model, service.list(bean));
    }

    /**
     * FAQ분류 상세정보
     */
    @RequestMapping(value="AR_view.do", method=RequestMethod.POST)
    public void view(FaqCtgBean bean, ModelMap model) {

        model.addAttribute("dataBean", service.view(bean));
    }
    
    /**
     * FAQ분류 등록 액션
     */
    @RequestMapping(value="TR_insertAction.do", method=RequestMethod.POST)
    public ModelAndView insertAction(FaqCtgBean bean, ModelMap model) {

        String message = null;
        
        Object newPrimaryKey = service.insertAction(bean);

        if (newPrimaryKey != null) {
            message = Message.success(Message.COMMON_INSERT_SUCCESS_KEY);
        }
        else {
            message = Message.fail(Message.COMMON_CRUD_FAIL_KEY);
        }
        return responseText(model, message + Message.DELIMETER + newPrimaryKey);
    }

    /**
     * FAQ분류 수정 액션
     */
    @RequestMapping(value="TR_updateAction.do", method=RequestMethod.POST)
    public ModelAndView updateAction(FaqCtgBean bean, ModelMap model) {

        int affected = service.updateAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * FAQ분류 삭제 액션
     */
    @RequestMapping(value="TR_deleteAction.do", method=RequestMethod.POST)
    public ModelAndView deleteAction(FaqCtgBean bean, ModelMap model) {

        // TODO : 분류코드가 응용 FAQ 테이블에 맵핑되어 있다면 삭제 거부해야 함.
        
        int affected = service.deleteAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_DELETE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
}
