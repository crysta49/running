package com.srpost.cm.bo.base.auth;

import static com.srpost.salmon.constant.StringPool.*;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 내부단 권한 컨트롤러
 *
 * @author  finkle
 * @date    2014-11-06
 * @since   3.0
 */
@Controller
@RequestMapping(value="/bo/base/auth")
public class AuthController extends BaseController {

    @Resource
    IAuthService service;
    
    /**
     * 권한그룹 메인
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public void index() {
    }
    
    /**
     * 권한그룹 목록
     */
    @RequestMapping(value="JR_list.do", method=RequestMethod.GET)
    public ModelAndView list(ModelMap model) {

        return responseJson(model, service.list());
    }

    /**
     * 권한그룹 상세정보
     */
    @RequestMapping(value="AR_view.do", method=RequestMethod.POST)
    public void view(AuthBean bean, ModelMap model) {

        if (StringUtil.isEmpty(bean.getAuthCd()))
            model.addAttribute("dataBean", bean);
        else {
            AuthBean dataBean = service.view(bean);            
            model.addAttribute("dataBean", dataBean == null ? bean : dataBean);
        }
    }
    
    /**
     * 권한그룹 등록 액션
     */
    @RequestMapping(value="TR_insertAction.do", method=RequestMethod.POST)
    public ModelAndView insertAction(AuthBean bean, ModelMap model) {

        int affected = service.insertAction(bean);

        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_INSERT_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 권한그룹 수정 액션
     */
    @RequestMapping(value="TR_updateAction.do", method=RequestMethod.POST)
    public ModelAndView updateAction(AuthBean bean, ModelMap model) {

        int affected = service.updateAction(bean);

        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 권한그룹 삭제 액션
     */
    @RequestMapping(value="TR_deleteAction.do", method=RequestMethod.POST)
    public ModelAndView deleteAction(AuthBean bean, ModelMap model) {

        int affected = service.deleteAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_DELETE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
    
    
    /**
     * 권한그룹 대상 메뉴 할당정보 TREE 전체 목록
     */
    @RequestMapping(value="JR_listAuthItemAll.do", method=RequestMethod.GET)
    public ModelAndView listAuthItemAll(AuthBean bean, ModelMap model) {

        if (StringUtil.isEmpty(bean.getAuthCd())) {
            return responseJson(model, "[]", true);
        }
        return responseJson(model, service.listAuthItemAll(bean));
    }
    
    /**
     * 권한그룹 대상 메뉴 할당 CRUD 액션
     */
    @RequestMapping(value="TR_crudAction.do", method=RequestMethod.POST)
    public ModelAndView crudAction(
            @RequestParam(value="authCd") Integer authCd,
            @RequestParam(required=false, value="updates") String[] updates,
            ModelMap model) {

        int affected = service.crudAction(authCd, updates);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
    
    /**
     * 권한그룹 메뉴 할당 정보 팝업
     */
    @RequestMapping(value="PR_listAuthItem.do", method=RequestMethod.GET)
    public void listAuthItem(ModelMap model) {
    }
    
    /**
     * 권한그룹 할당 정보 이력 팝업
     */
    @RequestMapping(value="PR_listAuthAssignLog.do", method=RequestMethod.GET)
    public void listAuthAssignLog(
            @RequestParam(value="mgrId") String mgrId,
            @RequestParam(value="mgrNm") String mgrNm, ModelMap model) {

        model.addAttribute("dataList", service.listAuthAssignLog(mgrId));
    }
}
