package com.srpost.cm.bo.base.login;

import static com.srpost.salmon.constant.StringPool.Y;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.srpost.cm.bo.base.auth.AuthBean;
import com.srpost.cm.bo.base.auth.AuthDao;
import com.srpost.cm.bo.base.auth.AuthItemBean;
import com.srpost.cm.bo.base.menu.MenuBean;
import com.srpost.cm.bo.base.menu.MenuDao;
import com.srpost.cm.bo.base.mgr.MgrBean;
import com.srpost.cm.bo.base.mgr.MgrDao;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.DateTimeUtil;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.spi.crypto.SalmonCrypto;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 내부단 로그인 서비스 구현체
 *
 * @author  finkle
 * @date    2014-09-26
 * @since   2.0
 */
@Service
public class LoginServiceImpl extends EgovAbstractServiceImpl implements ILoginService {

    @Resource
    MgrDao mgrDao;
    @Resource
    AuthDao authDao;
    @Resource
    MenuDao menuDao;
    @Resource
    SalmonCrypto salmonCrypto;
    
    @Override
    public LoginBean loginAction(MgrBean bean) {
        return loginAction(bean, true);
    }
    
    @Override
    public LoginBean loginAction(MgrBean bean, boolean isCheckPassword) {

        LoginBean loginBean = new LoginBean(mgrDao.view(bean));

        if ( StringUtil.isEmpty(loginBean.getMgrId()) ) {
            loginBean.setMessage(Message.get(Message.BASE_LOGIN_ID_FAIL_KEY));
        }
        else if ( isCheckPassword && !salmonCrypto.matchPassword(bean.getMgrEncPwd(), loginBean.getMgrEncPwd()) ) {
            loginBean.setMessage(Message.get(Message.BASE_LOGIN_PWD_FAIL_KEY));
        }
        else if ( !StringUtil.equals(Y, loginBean.getUseYn()) ) {
            loginBean.setMessage(Message.get(Message.BASE_LOGIN_USE_FAIL_KEY));
        }
        else {
            List<AuthBean> authList = authDao.listAuthByLogin(bean.getMgrId());
            if ( StringUtil.isEmpty(authList) ) {
                loginBean.setMessage(Message.get(Message.BASE_LOGIN_AUTH_FAIL_KEY));
            }
            else {
                loginBean.setAuthList(authList);
                
                loginBean.setAuthItemList(
                    parseAuthItemList(
                        authDao.listAuthItemByLogin(bean.getMgrId())));
                

                List<MenuBean> myMenuList = menuDao.listMyCache(bean.getMgrId());
                
                if ( StringUtil.isEmpty(myMenuList) ) {
                    loginBean.setMessage(Message.get(Message.BASE_LOGIN_AUTH_FAIL_KEY));
                    return loginBean;
                }

                Map<Integer, MenuBean> myMenuMap = menuDao.mapMyCache(bean.getMgrId());
                
                /* 내 메뉴정보 설정 */
                loginBean.setMyMenu( new MyMenuBean(myMenuList, myMenuMap) );
                
                mgrDao.updateLoginAction(bean);
                
                // 접속 시간 설정
                loginBean.setLoginDt(DateTimeUtil.toDateFull(new Date()));
                
                // loginBean.setMgrEncPwd(EMPTY);
            }
        }
        return loginBean;
    }
    
    /**
     * 중복권한 우선순위 기준으로 제거
     */
    private List<AuthItemBean> parseAuthItemList(List<AuthItemBean> list) {
        
        if ( StringUtil.isEmpty(list) ) return list;
        
        Map<Integer, AuthItemBean> authMap = new LinkedHashMap<Integer, AuthItemBean>();
        
        int prevMenuCd = -1;
        int prevCrudPoint = 0;
        
        for (AuthItemBean bean : list) {
            
            if (prevMenuCd != bean.getMenuCd()) {
                prevMenuCd = bean.getMenuCd();
                prevCrudPoint = getCrudPoint(bean);
                
                authMap.put(bean.getMenuCd(), bean);
            }
            else {
                int crudPoint = getCrudPoint(bean);
                if (crudPoint > prevCrudPoint) {
                    authMap.put(bean.getMenuCd(), bean);
                }
            }
        }
        
        return new ArrayList<AuthItemBean>(authMap.values());
    }
    
    /**
     * 우선순위 점수 얻기
     * 읽기 : 1점, 생성 : 2점, 수정, 삭제 : 3점
     */
    private int getCrudPoint(AuthItemBean bean) {
        
        int crudPoint = 0;
        
        if ( StringUtil.equals(bean.getReadYn(), Y) ) crudPoint += 1;
        if ( StringUtil.equals(bean.getCreateYn(), Y) ) crudPoint += 2;
        if ( StringUtil.equals(bean.getUpdateYn(), Y) ) crudPoint += 3;
        if ( StringUtil.equals(bean.getDeleteYn(), Y) ) crudPoint += 3;
        
        return crudPoint;
    }
}
