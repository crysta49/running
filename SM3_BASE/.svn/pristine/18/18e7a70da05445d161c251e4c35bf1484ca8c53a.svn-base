package com.srpost.cm.bo.base.menu.front;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.srpost.cm.bo.base.mgr.MgrDao;
import com.srpost.salmon.constant.Constant;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.spi.egov.ISalmonSeqGenerator;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

import static com.srpost.salmon.constant.StringPool.ONE;
import static com.srpost.salmon.constant.StringPool.ZERO;

/**
 * 내부단 프론트 메뉴관리 DAO
 *
 * @author  finkle
 * @date    2014-10-14
 * @since   2.0
 */
@Repository
public class MenuFrontDao extends EgovAbstractMapper {
    
    @Resource(name = "menuFrontSeqGenerator")
    ISalmonSeqGenerator seqGenerator;
    @Resource
    MgrDao mgrDao;
    
    public List<MenuFrontBean> list(MenuFrontBean bean) {
        
        if (bean.getHighMenuCd() == bean.getTopMenuCd())
            bean.setHighMenuCd(bean.getDomainCd());
        
        return selectList("_menuFront.list", bean);
    }
    
    public MenuFrontBean view(MenuFrontBean bean) {
        
        MenuFrontBean dataBean = (MenuFrontBean)selectOne("_menuFront.view", bean);
        
        if (dataBean != null) {
        }
        
        return dataBean;
    }
    
    public synchronized Object insertAction(MenuFrontBean bean) {

        bean.setMenuCd(seqGenerator.getNextInteger());
        
        if (bean.getHighMenuCd() == bean.getTopMenuCd())
            bean.setHighMenuCd(bean.getDomainCd());
        
        int affected = insert("_menuFront.insert", bean);
        if (affected == ONE) {
            return bean.getMenuCd();
        }
        return null;
    }

    public int updateAction(MenuFrontBean bean) {
        
        // 기본 정보 수정
        if ( bean.getOrderNo() == ZERO ) {

            int affected = update("_menuFront.update", bean);
            if (affected == ONE)
                update("_menuFront.updateRecursive", bean);
            
            return affected;
            
        }
        // 정렬 정보 수정
        else {
            
            List<MenuFrontBean> sameLevelList = selectList("_menuFront.listSameLevel", bean);
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
                MenuFrontBean sameLevelBean = (MenuFrontBean)sameLevelList.get(i);
                
                sameLevelBean.setOrderNo( i + 1 );
                affected += update("_menuFront.updateOrder", sameLevelBean);
            }
            
            if ( affected == sameLevelLength ) {
                return ONE;
            }
            else {
                return ZERO;
            }
        }
    }

    public int deleteAction(MenuFrontBean bean) {
        
        return delete("_menuFront.delete", bean);
    }
    
    
    
    /*--------------------------------------------------------
     * For MenuFrontCache 
     *--------------------------------------------------------
     */
    
    public List<MenuFrontBean> listCache(MenuFrontBean bean) {

        List<MenuFrontBean> menuList = selectList("_menuFront.listCache", bean);
        
        listCacheRecursive(menuList);
        
        return menuList;
    }
    
    private void listCacheRecursive(List<MenuFrontBean> menuList) {
        
        if (StringUtil.isEmpty(menuList)) return;
        
        for (MenuFrontBean item : menuList) {
            
            if (StringUtil.isNotEmpty(item.getMgrId())) {
                item.setMgrBean( mgrDao.view(item.getMgrId()) );
            }
            
            if (StringUtil.equals(item.getLeaf(), "false")) {
                
                MenuFrontBean parameBean = new MenuFrontBean();
                parameBean.setDomainCd(item.getDomainCd());
                parameBean.setHighMenuCd(item.getMenuCd());
                
                List<MenuFrontBean> childList = selectList("_menuFront.listCache", parameBean);
                item.setChildren(childList);
                
                listCacheRecursive(childList);
            }
        }
    }
    
    public Map<Integer, MenuFrontBean> mapAllCache() {

        return selectMap("_menuFront.mapAllCache", Constant.TOP_MENU_CD, "menuCd");
    }
}
