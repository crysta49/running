package com.srpost.cm.bo.base.dept;

import static com.srpost.salmon.constant.Constant.*;
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
 * 내부단 부서관리 컨트롤러
 *
 * @author  finkle
 * @date    2014-10-27
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/dept")
public class DeptController extends BaseController {

    @Resource
    IDeptService service;

    /**
     * 부서관리 메인
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public void index() {
    }
    
    /**
     * 부서관리 TREE 목록
     */
    @RequestMapping(value="JR_list.do", method=RequestMethod.GET)
    public ModelAndView list(DeptBean bean, ModelMap model) {

        return responseJson(model, service.list(bean));
    }

    /**
     * 부서관리 상세정보
     */
    @RequestMapping(value="AR_view.do", method=RequestMethod.POST)
    public String view(DeptBean bean, ModelMap model) {

        model.addAttribute("dataBean", service.view(bean));
        
        return IS_DEPT_CONNECT ? baseUrl + "/AR_viewOnly" : baseUrl + "/AR_view";
    }
    
    /**
     * 부서관리 등록 액션
     */
    @RequestMapping(value="TR_insertAction.do", method=RequestMethod.POST)
    public ModelAndView insertAction(DeptBean bean, ModelMap model) {

        if ( IS_DEPT_CONNECT ) {
            return responseText(model, Message.fail(Message.COMMON_NOSUPPORT_FAIL_KEY));
        }

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
     * 부서관리 수정 액션
     */
    @RequestMapping(value="TR_updateAction.do", method=RequestMethod.POST)
    public ModelAndView updateAction(DeptBean bean, ModelMap model) {

        if ( IS_DEPT_CONNECT ) {
            return responseText(model, Message.fail(Message.COMMON_NOSUPPORT_FAIL_KEY));
        }
        
        int affected = service.updateAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 부서관리 삭제 액션
     */
    @RequestMapping(value="TR_deleteAction.do", method=RequestMethod.POST)
    public ModelAndView deleteAction(DeptBean bean, ModelMap model) {

        if ( IS_DEPT_CONNECT ) {
            return responseText(model, Message.fail(Message.COMMON_NOSUPPORT_FAIL_KEY));
        }
        
        // TODO : 부서코드가 응용테이블에 맵핑되어 있다면 삭제 거부해야 함.
        
        int affected = service.deleteAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_DELETE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
    
    /**
     * 부서관리 TREE 전체 목록
     */
    @RequestMapping(value="JR_listAll.do", method=RequestMethod.GET)
    public ModelAndView listAll(DeptBean bean, ModelMap model) {

        return responseJson(model, service.listAllJSON(), true);
    }
}
