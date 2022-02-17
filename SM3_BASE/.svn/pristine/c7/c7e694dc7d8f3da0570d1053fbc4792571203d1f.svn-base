package com.srpost.cm.bo.base.errlog;

import static com.srpost.salmon.constant.StringPool.*;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.salmon.constant.Message;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 내부단 에러로그 컨트롤러
 *
 * @author  finkle
 * @date    2014-10-27
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/errlog")
public class ErrLogController extends BaseController {

    @Resource
    IErrLogService service;

    /**
     * 에러로그 메인
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public void index() {
    }
    
    /**
     * 에러로그 목록
     */
    @RequestMapping(value="JR_list.do", method=RequestMethod.GET)
    public ModelAndView list(ErrLogBean bean, ModelMap model) {
        
        return responseJson(model, service.list(bean));
    }

    /**
     * 에러로그 상세정보
     */
    @RequestMapping(value="AR_view.do", method=RequestMethod.POST)
    public void view(ErrLogBean bean, ModelMap model) {

        model.addAttribute("dataBean", service.view(bean));
    }

    /**
     * 에러로그 수정 액션
     */
    @RequestMapping(value="TR_updateAction.do", method=RequestMethod.POST)
    public ModelAndView updateAction(ErrLogBean bean, ModelMap model) {

        int affected = service.updateAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 에러로그 삭제 액션
     */
    @RequestMapping(value="TR_deleteAction.do", method=RequestMethod.POST)
    public ModelAndView deleteAction(ErrLogBean bean, ModelMap model) {

        int affected = service.deleteAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_DELETE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
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
    public ModelAndView excelAction(ErrLogBean bean, ModelMap model) {

    	List<Map<String, Object>> dataList = service.listExcel(bean);

        return responseExcel(model, dataList, bean);
    }
}
