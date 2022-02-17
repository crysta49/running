package com.srpost.cm.bo.base.faq.core;

import static com.srpost.salmon.constant.StringPool.*;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.cm.bo.base.faq.ctg.IFaqCtgService;
import com.srpost.salmon.bean.BaseFileBean;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.FileUtil;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 내부단 FAQ관리 컨트롤러
 *
 * @author  finkle
 * @date    2014-11-20
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/faq/core")
public class FaqController extends BaseController {

    @Resource
    protected IFaqService service;
    @Resource
    protected IFaqCtgService ctgService;
    
    /**
     * FAQ관리 메인
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public void index(FaqBean bean, ModelMap model) {
        
        model.addAttribute("ctgList", ctgService.listAll());
        model.addAttribute("pagerBean", service.list(bean));
    }

    /**
     * FAQ관리 상세정보
     */
    @RequestMapping(value="AR_view.do", method=RequestMethod.POST)
    public String view(FaqBean bean, HttpServletRequest request, HttpServletResponse response, ModelMap model) {

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
            return responseText(model, Message.fail("base.faq.score.already.fail"));
        }
        
        int affected = service.scoreAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success("base.faq.score.success"));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
}
