package com.srpost.cm.bo.base.bbs.conf;

import static com.srpost.salmon.constant.StringPool.*;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 내부단 게시판설정 컨트롤러
 *
 * @author  finkle
 * @date    2014-11-10
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/bbs/conf")
public class BbsConfController extends BaseController {

    @Resource
    IBbsConfService service;

    /**
     * 게시판설정 메인
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public void index() {
    }
    
    /**
     * 게시판설정 목록
     */
    @RequestMapping(value="JR_list.do", method=RequestMethod.GET)
    public ModelAndView list(BbsConfBean bean, ModelMap model) {
        
        return responseJson(model, service.list(bean));
    }

    /**
     * 게시판설정 상세정보
     */
    @RequestMapping(value="AR_view.do", method=RequestMethod.POST)
    public void view(BbsConfBean bean, ModelMap model) {

        model.addAttribute("dataBean", service.view(bean));
    }
    
    /**
     * 게시판설정 등록/수정 폼
     */
    @RequestMapping(value="AR_form.do", method=RequestMethod.POST)
    public void form(BbsConfBean bean, ModelMap model) {

        if (StringUtil.isEmpty(bean.getBbsCd()))
            model.addAttribute("dataBean", bean);
        else {
            BbsConfBean dataBean = service.view(bean);            
            model.addAttribute("dataBean", dataBean == null ? bean : dataBean);
        }
        
        model.addAttribute("tableList", service.tableList("CO_BBS_EXT_"));
    }
    
    /**
     * 게시판설정 등록 액션
     */
    @RequestMapping(value="TR_insertAction.do", method=RequestMethod.POST)
    public ModelAndView insertAction(BbsConfBean bean,
            @RequestParam(required=false, value="ctgDatas") String[] ctgDatas,
            @RequestParam(required=false, value="mgrDatas") String[] mgrDatas,
            ModelMap model) {

        int affected = service.insertAction(bean, ctgDatas, mgrDatas);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_INSERT_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 게시판설정 수정 액션
     */
    @RequestMapping(value="TR_updateAction.do", method=RequestMethod.POST)
    public ModelAndView updateAction(BbsConfBean bean,
            @RequestParam(required=false, value="ctgDatas") String[] ctgDatas,
            @RequestParam(required=false, value="mgrDatas") String[] mgrDatas,
            ModelMap model) {

        int affected = service.updateAction(bean, ctgDatas, mgrDatas);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 게시판설정 삭제 액션
     */
    @RequestMapping(value="TR_deleteAction.do", method=RequestMethod.POST)
    public ModelAndView deleteAction(BbsConfBean bean, ModelMap model) {

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
    public ModelAndView excelAction(BbsConfBean bean, ModelMap model) {

    	List<Map<String, Object>> dataList = service.listExcel(bean);

        return responseExcel(model, dataList, bean);
    }
    
    
    /**
     * 게시판설정 분류지정 팝업창
     */
    @RequestMapping(value="PR_bbsCtgForm.do", method=RequestMethod.GET)
    public void bbsCtgForm() {
    }
    
    /**
     * 게시판설정 관리자지정 팝업창
     */
    @RequestMapping(value="PR_bbsMgrForm.do", method=RequestMethod.GET)
    public void bbsMgrForm() {
    }
}
