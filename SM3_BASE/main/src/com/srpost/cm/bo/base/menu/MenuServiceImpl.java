package com.srpost.cm.bo.base.menu;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 내부단 메뉴관리 서비스 구현체
 *
 * @author  finkle
 * @date    2014-10-14
 * @since   2.0
 */
@Service
public class MenuServiceImpl extends EgovAbstractServiceImpl implements IMenuService {

    @Resource
    MenuDao dao;
    
    @Override
    public List<MenuBean> list(MenuBean bean) {
        
        return dao.list(bean);
    }

    @Override
    public MenuBean view(MenuBean bean) {
        
        return dao.view(bean);
    }

    @Override
    public Object insertAction(MenuBean bean) {
        
        return dao.insertAction(bean);
    }

    @Override
    public int updateAction(MenuBean bean) {
        
        return dao.updateAction(bean);
    }

    @Override
    public int deleteAction(MenuBean bean) {
        
        return dao.deleteAction(bean);
    }

    @Override
    public String listAllJSON() {
        
        return dao.listAllJSON();
    }
    
    @Override
    public String listMyAllJSON(MenuBean bean) {
        
        return dao.listMyAllJSON(bean);
    }
}
