package com.srpost.cm.bo.base.login.log;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.cm.bo.base.mgr.IMgrService;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 내부단 로그인 로그 컨트롤러
 *
 * @author  finkle
 * @date    2014-09-26
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/login/log")
public class LoginLogController extends BaseController {

    @Resource
    ILoginLogService service;
    @Resource
    IMgrService mgrService;
    
    /**
     * 로그인 로그 메인
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public void index() {
    }
    
    /**
     * 로그인 로그 목록
     */
    @RequestMapping(value="JR_list.do", method=RequestMethod.GET)
    public ModelAndView list(LoginLogBean bean, ModelMap model) {
        
        return responseJson(model, service.list(bean));
    }

    /**
     * 로그인 로그 담당자 상세정보
     */
    @RequestMapping(value="AR_view.do", method=RequestMethod.POST)
    public void view(LoginLogBean bean, ModelMap model) {

        model.addAttribute("dataBean", mgrService.view(bean.getMgrId()));
    }
    
    /**
     * 엑셀 변환 팝업창
     */
    @RequestMapping(value="PR_excelForm.do", method=RequestMethod.GET)
    public void excelForm() {
    }
    
    /**
     * 엑셀 변환 액션
     */
    @RequestMapping(value="XR_excelAction.do", method=RequestMethod.POST)
    public ModelAndView excelAction(LoginLogBean bean, ModelMap model) {

        List<Map<String, Object>> dataList = service.listExcel(bean);

        return responseExcel(model, dataList, bean);
    }
}
