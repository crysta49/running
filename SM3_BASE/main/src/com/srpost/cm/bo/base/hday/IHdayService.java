package com.srpost.cm.bo.base.hday;

import java.util.List;

/**
 * 내부단 공휴일 서비스 인터페이스
 *
 * @author  finkle
 * @date    2014-11-07
 * @since   2.0
 */
public interface IHdayService {

    List<HdayBean> list();
    
    HdayBean view(HdayBean bean);

    int insertAction(HdayBean bean);

    int updateAction(HdayBean bean);

    int deleteAction(HdayBean bean);
    
    List<HdayBean> listCache();
}
