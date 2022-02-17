package com.srpost.cm.bo.base.menu.front;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.cm.bo.base.domain.IDomainService;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.web.mvc.controller.BaseController;

import static com.srpost.salmon.constant.StringPool.ONE;

/**
 * 내부단 프론트 메뉴관리 컨트롤러
 *
 * @author  finkle
 * @date    2014-10-14
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/menu/front")
public class MenuFrontController extends BaseController {

    @Resource
    IMenuFrontService service;
    @Resource
    IDomainService domainService;
    
    /**
     * 프론트 메뉴관리 메인
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public void index(ModelMap model) {
        
        model.addAttribute("domainList", domainService.list());
    }
    
    /**
     * 프론트 메뉴관리 TREE 목록
     */
    @RequestMapping(value="JR_list.do", method=RequestMethod.GET)
    public ModelAndView list(MenuFrontBean bean, ModelMap model) {

        return responseJson(model, service.list(bean));
    }

    /**
     * 프론트 메뉴관리 상세정보
     */
    @RequestMapping(value="AR_view.do", method=RequestMethod.POST)
    public void view(MenuFrontBean bean, ModelMap model) {

        model.addAttribute("dataBean", service.view(bean));
    }
    
    /**
     * 프론트 메뉴관리 등록 액션
     */
    @RequestMapping(value="TR_insertAction.do", method=RequestMethod.POST)
    public ModelAndView insertAction(MenuFrontBean bean, ModelMap model) {

        Object newPrimaryKey = service.insertAction(bean);

        String message = null;

        if (newPrimaryKey != null) {
            message = Message.success(Message.COMMON_INSERT_SUCCESS_KEY);
        }
        else {
            message = Message.fail(Message.COMMON_CRUD_FAIL_KEY);
        }
        return responseText(model, message + Message.DELIMETER + newPrimaryKey);
    }

    /**
     * 프론트 메뉴관리 수정 액션
     */
    @RequestMapping(value="TR_updateAction.do", method=RequestMethod.POST)
    public ModelAndView updateAction(MenuFrontBean bean, ModelMap model) {

        int affected = service.updateAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 프론트 메뉴관리 삭제 액션
     */
    @RequestMapping(value="TR_deleteAction.do", method=RequestMethod.POST)
    public ModelAndView deleteAction(MenuFrontBean bean, ModelMap model) {

        int affected = service.deleteAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_DELETE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
    
    /**
     * 프론트 메뉴 담당자지정 팝업창
     */
    @RequestMapping(value="PR_menuMgrForm.do", method=RequestMethod.GET)
    public void menuMgrForm() {
    }
}
