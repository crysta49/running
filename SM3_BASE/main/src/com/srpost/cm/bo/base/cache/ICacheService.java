package com.srpost.cm.bo.base.cache;

import java.util.List;

/**
 * 내부단 캐시 서비스 인터페이스
 *
 * @author  finkle
 * @date    2014-11-11
 * @since   3.0
 */
public interface ICacheService {

    List<CacheBean> list(String address);

    int insertAction(CacheBean bean);

    int updateAction(Integer seq);
}
