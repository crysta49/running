package com.srpost.cm.bo.base.mgr;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.cm.bo.base.auth.IAuthService;
import com.srpost.cm.bo.base.login.LoginBean;
import com.srpost.salmon.bean.BaseFileBean;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.FileUtil;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.web.mvc.controller.BaseController;

import static com.srpost.salmon.constant.Constant.IS_DEPT_CONNECT;
import static com.srpost.salmon.constant.StringPool.*;

/**
 * 내부단 직원관리 컨트롤러
 *
 * @author  finkle
 * @date    2014-11-05
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/mgr")
public class MgrController extends BaseController {

    @Resource
    IMgrService service;
    @Resource
    IAuthService authService;
    
    /**
     * 직원관리 메인
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public void index(ModelMap model) {
        
        model.addAttribute("authList", authService.list());
    }
    
    /**
     * 직원관리 목록
     */
    @RequestMapping(value="JR_list.do", method=RequestMethod.GET)
    public ModelAndView list(MgrBean bean, ModelMap model) {

        return responseJson(model, service.list(bean));
    }

    /**
     * 직원관리 상세정보 팝업창
     */
    @RequestMapping(value="PR_view.do", method=RequestMethod.GET)
    public void view(MgrBean bean, ModelMap model) {

        model.addAttribute("dataBean", service.view(bean));
    }
    
    /**
     * 직원관리 등록/수정 팝업창
     */
    @RequestMapping(value="PR_form.do", method=RequestMethod.GET)
    public void form(MgrBean bean, ModelMap model) {

        if (StringUtil.isEmpty(bean.getMgrId()))
            model.addAttribute("dataBean", bean);
        else {
            MgrBean dataBean = service.view(bean);            
            model.addAttribute("dataBean", dataBean == null ? bean : dataBean);
        }
    }
    
    /**
     * 직원관리 권한할당 팝업창
     */
    @RequestMapping(value="PR_authForm.do", method=RequestMethod.GET)
    public void authForm(MgrBean bean, ModelMap model) {

        model.addAttribute("dataList", authService.listAuthAssign(bean.getMgrId()));
    }
    
    /**
     * 직원관리 등록 액션
     */
    @RequestMapping(value="TR_insertAction.do", method=RequestMethod.POST)
    public ModelAndView insertAction(MgrBean bean, ModelMap model) {

        if ( IS_DEPT_CONNECT ) {
            return responseText(model, Message.fail(Message.COMMON_NOSUPPORT_FAIL_KEY));
        }

        Object newPrimaryKey = service.insertAction(bean);

        if (newPrimaryKey != null) {
            return responseText(model, Message.success(Message.COMMON_INSERT_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 직원관리 수정 액션
     */
    @RequestMapping(value="TR_updateAction.do", method=RequestMethod.POST)
    public ModelAndView updateAction(MgrBean bean, ModelMap model) {

        if ( IS_DEPT_CONNECT ) {
            return responseText(model, Message.fail(Message.COMMON_NOSUPPORT_FAIL_KEY));
        }
        
        int affected = service.updateAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 직원관리 삭제 액션
     */
    @RequestMapping(value="TR_deleteAction.do", method=RequestMethod.POST)
    public ModelAndView deleteAction(MgrBean bean, ModelMap model) {

        if ( IS_DEPT_CONNECT ) {
            return responseText(model, Message.fail(Message.COMMON_NOSUPPORT_FAIL_KEY));
        }
        
        // TODO : 직원코드가 응용테이블에 맵핑되어 있다면 삭제 거부해야 함.
        
        int affected = service.deleteAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_DELETE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 직원 ID 중복체크
     */
    @RequestMapping(value="TR_duplicate.do", method=RequestMethod.GET)
    public ModelAndView duplicate(MgrBean bean, ModelMap model) {

        MgrBean dataBean = service.view(bean);
        
        if (dataBean == null)
            return responseText(model, TRUE);
        
        return responseText(model, FALSE);
    }
    
    /**
     * 직원관리 권한할당 팝업창 액션
     */
    @RequestMapping(value="TR_updateAuthAssignAction.do", method=RequestMethod.POST)
    public ModelAndView updateAuthAssignAction(
            @RequestParam(value="mgrId") String mgrId,
            @RequestParam(required=false, value="authCds") String[] authCds,
            ModelMap model) {

        int affected = authService.updateAuthAssignAction(mgrId, authCds);
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
    public ModelAndView excelAction(MgrBean bean, ModelMap model) {

        List<Map<String, Object>> dataList = service.listExcel(bean);

        return responseExcel(model, dataList, bean);
    }
    
    
    /**
     * 직원 개인정보 수정 폼
     */
    @RequestMapping(value="NR_formSelf.do", method=RequestMethod.GET)
    public void formSelf(HttpServletRequest request, MgrBean bean, ModelMap model) {

        bean.setMgrId(MgrUtil.getSession(request).getMgrId());
        
        model.addAttribute("dataBean", service.view(bean));
    }
    
    /**
     * 직원 개인정보 수정 액션
     */
    @RequestMapping(value="TR_updateSelfAction.do", method=RequestMethod.POST)
    public ModelAndView updateSelfAction(HttpServletRequest request, MgrBean bean, ModelMap model) {

        LoginBean loginBean = MgrUtil.getSession(request);
        bean.setMgrId(loginBean.getMgrId());
        
        List<BaseFileBean> fileList = FileUtil.getUploadFile(request);
        if (StringUtil.isNotEmpty(fileList)) {
            BaseFileBean photoBean = fileList.get(ZERO);
            bean.setPhoto( photoBean.getFileUrl() );
        }
        
        int affected = service.updateAction(bean);
        if (affected == ONE) {
            if (StringUtil.isNotEmpty(bean.getPhoto())) {
                loginBean.setPhoto(bean.getPhoto());
            }
            
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
    
    /**
     * 직원 개인정보 사진 삭제 액션
     */
    @RequestMapping(value="TR_photoDeleteAction.do", method=RequestMethod.POST)
    public ModelAndView photoDeleteAction(HttpServletRequest request, MgrBean bean, ModelMap model) {

        LoginBean loignBean = MgrUtil.getSession(request);
        
        bean.setMgrId(loignBean.getMgrId());
        
        int affected = service.photoDeleteAction(bean);
        if (affected == ONE) {
            
            loignBean.setPhoto(MgrUtil.DEFAULT_PHOTO);
            
            return responseText(model, Message.success(Message.COMMON_DELETE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
    
    /**
     * 직원 테마 수정 액션
     */
    @RequestMapping(value="TR_updateThemeAction.do", method=RequestMethod.POST)
    public ModelAndView updateThemeAction(HttpServletRequest request, MgrBean bean, ModelMap model) {

        LoginBean loginBean = MgrUtil.getSession(request);
        
        bean.setMgrId(loginBean.getMgrId());
        
        int affected = service.updateThemeAction(bean);
        if (affected == ONE) {
            // 로그인 세션 테마 정보 업데이트
            loginBean.setTheme(bean.getTheme());
            
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
    
    /**
     * 직원 Popover정보
     */
    @RequestMapping(value="AR_popover.do", method=RequestMethod.GET)
    public void popover(@RequestParam(required=true, value="mgrId") String mgrId, ModelMap model) {

        model.addAttribute("dataBean", service.view(mgrId));
    }
}
