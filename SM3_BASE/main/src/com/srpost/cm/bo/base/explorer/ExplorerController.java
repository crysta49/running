package com.srpost.cm.bo.base.explorer;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.srpost.cm.bo.base.bbs.conf.BbsConfBean;
import com.srpost.cm.bo.base.bbs.conf.BbsConfUtil;
import com.srpost.cm.bo.base.bbs.core.BbsBean;
import com.srpost.cm.bo.base.bbs.core.BbsUtil;
import com.srpost.cm.bo.base.faq.core.FaqBean;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 내부단 익스플로러 컨트롤러
 *
 * @author  finkle
 * @date    2014-10-22
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/explorer")
public class ExplorerController extends BaseController {
    
    @Resource
    IExplorerService service;
    
    /**
     * 익스플로러
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public void index(ModelMap model) {
        
        // 게시판 새글 등록현황 : 오늘로부터 며칠 전까지 새글로 카운트 할지 파라미터로 넘김 : 3일
        model.addAttribute("recentBbsCount", service.recentBbsCount(3));
        // qna게시판 상태별 갯수 : qna게시판의 bbsCd를 파라미터로 넘김 : 질문답변게시판 3
        model.addAttribute("qnaStatusCount", service.qnaStatusCount(3));
        
        // 자료실
        BbsBean bbsBean = new BbsBean();
        bbsBean.setRowPerPage(4);
        bbsBean.setBbsCd(2);
        model.addAttribute("bbsList", service.listForDashboard(bbsBean, false));
    }
    
    /**
     * 익스플로러 : BBS별 최신목록
     */
    @RequestMapping(value="AR_bbsList.do", method=RequestMethod.GET)
    public void bbsList(HttpServletRequest request, ModelMap model, BbsBean bbsBean) {

        bbsBean.setRowPerPage(4);
        
        if ( bbsBean.getBbsCd() !=null || bbsBean.getBbsCd() >0 ) {
            BbsConfBean confBean = BbsUtil.getConfBean(bbsBean.getBbsCd());
            boolean withStatus = false;
            if ( StringUtil.equals(BbsConfUtil.QNA, confBean.getTypeCd())  ) {
                withStatus = true;
            }
            model.addAttribute("bbsList", service.listForDashboard(bbsBean, withStatus));
        }
    }
    
    /**
     * 익스플로러 : 최근 FAQ 목록
     */
    @RequestMapping(value="AR_faqList.do", method=RequestMethod.GET)
    public void faqList(ModelMap model) {
        
        FaqBean faqBean = new FaqBean();
        faqBean.setRowPerPage(4);
        
        model.addAttribute("faqList", service.listForDashboard(faqBean));
    }
}
