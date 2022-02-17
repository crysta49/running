package com.srpost.cm.bo.base.schd;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.cm.bo.base.mgr.absence.MgrAbsenceCheckScheduler;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.scheduelr.MultipleCacheReloadScheduler;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 스케줄러 조작용 컨트롤러
 *
 * @author  finkle
 * @date    2014-11-14
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/schd")
public class SchdController extends BaseController {
    
    @Resource
    MultipleCacheReloadScheduler multipleCacheReloadScheduler;
    @Resource
    MgrAbsenceCheckScheduler mgrAbsenceCheckScheduler;
    
    /**
     * 메인
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public void index(HttpServletRequest request, ModelMap model) {
    }
    
    /**
     * 스케줄러 실행 액션
     */
    @RequestMapping(value="TR_executeAction.do", method=RequestMethod.POST)
    public ModelAndView insertAction(
            @RequestParam(value="schdNm") String schdNm, ModelMap model) {

        if (StringUtil.equals(schdNm, "multipleCacheReloadScheduler")) {
            
            multipleCacheReloadScheduler.doSchedule();
        }
        else if (StringUtil.equals(schdNm, "mgrAbsenceCheckScheduler")) {
            
            mgrAbsenceCheckScheduler.doSchedule();
        }
        
        return responseText(model, "요청을 성공적으로 처리했습니다.");
    }
}
