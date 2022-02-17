package com.srpost.cm.bo.base.bbs.conf;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.springframework.stereotype.Service;

import com.srpost.salmon.bean.BasePagerBean;
import com.srpost.salmon.spi.mybatis.DatabaseMetaDataHelper;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 내부단 게시판설정 서비스 구현체
 *
 * @author  finkle
 * @date    2014-11-10
 * @since   2.0
 */
@Service
public class BbsConfServiceImpl extends EgovAbstractServiceImpl implements IBbsConfService {

    @Resource
    DataSource dataSource;
    @Resource
    BbsConfDao dao;

    @Override
    public BasePagerBean list(BbsConfBean bean) {
        
        return dao.list(bean);
    }
    
    @Override
    public List<Map<String, Object>> listExcel(BbsConfBean bean) {
        
        return dao.listExcel(bean);
    }

    @Override
    public BbsConfBean view(BbsConfBean bean) {
        
        return dao.view(bean);
    }

    @Override
    public int insertAction(BbsConfBean bean, String[] ctgDatas, String[] mgrDatas) {
        
        return dao.insertAction(bean, ctgDatas, mgrDatas);
    }

    @Override
    public int updateAction(BbsConfBean bean, String[] ctgDatas, String[] mgrDatas) {
        
        return dao.updateAction(bean, ctgDatas, mgrDatas);
    }

    @Override
    public int deleteAction(BbsConfBean bean) {
        
        return dao.deleteAction(bean);
    }
    
    @Override
    public List<String> tableList(String tableNmPrefix) {

        return DatabaseMetaDataHelper.getTableList(dataSource, tableNmPrefix);
    }
    
    @Override
    public List<BbsConfBean> listCache() {
     
        return dao.listCache();
    }
}
