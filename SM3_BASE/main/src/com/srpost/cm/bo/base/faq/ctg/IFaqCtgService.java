package com.srpost.cm.bo.base.faq.ctg;

import java.util.List;

/**
 * 내부단 FAQ분류 관리 서비스 인터페이스
 *
 * @author  finkle
 * @date    2014-11-20
 * @since   2.0
 */
public interface IFaqCtgService {

    List<FaqCtgBean> list(FaqCtgBean bean);
    
    FaqCtgBean view(FaqCtgBean bean);

    Object insertAction(FaqCtgBean bean);

    int updateAction(FaqCtgBean bean);

    int deleteAction(FaqCtgBean bean);
    
    List<FaqCtgBean> listAll();
}
