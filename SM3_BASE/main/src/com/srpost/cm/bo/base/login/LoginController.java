package com.srpost.cm.bo.base.login;

import java.security.KeyPair;
import java.security.PrivateKey;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.srpost.cm.bo.base.login.log.ILoginLogService;
import com.srpost.cm.bo.base.login.log.LoginLogBean;
import com.srpost.cm.bo.base.mgr.MgrBean;
import com.srpost.cm.bo.base.mgr.MgrUtil;
import com.srpost.cm.bo.base.mgr.absence.IMgrAbsenceService;
import com.srpost.salmon.constant.Constant;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.CookieUtil;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.spi.crypto.RSAUtils;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 내부단 로그인 컨트롤러
 *
 * @author  finkle
 * @date    2014-09-26
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/login")
public class LoginController extends BaseController {

    @Resource
    ILoginService service;
    @Resource
    ILoginLogService loginLogService;
    @Resource
    IMgrAbsenceService mgrAbsenceService;
    
    /**
     * 로그인 폼
     */
    @RequestMapping(value="NR_loginForm.do")
    public String loginForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) {

        if ( MgrUtil.hasSession(request) ) {
            return "redirect:/explorer";
        }
        
        model.addAttribute("cookieMgrId", CookieUtil.getCookie(request, "_mgrId_"));
        
        return baseUrl + "/NR_loginForm";
    }
    
    /**
     * RSA 공개키 얻기
     */
    @RequestMapping(value="TR_publicKey.do")
    public ModelAndView getPublicKey(ModelMap model, HttpServletRequest request) {

        /* FIXME : 로그인폼을 제외한 다른페이지(로그인된상태)에서 빠른 로그인 안됨
        if ( MgrUtil.hasSession(request) ) {
            return responseText(model, Message.success(Message.COMMON_NOSUPPORT_FAIL_KEY));
        }
        */
        KeyPair keyPair = RSAUtils.generateKeyPair();
        request.getSession().setAttribute(Constant.RSA_RIVATE_KEY, keyPair.getPrivate());

        String publicKey = Base64.encodeBase64String(keyPair.getPublic().getEncoded());
        
        return responseText(model, publicKey);
    }
    
    /**
     * 로그인 액션
     */
    @RequestMapping(value="NR_loginAction.do", method=RequestMethod.POST)
    public synchronized String loginAction(
            @RequestParam(value="isQuickLogin", required=false) boolean isQuickLogin, 
            MgrBean bean, HttpServletRequest request, 
            HttpServletResponse response, RedirectAttributes model) {

        HttpSession session = request.getSession();
        
        if ( LoginUtil.isExceedLoginAction(session) ) {
            model.addFlashAttribute("message", 
                    Message.get(Message.BASE_LOGIN_LIMIT_FAIL_KEY));
            
            return "redirect:/login";
        }
        
        // TODO : 시스템 관리자 로그인 시도 시 알림
        
        
        // 로그인 입력정보 복호화
        PrivateKey privateKey = (PrivateKey)session.getAttribute(Constant.RSA_RIVATE_KEY);

        try {
            bean.setMgrId( RSAUtils.decrypt(bean.getMgrId(), privateKey) );
            bean.setMgrEncPwd( RSAUtils.decrypt(bean.getMgrEncPwd(), privateKey) );
        }
        catch(Exception e) {
            model.addFlashAttribute("message", e.toString());            
            return "redirect:/login";
        }
        
        // TODO : 부재중 사용자 로그인 시 부재중 정보 삭제하시겠습니까? 묻는 팝업창 표시하면 좋을 듯.
        
        LoginBean dataBean = service.loginAction(bean);
        
        if ( StringUtil.isNotEmpty(dataBean.getMessage()) ) {
            model.addFlashAttribute("message", dataBean.getMessage());
            return "redirect:/login";
        }

        dataBean.setLoginIp(request.getRemoteAddr());
        dataBean.setUserAgent(request.getHeader("User-Agent"));

        CookieUtil.setCookie(response, "_mgrId_", bean.getMgrId(), 60*24*365); // 1 year
        
        // 업무 대리 위탁자 목록 설정
        dataBean.setHandOverList(mgrAbsenceService.listMyHandOver(dataBean.getMgrId()));
        
        MgrUtil.setSession(session, dataBean);
        
        LoginUtil.clearSession(session);
        
        loginLogService.loginAction(new LoginLogBean(dataBean, request.getRemoteAddr()));
        
        if (isQuickLogin) {
            LoginUtil.removeAllSession(session, dataBean.getMgrId());
        }

        logger.info( "LOGIN : {}, {}", dataBean.getMgrId(), dataBean.getLoginIp() );
        
        String returnPage = LoginUtil.checkMultiSession(request, dataBean);
        if ( StringUtil.isNotEmpty(returnPage) ) {
            return returnPage;
        }
        
        return "redirect:/explorer";
    }
    
    /**
     * 대리인 로그인 액션
     */
    @RequestMapping(value="NR_agencyLoginAction.do", method=RequestMethod.POST)
    public String agencyLoginAction(MgrBean bean, HttpSession session, HttpServletRequest request,
            HttpServletResponse response, RedirectAttributes model) {
        
        if ( !MgrUtil.hasSession(session) ) {
            model.addFlashAttribute("message", 
                    Message.get(Message.COMMON_ACCESS_FAIL_KEY));
            
            return "redirect:/login";
        }
        
        LoginBean dataBean = service.loginAction(bean, false);
        
        if ( StringUtil.isNotEmpty(dataBean.getMessage()) ) {
            model.addFlashAttribute("message", dataBean.getMessage());
            return "redirect:/login";
        }
        
        // 대리인 정보 설정
        dataBean.setMgrAbsenceBean(mgrAbsenceService.view(dataBean.getMgrId()));
        
        loginLogService.loginAction(new LoginLogBean(dataBean, request.getRemoteAddr()));
        
        MgrUtil.setSession(session, dataBean);

        return "redirect:/explorer";
    }
    
    /**
     * 로그아웃 액션
     */
    @RequestMapping(value="NR_logoutAction.do", method=RequestMethod.GET)
    public String logoutAction(HttpServletRequest request, RedirectAttributes model) {

        HttpSession session = request.getSession();

        LoginBean loginBean = MgrUtil.getSession(request);
        if (loginBean != null) {
            loginLogService.logoutAction(new LoginLogBean(loginBean));
            logger.info( "LOGOUT : {}, {}", loginBean.getMgrId(), request.getRemoteAddr() );
            LoginUtil.removeAllSession(session, loginBean.getMgrId());
        }
        
        MgrUtil.removeSession(session);
        
        session.invalidate();
        
        model.addFlashAttribute("isLogout", Boolean.valueOf(true));
        
        return "redirect:/login";
    }
    
    /**
     * 중복로그인 안내 페이지
     */
    @RequestMapping(value="NR_multiLoginInfo.do", method=RequestMethod.GET)
    public String multiLoginInfo(HttpServletRequest request, ModelMap model) {
        
        LoginBean loginBean = MgrUtil.getSession(request);
        
        if (loginBean == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("dataBean", 
                MultiLoginPreventor.getSessionObject(loginBean.getMgrId()));
        
        return baseUrl + "/NR_multiLoginInfo";
    }
    
    /**
     * 중복로그인 판단 액션 : 이전 로그인 정보 제거 후 초기화면으로 이동
     */
    @RequestMapping(value="NR_removeOldSessionAndMoveExplorer.do", method=RequestMethod.GET)
    public String removeOldSessionAndMoveExplorer(HttpServletRequest request) {

        boolean isSameSession = false;
        
        HttpSession session = request.getSession();
        
        LoginBean loginBean = MgrUtil.getSession(request);
        
        if (loginBean != null) {
            HttpSession oldSession = MultiLoginPreventor.getSession(loginBean.getMgrId());

            if (session == oldSession) {
                isSameSession = true;
            }
            if (oldSession != null && !isSameSession) {
                oldSession.invalidate();
            }
        }
        
        LoginUtil.setSession(session);
        if (loginBean != null && !isSameSession) {
            LoginUtil.setSession(session, loginBean.getMgrId());
        }
        
        return "redirect:/explorer";
    }
    
    /**
     * 중복로그인 판단 액션 : 이전 로그인 정보 유지 후 로그인 페이지로 이동
     */
    @RequestMapping(value="NR_keepSessionAndMoveLogin.do", method=RequestMethod.GET)
    public String keepSessionAndMoveLogin(HttpServletRequest request) {
        
        LoginBean loginBean = MgrUtil.getSession(request);
        
        HttpSession session = request.getSession();
        
        if (loginBean != null) {
            LoginUtil.removeAllSession(session, loginBean.getMgrId());
        }
        MgrUtil.removeSession(session);
        
        return "redirect:/login";
    }
}
