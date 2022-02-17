package com.srpost.cm.bo.base.menu.front;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 내부단 프론트 메뉴관리 서비스 구현체
 *
 * @author  finkle
 * @date    2014-10-14
 * @since   2.0
 */
@Service
public class MenuFrontServiceImpl extends EgovAbstractServiceImpl implements IMenuFrontService {

    @Resource
    MenuFrontDao dao;
    
    @Override
    public List<MenuFrontBean> list(MenuFrontBean bean) {
        
        return dao.list(bean);
    }

    @Override
    public MenuFrontBean view(MenuFrontBean bean) {
        
        return dao.view(bean);
    }

    @Override
    public Object insertAction(MenuFrontBean bean) {
        
        return dao.insertAction(bean);
    }

    @Override
    public int updateAction(MenuFrontBean bean) {
        
        return dao.updateAction(bean);
    }

    @Override
    public int deleteAction(MenuFrontBean bean) {
        
        return dao.deleteAction(bean);
    }

    @Override
    public List<MenuFrontBean> listCache(MenuFrontBean bean) {
        
        return dao.listCache(bean);
    }

    @Override
    public Map<Integer, MenuFrontBean> mapAllCache() {

        return dao.mapAllCache();
    }
}
