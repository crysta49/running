package com.srpost.cm.fe2.login;

import static com.srpost.salmon.constant.StringPool.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.srpost.cm.bo.base.user.IUserService;
import com.srpost.cm.bo.base.user.UserBean;
import com.srpost.cm.bo.base.user.UserUtil;
import com.srpost.salmon.constant.Constant;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.CookieUtil;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.spi.crypto.SalmonCrypto;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 고객단 로그인 컨트롤러
 *
 * @author  finkle
 * @date    2015-02-06
 * @since   2.0
 */
@Controller
@RequestMapping(value="/fe2/login")
public class Fe2LoginController extends BaseController {

    @Resource
    IUserService service;
    @Resource
    SalmonCrypto salmonCtypto;
    
    private static final String RETURN_URI_KEY = "__RETURN_URI_KEY__";
    private static final String SESSION_ID_KEY = "__SESSION_ID_KEY__";
    
    /**
     * 로그인 메인
     */
    @RequestMapping(value="NR_index.do")
    public String index(ModelMap model, HttpServletRequest request) {

        if ( UserUtil.hasSession(request) ) {
            return "redirect:/front";
        }

        HttpSession session = request.getSession();
        session.setAttribute(SESSION_ID_KEY, session.getId());
        
        model.addAttribute(RETURN_URI_KEY, request.getHeader("referer"));
        model.addAttribute("cookieUserId", CookieUtil.getCookie(request, "_userId_"));
        
        return baseUrl + "/NR_index";
    }
    
    /**
     * 로그인 액션
     */
    @RequestMapping(value="TR_loginAction.do", method=RequestMethod.POST)
    public ModelAndView loginAction(UserBean bean, HttpServletRequest request, 
            HttpServletResponse response, ModelMap model) {

        HttpSession session = request.getSession();
        
        /*--
        if ( LoginUtil.isExceedLoginAction(session) ) {
            model.addFlashAttribute("message", 
                    Message.get(Message.BASE_LOGIN_LIMIT_FAIL_KEY));
            
            return "redirect:/fe/base/login/NR_index.do";
        } --*/

        String refererUri = request.getHeader("referer");

        if (refererUri.indexOf("/fe/base/login/NR_index.do") == -1) {
            return responseText(model, Message.fail(Message.COMMON_ACCESS_FAIL_KEY));
        }
        
        String sessionId = (String)session.getAttribute(SESSION_ID_KEY);
        if ( StringUtil.isEmpty(sessionId) ) {
            return responseText(model, Message.fail(Message.COMMON_ACCESS_FAIL_KEY));
        }
        
        UserBean dataBean = service.view(bean);
        
        if ( dataBean == null ) {
            return responseText(model, Message.fail(Message.BASE_LOGIN_FAIL_KEY));
        }
        else {
            if ( StringUtil.equals(dataBean.getUseYn(), N) ) {
                return responseText(model, Message.fail(Message.BASE_LOGIN_FAIL_KEY));
            }
            if ( !salmonCtypto.matchPassword(bean.getUserEncPwd(), dataBean.getUserEncPwd()) ) {
                return responseText(model, Message.fail(Message.BASE_LOGIN_FAIL_KEY));
            }
        }
        
        CookieUtil.setCookie(response, "_userId_", bean.getUserId(), 60*24*365); // 1 year

        UserUtil.setSession(session, dataBean);
        
        // LoginUtil.clearSession(session);

        session.removeAttribute(SESSION_ID_KEY);
        
        return responseText(model, Message.SUCCESS);
        
        /*--
        if ( StringUtil.isNotEmpty(returnUri) ) {
            session.removeAttribute(RETURN_URI_KEY);
            return "redirect:" + returnUri;
        }
        return "/fe/contents/main/NR_index";
        --*/
    }
    
    /**
     * 로그아웃 액션
     */
    @RequestMapping(value="NR_logoutAction.do", method=RequestMethod.GET)
    public String logoutAction(HttpSession session, RedirectAttributes model) {

        UserUtil.removeSession(session);
        session.invalidate();

        model.addFlashAttribute("isLogout", Boolean.valueOf(true));
        
        return "redirect:/front";
    }
    
    /**
     * 테스트 사용자 로그인
     */
    @RequestMapping(value="NR_testLogin.do", method=RequestMethod.POST)
    public ModelAndView testLogin(UserBean bean, ModelMap model, HttpSession session) {

        UserBean dataBean = service.view(bean);
        
        if (dataBean != null)
            session.setAttribute(Constant.USER_SESSION_KEY, dataBean);

        return responseText(model, "");
    }
}
