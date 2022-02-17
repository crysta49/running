package com.srpost.cm.bo.base.domain;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.srpost.cm.bo.base.menu.front.MenuFrontBean;
import com.srpost.salmon.constant.StringPool;
import com.srpost.salmon.spi.egov.ISalmonSeqGenerator;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 내부단 도메인 DAO
 *
 * @author  finkle
 * @date    2014-11-07
 * @since   2.0
 */
@Repository
public class DomainDao extends EgovAbstractMapper {
    
    @Resource(name = "menuFrontSeqGenerator")
    ISalmonSeqGenerator seqGenerator;
    
    public List<DomainBean> list() {
        
        return selectList("_domain.list");
    }
    
    public DomainBean view(DomainBean bean) {
        
        return (DomainBean)selectOne("_domain.view", bean);
    }
    
    public synchronized int insertAction(DomainBean bean) {

        int newMenuCd = seqGenerator.getNextInteger();
        bean.setDomainCd(newMenuCd);
        
        int affected = insert("_domain.insert", bean);
        if (affected == StringPool.ONE) {
            MenuFrontBean mfBean = new MenuFrontBean();
            mfBean.setDomainCd(bean.getDomainCd());
            mfBean.setMenuCd(bean.getDomainCd());
            mfBean.setHighMenuCd(mfBean.getTopMenuCd());
            mfBean.setOrderNo(0);
            mfBean.setMenuNm(bean.getDomainNm());
            mfBean.setShowYn(StringPool.Y);
            mfBean.setMenuUrl(StringPool.EMPTY);
            mfBean.setMenuPattern(StringPool.EMPTY);
            mfBean.setMenuId(StringPool.EMPTY);
            mfBean.setMenuIcon(StringPool.EMPTY);
            mfBean.setMgrId(StringPool.EMPTY);
            
            insert("_menuFront.insert", mfBean);
        }
        return affected;
    }
    

    public int updateAction(DomainBean bean) {

        return update("_domain.update", bean);
    }

    public int deleteAction(DomainBean bean) {
        
        return delete("_domain.delete", bean);
    }
    
    public List<DomainBean> listCache() {

        return selectList("_domain.listCache");
    }
}
