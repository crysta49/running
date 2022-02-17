package com.srpost.cm.fe2.faq;

import static com.srpost.salmon.constant.StringPool.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.cm.bo.base.faq.core.FaqBean;
import com.srpost.cm.bo.base.faq.core.FaqUtil;
import com.srpost.cm.bo.base.faq.core.IFaqService;
import com.srpost.cm.bo.base.faq.ctg.IFaqCtgService;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 고객단 FAQ관리 컨트롤러
 *
 * @author  finkle
 * @date    2015-02-06
 * @since   2.0
 */
@Controller
@RequestMapping(value="/fe2/faq")
public class Fe2FaqController extends BaseController {

    @Resource
    IFaqService service;
    @Resource
    IFaqCtgService ctgService;

    /**
     * FAQ 목록
     */
    @RequestMapping(value="NR_list.do", method=RequestMethod.GET)
    public void list(FaqBean bean, ModelMap model) {
        
        bean.setAprvYn(Y);
        
        model.addAttribute("ctgList", ctgService.listAll());
        model.addAttribute("pagerBean", service.list(bean));
    }

    /**
     * FAQ 상세정보
     */
    @RequestMapping(value="NR_view.do", method=RequestMethod.POST)
    public String view(FaqBean bean, HttpServletRequest request, HttpServletResponse response, ModelMap model) {

        model.addAttribute("dataBean", 
                service.view(bean, FaqUtil.needUpdateReadCnt(bean, request, response)));
        
        return baseUrl + "/NR_view";
    }
    
    /**
     * FAQ 상세정보 (AJAX)
     */
    @RequestMapping(value="AR_view.do", method=RequestMethod.POST)
    public String viewSimple(FaqBean bean, HttpServletRequest request, HttpServletResponse response, ModelMap model) {

        model.addAttribute("dataBean", 
                service.view(bean, FaqUtil.needUpdateReadCnt(bean, request, response)));
        
        return baseUrl + "/AR_view";
    }
    
    /**
     * FAQ 평가 액션
     */
    @RequestMapping(value="TR_scoreAction.do", method=RequestMethod.POST)
    public ModelAndView scoreAction(FaqBean bean, HttpServletRequest request, HttpServletResponse response, ModelMap model) {

        if ( FaqUtil.existScoreCookie(bean, request, response) ) {
            return responseText(model, Message.success("base.faq.score.already.fail"));
        }
        
        int affected = service.scoreAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success("base.faq.score.success"));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
}
