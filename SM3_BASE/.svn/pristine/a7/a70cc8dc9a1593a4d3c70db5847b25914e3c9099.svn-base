package com.srpost.cm.bo.base.menu;

import static com.srpost.salmon.constant.StringPool.*;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.srpost.cm.bo.base.auth.AuthBean;
import com.srpost.cm.bo.base.auth.AuthItemBean;
import com.srpost.cm.bo.base.menu.front.MenuFrontBean;
import com.srpost.salmon.constant.Constant;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.spi.egov.ISalmonSeqGenerator;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 내부단 메뉴관리 DAO
 *
 * @author  finkle
 * @date    2014-10-14
 * @since   2.0
 */
@Repository
public class MenuDao extends EgovAbstractMapper {
    
    @Resource(name = "menuSeqGenerator")
    ISalmonSeqGenerator seqGenerator;

    public List<MenuBean> list(MenuBean bean) {
        
        return selectList("_menu.list", bean);
    }
    
    public MenuBean view(MenuBean bean) {
        
        MenuBean dataBean = (MenuBean)selectOne("_menu.view", bean);
        
        if (dataBean != null) {
            List<AuthBean> authList = 
                    selectList("_auth.listAuthByMenu", bean.getMenuCd());
            dataBean.setAuthList(authList);
        }
        
        return dataBean;
    }
    
    public synchronized Object insertAction(MenuBean bean) {

        bean.setMenuCd(seqGenerator.getNextInteger());
        
        int affected = insert("_menu.insert", bean);
        if (affected == ONE) {
            
            AuthItemBean authItemBean = new AuthItemBean();
            authItemBean.setAuthCd(Constant.SYSTEM_AUTH_CD);
            authItemBean.setMenuCd(bean.getMenuCd());
            authItemBean.setReadYn(Y);
            authItemBean.setCreateYn(Y);
            authItemBean.setUpdateYn(Y);
            authItemBean.setDeleteYn(Y);
            
            insert("_auth.insertAuthItem", authItemBean);
            
            return bean.getMenuCd();
        }
        return null;
    }

    public int updateAction(MenuBean bean) {
        
        // 기본 정보 수정
        if ( bean.getOrderNo() == ZERO ) {

            int affected = update("_menu.update", bean);
            if (affected == ONE)
                update("_menu.updateRecursive", bean);
            
            return affected;
            
        }
        // 정렬 정보 수정
        else {
            
            List<MenuBean> sameLevelList = selectList("_menu.listSameLevel", bean);
            int sameLevelLength = sameLevelList.size();
            
            int newOrderNo = bean.getOrderNo();

            if ( newOrderNo <= ZERO )
                newOrderNo = 1;
            if ( newOrderNo > sameLevelLength )
                newOrderNo = sameLevelLength + 1;
            
            sameLevelList.add(newOrderNo-1, bean);
            sameLevelLength++;
            
            int affected = ZERO;
            
            for (int i=0 ; i < sameLevelLength ; i++) {
                MenuBean sameLevelBean = (MenuBean)sameLevelList.get(i);
                
                sameLevelBean.setOrderNo( i + 1 );
                affected += update("_menu.updateOrder", sameLevelBean);
            }
            
            if ( affected == sameLevelLength ) {
                return ONE;
            }
            else {
                return ZERO;
            }
        }
    }

    public int deleteAction(MenuBean bean) {
        
        return delete("_menu.delete", bean);
    }
    
    public String listAllJSON() {
        
        List<String> dataList = selectList("_menu.listAllJSON", Constant.TOP_MENU_CD);
        
        StringBuilder builder = new StringBuilder(LEFT_SQ_BRACKET);
        for (String item : dataList) {
            builder.append(item);
        }
        builder.append(RIGHT_SQ_BRACKET);
        return builder.toString();
    }
    
    public String listMyAllJSON(MenuBean bean) {
            
        bean.setHighMenuCd(Constant.TOP_MENU_CD);
        
        List<String> dataList = selectList("_menu.listMyAllJSON", bean);
        
        StringBuilder builder = new StringBuilder(LEFT_SQ_BRACKET);
        for (String item : dataList) {
            builder.append(item);
        }
        builder.append(RIGHT_SQ_BRACKET);
        return builder.toString();
    }
    
    
    /*--------------------------------------------------------
     * For LoginSession's MyMenuBean
     *--------------------------------------------------------
     */
    
    public List<MenuBean> listMyCache(String mgrId) {

        MenuBean parameBean = new MenuBean();
        parameBean.setHighMenuCd(Constant.TOP_MENU_CD);
        parameBean.setMgrId(mgrId);
        
        List<MenuBean> menuList = selectList("_menu.listMyCache", parameBean);
        
        listCacheRecursive(menuList, mgrId);
        
        return menuList;
    }
    
    private void listCacheRecursive(List<MenuBean> menuList, String mgrId) {
        
        if (StringUtil.isEmpty(menuList)) return;
        
        for (MenuBean item : menuList) {

            if ( !Boolean.valueOf(item.getLeaf()) ) {
                
                MenuBean parameBean = new MenuFrontBean();
                parameBean.setHighMenuCd(item.getMenuCd());
                parameBean.setMgrId(mgrId);
                
                List<MenuBean> childList = selectList("_menu.listMyCache", parameBean);
                item.setChildren(childList);
                
                listCacheRecursive(childList, mgrId);
            }
        }
    }

    public Map<Integer, MenuBean> mapMyCache(String mgrId) {

        MenuBean parameBean = new MenuBean();
        parameBean.setHighMenuCd(Constant.TOP_MENU_CD);
        parameBean.setMgrId(mgrId);

        return selectMap("_menu.mapMyCache", parameBean, "menuCd");
    }
}
