package com.srpost.cm.bo.base.code;

import java.util.List;

/**
 * 내부단 코드관리 서비스 인터페이스
 *
 * @author  finkle
 * @date    2014-10-27
 * @since   2.0
 */
public interface ICodeService {

    List<CodeBean> list(CodeBean bean);
    
    CodeBean view(CodeBean bean);

    int insertAction(CodeBean bean);

    int updateAction(CodeBean bean);

    int deleteAction(CodeBean bean);
    
    int crudAction(String[] inserts, String[] updates, String[] deletes);
    
    int orderAction(String grpCd, String[] orders);
    
    /*--
    List<CodeBean> listSub(String subGrpCd);
    --*/
}
