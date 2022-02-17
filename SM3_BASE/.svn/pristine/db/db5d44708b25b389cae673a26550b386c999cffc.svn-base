package com.srpost.cm.fe.login;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.cm.bo.base.user.IUserService;
import com.srpost.cm.bo.base.user.UserBean;
import com.srpost.cm.bo.base.user.UserUtil;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.spi.crypto.SalmonCrypto;
import com.srpost.salmon.web.mvc.controller.BaseController;


/**
 * 고객단 로그인/로그아웃 컨트롤러
 * 
 * @author  finkle
 * @date    2015-12-29
 * @since   2.0
 */
@Controller
@RequestMapping(value="/fe/login")
public class FeLoginController extends BaseController {

    @Resource
    IUserService userService;
    @Resource
    SalmonCrypto salmonCtypto;

	/**
     * 로그인 페이지 메인
     */
	@RequestMapping(value="NR_index.do", method={RequestMethod.GET, RequestMethod.POST})
	public String index(ModelMap model, HttpServletRequest request, HttpSession session) {
		
	    /*--
		UserBean userBean = UserUtil.getSession(request);
		if (userBean != null) {
			return alertAndBack(model, Message.failMessage("이미 로그인 상태입니다."));
		}
		--*/
		
		if ( UserUtil.hasSession(request) ) {
            return "redirect:/front";
        }
		
		String returnUri = request.getHeader("referer");
		request.setAttribute("RETURN_URI", returnUri);
		
		session.setAttribute("SESSION_ID", session.getId());
		
		model.addAttribute("dataBean", new UserBean());
		
		return baseUrl + "/NR_index";
	}

	/**
     * 회원 로그인 액션
     */
    @RequestMapping(value="TR_loginAction.do", method=RequestMethod.POST)
    public ModelAndView loginAction(UserBean bean, HttpServletRequest request, HttpSession session, ModelMap model) {

        if ( !FeLoginUtil.isValidReferer(request) ) {
            return responseText(model, Message.fail(Message.COMMON_ACCESS_FAIL_KEY));
        }
        if ( !FeLoginUtil.isValidLoginInfo(bean) ) {
            return responseText(model, Message.fail(Message.COMMON_PARAM_FAIL_KEY));
        }

        UserBean dataBean = userService.view(bean);

        if ( dataBean == null ) {
        	return responseText(model, Message.fail(Message.BASE_LOGIN_ID_FAIL_KEY));
        }
        else {
        	if ( StringUtil.equals("N", dataBean.getUseYn()) ) {
        		return responseText(model, Message.fail(Message.BASE_LOGIN_USE_FAIL_KEY));
        	}
        	
        	if ( salmonCtypto.matchPassword(bean.getUserEncPwd(), dataBean.getUserEncPwd()) ) {
        		return responseText(model, Message.fail(Message.BASE_LOGIN_PWD_FAIL_KEY));
        	}
        	
        	session.removeAttribute("SESSION_ID");

        	UserUtil.setSession(session, dataBean);
        	
        	return responseText(model, Message.SUCCESS);
        }
    }
    
    /**
     * 로그아웃 액션
     */
	@RequestMapping(value="NR_logoutAction.do", method=RequestMethod.GET)
    public String logoutAction(HttpServletRequest request) {
        
        HttpSession session = request.getSession();
        
        /*--
        Enumeration<?> enumer = session.getAttributeNames();
        while ( enumer.hasMoreElements() ) {
            String key = (String)enumer.nextElement();
            session.removeAttribute(key);
        }
        --*/

        session.removeAttribute("RETURN_URI");
        session.removeAttribute("SESSION_ID");
        UserUtil.removeSession(request);
        
        return "redirect:/front";
    }
}
