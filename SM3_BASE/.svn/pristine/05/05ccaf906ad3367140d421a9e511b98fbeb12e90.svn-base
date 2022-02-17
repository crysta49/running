package com.srpost.cm.bo.base.domain;

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
 * 내부단 도메인 컨트롤러
 *
 * @author  finkle
 * @date    2014-11-07
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/domain")
public class DomainController extends BaseController {

    @Resource
    IDomainService service;
    
    /**
     * 도메인 메인
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public void index() {
    }
    
    /**
     * 도메인 목록
     */
    @RequestMapping(value="JR_list.do", method=RequestMethod.GET)
    public ModelAndView list(ModelMap model) {

        return responseJson(model, service.list());
    }

    /**
     * 도메인 상세정보
     */
    @RequestMapping(value="AR_view.do", method=RequestMethod.POST)
    public void view(DomainBean bean, ModelMap model) {

        if (StringUtil.isEmpty(bean.getDomainCd()))
            model.addAttribute("dataBean", bean);
        else {
            DomainBean dataBean = service.view(bean);            
            model.addAttribute("dataBean", dataBean == null ? bean : dataBean);
        }
    }
    
    /**
     * 도메인 등록 액션
     */
    @RequestMapping(value="TR_insertAction.do", method=RequestMethod.POST)
    public ModelAndView insertAction(DomainBean bean, ModelMap model) {

        DomainBean dataBean = service.view(bean); 
        if (dataBean != null)
            return responseText(model, Message.failMessage("도메인 코드값이 중복됩니다."));
            
        int affected = service.insertAction(bean);

        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_INSERT_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 도메인 수정 액션
     */
    @RequestMapping(value="TR_updateAction.do", method=RequestMethod.POST)
    public ModelAndView updateAction(DomainBean bean, ModelMap model) {

        int affected = service.updateAction(bean);

        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 도메인 삭제 액션
     */
    @RequestMapping(value="TR_deleteAction.do", method=RequestMethod.POST)
    public ModelAndView deleteAction(DomainBean bean, ModelMap model) {

        return responseText(model, Message.success(Message.COMMON_NOSUPPORT_FAIL_KEY));
        
        /*--
        int affected = service.deleteAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_DELETE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
        --*/
    }
}
