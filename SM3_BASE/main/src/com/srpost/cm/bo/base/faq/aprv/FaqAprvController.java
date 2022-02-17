package com.srpost.cm.bo.base.faq.aprv;

import static com.srpost.salmon.constant.StringPool.ONE;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.cm.bo.base.faq.core.FaqBean;
import com.srpost.cm.bo.base.faq.core.FaqController;
import com.srpost.cm.bo.base.faq.core.FaqUtil;
import com.srpost.salmon.bean.BaseFileBean;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.FileUtil;
import com.srpost.salmon.lang.StringUtil;

/**
 * 내부단 FAQ승인 컨트롤러
 *
 * @author  finkle
 * @date    2014-11-20
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/faq/aprv")
public class FaqAprvController extends FaqController {
    
    /**
     * FAQ관리 상세정보
     */
    @RequestMapping(value="NR_view.do", method=RequestMethod.GET)
    public String view(FaqBean bean, HttpServletRequest request, HttpServletResponse response, ModelMap model) {

        model.addAttribute("dataBean", 
                service.view(bean, FaqUtil.needUpdateReadCnt(bean, request, response)));
        
        return baseUrl + "/NR_view";
    }
    
    /**
     * FAQ관리 등록/수정 폼
     */
    @RequestMapping(value="NR_form.do", method=RequestMethod.GET)
    public void form(FaqBean bean, ModelMap model) {

        model.addAttribute("ctgList", ctgService.listAll());
        
        if (StringUtil.isEmpty(bean.getSeq()))
            model.addAttribute("dataBean", bean);
        else {
            FaqBean dataBean = service.view(bean, false);            
            model.addAttribute("dataBean", dataBean == null ? bean : dataBean);
        }
    }
    
    /**
     * FAQ관리 등록 액션
     */
    @RequestMapping(value="TR_insertAction.do", method=RequestMethod.POST)
    public ModelAndView insertAction(FaqBean bean, HttpServletRequest request, ModelMap model) {
        
        List<BaseFileBean> fileList = FileUtil.getUploadFile(request);
        bean.setFileList(fileList);
        
        int affected = service.insertAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_INSERT_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * FAQ관리 수정 액션
     */
    @RequestMapping(value="TR_updateAction.do", method=RequestMethod.POST)
    public ModelAndView updateAction(FaqBean bean, HttpServletRequest request, ModelMap model) {

        List<BaseFileBean> fileList = FileUtil.getUploadFile(request);
        bean.setFileList(fileList);
        
        int affected = service.updateAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * FAQ관리 삭제 액션
     */
    @RequestMapping(value="TR_deleteAction.do", method=RequestMethod.POST)
    public ModelAndView deleteAction(FaqBean bean, ModelMap model) {

        int affected = service.deleteAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_DELETE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
    
    /**
     * FAQ 승인/승인취소 액션
     */
    @RequestMapping(value="TR_aprvAction.do", method=RequestMethod.POST)
    public ModelAndView aprvAction(FaqBean bean, ModelMap model) {

        int affected = service.aprvAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
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
    public ModelAndView excelAction(FaqBean bean, ModelMap model) {

        List<Map<String, Object>> dataList = service.listExcel(bean);

        return responseExcel(model, dataList, bean);
    }
}
