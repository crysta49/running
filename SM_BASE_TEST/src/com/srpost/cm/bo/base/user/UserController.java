package com.srpost.cm.bo.base.user;

import static com.srpost.salmon.constant.StringPool.*;

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

import com.srpost.cm.bo.base.code.CodeCache;
import com.srpost.cm.bo.base.mgr.MgrUtil;
import com.srpost.salmon.cache.Cache;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 고객 정보 컨트롤러
 *
 * @author  finkle
 * @date    2014-11-24
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/user")
public class UserController extends BaseController {

    @Resource
    IUserService service;
    
    /**
     * 고객관리 메인
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public void index(ModelMap model) {
        
        model.addAttribute("typeList", Cache.get(CodeCache.LIST_KEY + "USER_TYPE"));
    }
    
    /**
     * 고객관리 목록
     */
    @RequestMapping(value="JR_list.do", method=RequestMethod.GET)
    public ModelAndView list(UserBean bean, ModelMap model) {

        return responseJson(model, service.list(bean));
    }

    /**
     * 고객관리 상세정보 팝업창
     */
    @RequestMapping(value="PR_view.do", method=RequestMethod.GET)
    public void view(UserBean bean, HttpServletRequest request, ModelMap model) {
        
        UserBean dataBean = service.view(bean, UserUtil.PUP_VIEW);
        
        logger.info( "USER POP-VIEW : {}, {}, {}, {}", 
                MgrUtil.getSession(request).getMgrId(), request.getRemoteAddr(), dataBean.getUserNm(), dataBean.getUserKey() );

        model.addAttribute("dataBean", dataBean);
    }
    
    /**
     * 고객관리 등록/수정 팝업창
     */
    @RequestMapping(value="PR_form.do", method=RequestMethod.GET)
    public void form(UserBean bean, ModelMap model) {

        if (StringUtil.isEmpty(bean.getUserKey()))
            model.addAttribute("dataBean", bean);
        else {
            UserBean dataBean = service.view(bean, UserUtil.PUP_UPDATE);            
            model.addAttribute("dataBean", dataBean == null ? bean : dataBean);
        }
    }
    
    /**
     * 고객관리 등록 액션
     */
    @RequestMapping(value="TR_insertAction.do", method=RequestMethod.POST)
    public ModelAndView insertAction(UserBean bean, ModelMap model) {

        Object newPrimaryKey = service.insertAction(bean);

        if (newPrimaryKey != null) {
            return responseText(model, Message.success(Message.COMMON_INSERT_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 고객관리 수정 액션
     */
    @RequestMapping(value="TR_updateAction.do", method=RequestMethod.POST)
    public ModelAndView updateAction(UserBean bean, HttpServletRequest request, ModelMap model) {

        UserBean dataBean = service.view(bean);
        
        logger.info( "USER MODIFY : {}, {}, {}, {}", 
                MgrUtil.getSession(request).getMgrId(), request.getRemoteAddr(), dataBean.getUserNm(), dataBean.getUserKey() );
        
        int affected = service.updateAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 고객관리 삭제 액션
     */
    @RequestMapping(value="TR_deleteAction.do", method=RequestMethod.POST)
    public ModelAndView deleteAction(UserBean bean, HttpServletRequest request, ModelMap model) {
        
        // 고객코드가 응용테이블에 맵핑되어 있다면 삭제 거부해야 함.
        int userKeyCnt = service.userKeyCnt(bean.getUserKey());
        if ( userKeyCnt > ZERO ) {
            return responseText(model, Message.fail("base.user.child.fail"));
        }

        UserBean dataBean = service.view(bean);
        
        logger.info( "USER DELETE : {}, {}, {}, {}", 
                MgrUtil.getSession(request).getMgrId(), request.getRemoteAddr(), dataBean.getUserNm(), dataBean.getUserKey() );
        
        int affected = service.deleteAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_DELETE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }

    /**
     * 고객 ID 중복체크
     */
    @RequestMapping(value="TR_duplicate.do", method=RequestMethod.GET)
    public ModelAndView duplicate(UserBean bean, ModelMap model) {

        UserBean dataBean = service.view(bean);
        
        if (dataBean == null)
            return responseText(model, TRUE);
        
        return responseText(model, FALSE);
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
    public ModelAndView excelAction(UserBean bean, ModelMap model) {

        List<Map<String, Object>> dataList = service.listExcel(bean);

        return responseExcel(model, dataList, bean);
    }
    
    /**
     * 고객정보 조회 이력 팝업
     */
    @RequestMapping(value="PR_listLog.do", method=RequestMethod.GET)
    public void listAuthAssignLog(
            @RequestParam(value="userKey") String userKey,
            @RequestParam(value="userNm") String userNm, ModelMap model) {
        
        model.addAttribute("dataList", service.listLog(userKey));
    }
    
    
    /**
     * 고객 개인정보 수정 폼
     */
    @RequestMapping(value="NR_formSelf.do", method=RequestMethod.GET)
    public void formSelf(HttpServletRequest request, UserBean bean, ModelMap model) {

        bean.setUserKey(UserUtil.getSession(request).getUserKey());
        
        model.addAttribute("dataBean", service.view(bean));
    }
    
    /**
     * 고객 개인정보 수정 액션
     */
    @RequestMapping(value="TR_updateSelfAction.do", method=RequestMethod.POST)
    public ModelAndView updateSelfAction(HttpServletRequest request, UserBean bean, ModelMap model) {

        bean.setUserKey(UserUtil.getSession(request).getUserKey());
        
        int affected = service.updateAction(bean);
        if (affected == ONE) {
            return responseText(model, Message.success(Message.COMMON_UPDATE_SUCCESS_KEY));
        }
        return responseText(model, Message.fail(Message.COMMON_CRUD_FAIL_KEY));
    }
    


    /**
     * 고객관리 상세정보 JSON
     */
    @RequestMapping(value="JR_view.do", method=RequestMethod.GET)
    public ModelAndView viewJSON(UserBean bean, HttpServletRequest request, ModelMap model) {

        UserBean dataBean = service.view(bean);
        
        logger.info( "USER SEARCH : {}, {}, {}, {}", 
                MgrUtil.getSession(request).getMgrId(), request.getRemoteAddr(), dataBean.getUserNm(), dataBean.getUserKey() );
        
        return responseJson(model, dataBean);
    }
}
