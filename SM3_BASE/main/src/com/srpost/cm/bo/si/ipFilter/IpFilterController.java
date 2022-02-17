package com.srpost.cm.bo.si.ipFilter;

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
 * 내부단 IP Filter 정보 컨트롤러
 *
 */
@Controller
@RequestMapping(value="/bo/si/ipFilter")
public class IpFilterController extends BaseController {
    
    @Resource
    IIpFilterService service;
    
    
    /**
     * IP Filter 메인
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public void index() {
    }
    
    /**
     * IP Filter 목록
     */
    @RequestMapping(value="JR_list.do", method=RequestMethod.GET)
    public ModelAndView list(IpFilterBean bean, ModelMap model) {
        
        return responseJson(model, service.list(bean));
    }
    
    /**
     * IP Filter 상세정보
     */
    @RequestMapping(value="AR_view.do", method=RequestMethod.POST)
    public String view(IpFilterBean bean, ModelMap model) {
        
        IpFilterBean dataBean = service.view(bean);
        
        if ( StringUtil.isEmpty(dataBean) ) {
            return alertAndBack(model, Message.COMMON_NODATA_FAIL_KEY);
        }
        
        model.addAttribute("dataBean", dataBean);
        
        return baseUrl + "/AR_view";
    }
    
    /**
     * IP Filter 등록/수정 폼
     */
    @RequestMapping(value="AR_form.do", method=RequestMethod.POST)
    public String form(IpFilterBean bean, ModelMap model) {
        
        IpFilterBean dataBean = service.view(bean);
        
        model.addAttribute("dataBean", dataBean == null ? bean : dataBean);
        
        return baseUrl + "/AR_form";
    }
    
    /**
     * IP Filter 등록 액션
     */
    @RequestMapping(value="TR_insertAction.do", method=RequestMethod.POST)
    public ModelAndView insertAction(IpFilterBean bean, ModelMap model) {
        
        int affected = service.insertAction(bean);
        
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_INSERT_SUCCESS_KEY));
        }
        
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
    
    /**
     * IP Filter 수정 액션
     */
    @RequestMapping(value="TR_updateAction.do", method=RequestMethod.POST)
    public ModelAndView updateAction(IpFilterBean bean, ModelMap model) {
        
        int affected = service.updateAction(bean);
        
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
    
    /**
     * IP Filter 삭제 액션
     */
    @RequestMapping(value="TR_deleteAction.do", method=RequestMethod.POST)
    public ModelAndView deleteAction(IpFilterBean bean, ModelMap model) {
        
        int affected = service.deleteAction(bean);
        
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_DELETE_SUCCESS_KEY));
        }
        
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
    
}