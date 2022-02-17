package com.srpost.cm.bo.base.menu;

import static com.srpost.salmon.constant.StringPool.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.cm.bo.base.mgr.MgrUtil;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 내부단 메뉴관리 컨트롤러
 *
 * @author  finkle
 * @date    2014-10-14
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/menu")
public class MenuController extends BaseController {

    @Resource
    IMenuService service;

    /**
     * 메뉴관리 메인
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public void index() {
    }
    
    /**
     * 메뉴관리 TREE 목록
     */
    @RequestMapping(value="JR_list.do", method=RequestMethod.GET)
    public ModelAndView list(MenuBean bean, ModelMap model) {

        return responseJson(model, service.list(bean));
    }

    /**
     * 메뉴관리 상세정보
     */
    @RequestMapping(value="AR_view.do", method=RequestMethod.POST)
    public void view(MenuBean bean, ModelMap model) {

        model.addAttribute("dataBean", service.view(bean));
    }
    
    /**
     * 메뉴관리 등록 액션
     */
    @RequestMapping(value="TR_insertAction.do", method=RequestMethod.POST)
    public ModelAndView insertAction(MenuBean bean, ModelMap model) {

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
     * 메뉴관리 수정 액션
     */
    @RequestMapping(value="TR_updateAction.do", method=RequestMethod.POST)
    public ModelAndView updateAction(MenuBean bean, ModelMap model) {

        int affected = service.updateAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 메뉴관리 삭제 액션
     */
    @RequestMapping(value="TR_deleteAction.do", method=RequestMethod.POST)
    public ModelAndView deleteAction(MenuBean bean, ModelMap model) {

        int affected = service.deleteAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_DELETE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
    
    /**
     * 메뉴 TREE 전체 목록
     */
    @RequestMapping(value="JR_listAll.do", method=RequestMethod.GET)
    public ModelAndView listAll(MenuBean bean, ModelMap model) {

        return responseJson(model, service.listAllJSON(), true);
    }
    
    /**
     * 메뉴 TREE 전체 목록 (특정 직원에게 할당된 메뉴목록만 로드)
     */
    @RequestMapping(value="JR_listMyAll.do", method=RequestMethod.GET)
    public ModelAndView listMyAllJSON(MenuBean bean, HttpServletRequest request, ModelMap model) {

        bean.setMgrId(MgrUtil.getSession(request).getMgrId());
        
        return responseJson(model, service.listMyAllJSON(bean), true);
    }
}
