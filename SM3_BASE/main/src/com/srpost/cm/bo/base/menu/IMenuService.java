package com.srpost.cm.bo.base.menu;

import java.util.List;

/**
 * 내부단 메뉴관리 서비스 인터페이스
 *
 * @author  finkle
 * @date    2014-10-14
 * @since   2.0
 */
public interface IMenuService {

    List<MenuBean> list(MenuBean bean);
    
    MenuBean view(MenuBean bean);

    Object insertAction(MenuBean bean);

    int updateAction(MenuBean bean);

    int deleteAction(MenuBean bean);

    String listAllJSON();

    String listMyAllJSON(MenuBean bean);
}
