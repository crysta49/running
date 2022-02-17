package com.srpost.cm.bo.base.domain;

import java.util.List;

/**
 * 내부단 도메인 서비스 인터페이스
 *
 * @author  finkle
 * @date    2014-11-07
 * @since   2.0
 */
public interface IDomainService {

    List<DomainBean> list();
    
    DomainBean view(DomainBean bean);

    int insertAction(DomainBean bean);

    int updateAction(DomainBean bean);

    int deleteAction(DomainBean bean);
}
