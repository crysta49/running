package com.srpost.cm.bo.base.mgr.absence;

import static com.srpost.salmon.constant.StringPool.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.cm.bo.base.login.LoginBean;
import com.srpost.cm.bo.base.mgr.MgrUtil;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.DateTimeUtil;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 내부단 직원 부재중 관리 컨트롤러
 *
 * @author  finkle
 * @date    2014-12-17
 * @since   3.0
 */
@Controller
@RequestMapping(value="/bo/base/mgr/absence")
public class MgrAbsenceController extends BaseController {

    @Resource
    IMgrAbsenceService service;
    
    /**
     * 직원 부재중 관리 메인
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public void index(MgrAbsenceBean bean, HttpServletRequest request, ModelMap model) {
        
        LoginBean loginBean = MgrUtil.getSession(request);
        
        bean.setMgrId(loginBean.getMgrId());
        
        model.addAttribute("dataBean", service.view(bean));
        model.addAttribute("handOverList", service.listMyHandOver(loginBean.getMgrId()));
    }
    
    /**
     * 직원 부재중 등록/수정 폼
     */
    @RequestMapping(value="NR_form.do", method=RequestMethod.GET)
    public void form(MgrAbsenceBean bean, ModelMap model) {

        model.addAttribute("today", DateTimeUtil.getToday());
        
        if (StringUtil.isEmpty(bean.getMgrId()))
            model.addAttribute("dataBean", bean);
        else {
            MgrAbsenceBean dataBean = service.view(bean);            
            model.addAttribute("dataBean", dataBean == null ? bean : dataBean);
        }
    }
    
    /**
     * 직원 부재중 등록 액션
     */
    @RequestMapping(value="TR_insertAction.do", method=RequestMethod.POST)
    public ModelAndView insertAction(MgrAbsenceBean bean, HttpServletRequest request, ModelMap model) {

        bean.setMgrId(MgrUtil.getSession(request).getMgrId());
        
        int affected = service.insertAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_INSERT_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 직원 부재중 수정 액션
     */
    @RequestMapping(value="TR_updateAction.do", method=RequestMethod.POST)
    public ModelAndView updateAction(MgrAbsenceBean bean, HttpServletRequest request, ModelMap model) {

        bean.setMgrId(MgrUtil.getSession(request).getMgrId());
        
        int affected = service.updateAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 직원 부재중 삭제 액션
     */
    @RequestMapping(value="TR_deleteAction.do", method=RequestMethod.POST)
    public ModelAndView deleteAction(MgrAbsenceBean bean, HttpServletRequest request, ModelMap model) {

        bean.setMgrId(MgrUtil.getSession(request).getMgrId());
        
        int affected = service.deleteAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_DELETE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
    
    /**
     * 대리인 지정 팝업창
     */
    @RequestMapping(value="PR_agencyList.do", method=RequestMethod.GET)
    public void agencyList(ModelMap model) {
    }

    /**
     * 대리인 ID 중복체크
     */
    @RequestMapping(value="TR_duplicate.do", method=RequestMethod.GET)
    public ModelAndView duplicate(MgrAbsenceBean bean, ModelMap model) {

        MgrAbsenceBean dataBean = service.viewAgencyId(bean.getAgencyId());
        
        if (dataBean == null)
            return responseText(model, TRUE);
        
        return responseText(model, FALSE);
    }


    /**
     * 부재중 기간 내 중복 요청 목록
     */
    @RequestMapping(value="JR_listAgencyOver.do", method=RequestMethod.GET)
    public ModelAndView listAgencyOver(MgrAbsenceBean bean, ModelMap model) {
        
        return responseJson(model, service.listAgencyOver(bean));
    }
}
