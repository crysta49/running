package com.srpost.cm.fe.main;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.srpost.cm.bo.base.bbs.core.BbsBean;
import com.srpost.cm.bo.base.bbs.core.IBbsService;
import com.srpost.cm.bo.base.faq.core.FaqBean;
import com.srpost.cm.bo.base.faq.core.FaqUtil;
import com.srpost.cm.bo.base.faq.core.IFaqService;
import com.srpost.salmon.web.mvc.controller.BaseController;

import static com.srpost.salmon.constant.StringPool.Y;

/**
 * 외부단 메인화면 컨트롤러
 * 
 * @author  finkle
 * @date    2015-12-29
 * @since   3.0
 */
@Controller
@RequestMapping(value="/fe/main")
public class FeMainController extends BaseController {

    @Resource
    IFaqService faqService;
    @Resource
    IBbsService bbsService;

    /**
     * 메인화면
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public void index(ModelMap model) {
        
        // 자주하는 질문
        FaqBean faqBean = new FaqBean();
        faqBean.setRowPerPage(10);
        faqBean.setAprvYn(Y);
        faqBean.setSortName(FaqUtil.SORT_BEST);
        
        model.addAttribute("faqList", faqService.listForDashboard(faqBean));
        
        // 공지사항
        BbsBean bbsBean = new BbsBean();
        bbsBean.setBbsCd(2);
        bbsBean.setRowPerPage(3);
        
        model.addAttribute("noticeList", bbsService.listForDashboard(bbsBean));
    }

    /**
     * 이용안내
     */
    @RequestMapping(value="NR_info.do", method=RequestMethod.GET)
    public void info() {
    }
}
