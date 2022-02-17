package com.srpost.cm.bo.base.errlog;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.srpost.salmon.bean.BasePagerBean;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 내부단 에러로그 서비스 구현체
 *
 * @author  finkle
 * @date    2014-10-27
 * @since   2.0
 */
@Service
public class ErrLogServiceImpl extends EgovAbstractServiceImpl implements IErrLogService {

    @Resource
    ErrLogDao dao;

    @Override
    public BasePagerBean list(ErrLogBean bean) {
        
        return dao.list(bean);
    }
    
    @Override
    public List<Map<String, Object>> listExcel(ErrLogBean bean) {
        
        return dao.listExcel(bean);
    }

    @Override
    public ErrLogBean view(ErrLogBean bean) {
        
        return dao.view(bean);
    }

    @Override
    public Object insertAction(ErrLogBean bean) {
        
        return dao.insertAction(bean);
    }

    @Override
    public int updateAction(ErrLogBean bean) {
        
        return dao.updateAction(bean);
    }

    @Override
    public int deleteAction(ErrLogBean bean) {
        
        return dao.deleteAction(bean);
    }
    
    
}
