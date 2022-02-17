package com.srpost.cm.bo.base.login;

import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.beans.BeanUtils;

import com.srpost.cm.bo.base.auth.AuthBean;
import com.srpost.cm.bo.base.auth.AuthItemBean;
import com.srpost.cm.bo.base.mgr.MgrBean;
import com.srpost.cm.bo.base.mgr.absence.MgrAbsenceBean;

/**
 * 내부단 로그인 정보 Bean
 *
 * @author  finkle
 * @date    2014-11-12
 * @since   2.0
 */
@Alias("loginBean")
@SuppressWarnings("serial")
public class LoginBean extends MgrBean {

    /** 로그인 IP */
    private String loginIp;
    /** 사용 브라우저 */
    private String userAgent;
    /** 로그인 결과 메시지 */
    private String message;
    /** 권한그룹 목록 */
    private List<AuthBean> authList;
    /** 권한 아이템 목록 */
    private List<AuthItemBean> authItemList;
    /** 대리인 위탁(인계)자 목록 */
    private List<MgrAbsenceBean> handOverList;
    /** 대리인 정보 */
    private MgrAbsenceBean mgrAbsenceBean;
    /** 내 메뉴 정보 */
    private MyMenuBean myMenu;
    
    /** 로그인 로그 일련번호 */
    private Long loginLogSeq;
    
    
    public LoginBean() {
    }
    public LoginBean(MgrBean bean) {
        if (bean != null)
            BeanUtils.copyProperties(bean, this);
    }

    public String getLoginIp() {
        return loginIp;
    }
    public void setLoginIp(String loginIp) {
        this.loginIp = loginIp;
    }
    public String getUserAgent() {
        return userAgent;
    }
    public void setUserAgent(String userAgent) {
        this.userAgent = userAgent;
    }
    public List<AuthBean> getAuthList() {
        return authList;
    }
    public void setAuthList(List<AuthBean> authList) {
        this.authList = authList;
    }
    public List<AuthItemBean> getAuthItemList() {
        return authItemList;
    }
    public void setAuthItemList(List<AuthItemBean> authItemList) {
        this.authItemList = authItemList;
    }
    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }
    public MgrAbsenceBean getMgrAbsenceBean() {
        return mgrAbsenceBean;
    }
    public void setMgrAbsenceBean(MgrAbsenceBean mgrAbsenceBean) {
        this.mgrAbsenceBean = mgrAbsenceBean;
    }
    public List<MgrAbsenceBean> getHandOverList() {
        return handOverList;
    }
    public void setHandOverList(List<MgrAbsenceBean> handOverList) {
        this.handOverList = handOverList;
    }
    public MyMenuBean getMyMenu() {
        return myMenu;
    }
    public void setMyMenu(MyMenuBean myMenu) {
        this.myMenu = myMenu;
    }
    public Long getLoginLogSeq() {
        return loginLogSeq;
    }
    public void setLoginLogSeq(Long loginLogSeq) {
        this.loginLogSeq = loginLogSeq;
    }
}
