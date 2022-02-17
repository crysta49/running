package com.srpost.cm.bo.base.errlog;

import java.util.List;
import java.util.Map;

import com.srpost.salmon.bean.BasePagerBean;

/**
 * 내부단 에러로그 서비스 인터페이스
 *
 * @author  finkle
 * @date    2014-10-27
 * @since   2.0
 */
public interface IErrLogService {

    BasePagerBean list(ErrLogBean bean);
    
    List<Map<String, Object>> listExcel(ErrLogBean bean);
    
    ErrLogBean view(ErrLogBean bean);
    
    Object insertAction(ErrLogBean bean);
    
    int updateAction(ErrLogBean bean);
    
    int deleteAction(ErrLogBean bean);
}
