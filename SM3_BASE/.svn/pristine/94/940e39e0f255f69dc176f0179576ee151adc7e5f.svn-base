package com.srpost.cm.bo.base.hday;

import static com.srpost.salmon.constant.StringPool.*;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 내부단 공휴일 컨트롤러
 *
 * @author  finkle
 * @date    2014-11-07
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/hday")
public class HdayController extends BaseController {

    @Resource
    IHdayService service;
    
    /**
     * 공휴일 메인
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public void index() {
    }
    
    /**
     * 공휴일 목록
     */
    @RequestMapping(value="JR_list.do", method=RequestMethod.GET)
    public ModelAndView list(ModelMap model) {

        return responseJson(model, service.list());
    }

    /**
     * 공휴일 상세정보
     */
    @RequestMapping(value="AR_view.do", method=RequestMethod.POST)
    public void view(HdayBean bean, ModelMap model) {

        if (StringUtil.isEmpty(bean.getSeq()))
            model.addAttribute("dataBean", bean);
        else {
            HdayBean dataBean = service.view(bean);            
            model.addAttribute("dataBean", dataBean == null ? bean : dataBean);
        }
    }
    
    /**
     * 공휴일 등록 액션
     */
    @RequestMapping(value="TR_insertAction.do", method=RequestMethod.POST)
    public ModelAndView insertAction(HdayBean bean, ModelMap model) {

        int affected = service.insertAction(bean);

        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_INSERT_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 공휴일 수정 액션
     */
    @RequestMapping(value="TR_updateAction.do", method=RequestMethod.POST)
    public ModelAndView updateAction(HdayBean bean, ModelMap model) {

        int affected = service.updateAction(bean);

        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 공휴일 삭제 액션
     */
    @RequestMapping(value="TR_deleteAction.do", method=RequestMethod.POST)
    public ModelAndView deleteAction(HdayBean bean, ModelMap model) {

        int affected = service.deleteAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_DELETE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
}
