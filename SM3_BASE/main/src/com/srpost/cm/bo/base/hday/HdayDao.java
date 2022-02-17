package com.srpost.cm.bo.base.hday;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.srpost.salmon.spi.egov.ISalmonSeqGenerator;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 내부단 공휴일 DAO
 *
 * @author  finkle
 * @date    2014-11-07
 * @since   2.0
 */
@Repository
public class HdayDao extends EgovAbstractMapper {
    
    @Resource(name = "hdaySeqGenerator")
    ISalmonSeqGenerator seqGenerator;

    public List<HdayBean> list() {
        
        return selectList("_hday.list");
    }
    
    public HdayBean view(HdayBean bean) {
        
        return (HdayBean)selectOne("_hday.view", bean);
    }
    
    public synchronized int insertAction(HdayBean bean) {
        
        HdayUtil.setNotNullValue(bean);
        bean.setSeq(seqGenerator.getNextInteger());
        
        return insert("_hday.insert", bean);
    }

    public int updateAction(HdayBean bean) {
        
        HdayUtil.setNotNullValue(bean);
        
        return update("_hday.update", bean);
    }

    public int deleteAction(HdayBean bean) {
        
        return delete("_hday.delete", bean);
    }
    
    public List<HdayBean> listCache() {

        return selectList("_hday.listCache");
    }
}
