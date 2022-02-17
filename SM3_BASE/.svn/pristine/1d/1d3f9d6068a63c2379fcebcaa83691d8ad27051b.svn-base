package com.srpost.cm.bo.base.bbs.ntc;

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

import com.srpost.salmon.bean.BaseFileBean;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.FileUtil;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.web.mvc.controller.BaseController;

import static com.srpost.salmon.constant.StringPool.ONE;

/**
 * 내부단 게시판 공지글 컨트롤러
 *
 * @author  finkle
 * @date    2014-11-17
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/bbs/ntc")
public class BbsNtcController extends BaseController {

	@Resource
	IBbsNtcService service;
    
	/**
     * 게시판 공지글 메인
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public void index(BbsNtcBean bean, HttpServletRequest request, ModelMap model) {
        
        model.addAttribute("bbsList", BbsNtcUtil.confList());
    }
    
    /**
     * 게시판 공지글 목록
     */
    @RequestMapping(value="JR_list.do", method=RequestMethod.GET)
    public ModelAndView list(BbsNtcBean bean, ModelMap model) {

        return responseJson(model, service.list(bean));
    }
    
    /**
     * 게시판 공지글 상세정보
     */
    @RequestMapping(value="AR_view.do", method=RequestMethod.POST)
    public String view(BbsNtcBean bean, HttpServletRequest request, HttpServletResponse response, ModelMap model) {

        BbsNtcBean dataBean = service.view(bean, BbsNtcUtil.needUpdateReadCnt(bean, request, response));
        
        model.addAttribute("dataBean", dataBean);

        model.addAttribute("hasAuth", 
                BbsNtcUtil.hasAuth(request, dataBean.getMgrId()) || 
                BbsNtcUtil.hasAuth(request, bean.getBbsCd()));
        
        return baseUrl + "/AR_view";
    }
    
    /**
     * 게시판 공지글 등록/수정 폼
     */
    @RequestMapping(value="AR_form.do", method=RequestMethod.POST)
    public void form(BbsNtcBean bean, HttpServletRequest request, ModelMap model) {

        model.addAttribute("bbsList", BbsNtcUtil.confList());
        
        if (StringUtil.isEmpty(bean.getNtcSeq()))
            model.addAttribute("dataBean", bean);
        else {
            BbsNtcBean dataBean = service.view(bean, false);            
            model.addAttribute("dataBean", dataBean == null ? bean : dataBean);
        }
    }
    
    /**
     * 게시판 공지글 등록 액션
     */
    @RequestMapping(value="TR_insertAction.do", method=RequestMethod.POST)
    public ModelAndView insertAction(BbsNtcBean bean, HttpServletRequest request, ModelMap model) {

        List<BaseFileBean> fileList = FileUtil.getUploadFile(request);
        bean.setFileList(fileList);

        int affected = service.insertAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_INSERT_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 게시판 공지글 수정 액션
     */
    @RequestMapping(value="TR_updateAction.do", method=RequestMethod.POST)
    public ModelAndView updateAction(BbsNtcBean bean, HttpServletRequest request, ModelMap model) {
        
        List<BaseFileBean> fileList = FileUtil.getUploadFile(request);
        bean.setFileList(fileList);

        int affected = service.updateAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 게시판 공지글 삭제 액션
     */
    @RequestMapping(value="TR_deleteAction.do", method=RequestMethod.POST)
    public ModelAndView deleteAction(BbsNtcBean bean, ModelMap model) {

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
    public void excelForm(BbsNtcBean bean, ModelMap model) {
    }
    
    /**
     * 엑셀 변환 액션
     */
    @RequestMapping(value="XR_excelAction.do", method=RequestMethod.POST)
    public ModelAndView excelAction(BbsNtcBean bean, ModelMap model) {

        List<Map<String, Object>> dataList = service.listExcel(bean);

        return responseExcel(model, dataList, bean);
    }
}
