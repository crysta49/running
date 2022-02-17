package com.srpost.cm.bo.base.faq.ctg;

import static com.srpost.salmon.constant.StringPool.*;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.srpost.salmon.constant.Constant;
import com.srpost.salmon.spi.egov.ISalmonSeqGenerator;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 내부단 FAQ분류 관리 DAO
 *
 * @author  finkle
 * @date    2014-11-20
 * @since   2.0
 */
@Repository
public class FaqCtgDao extends EgovAbstractMapper {

    @Resource(name = "faqCtgSeqGenerator")
    ISalmonSeqGenerator seqGenerator;
    
    
    public List<FaqCtgBean> list(FaqCtgBean bean) {
        
        return selectList("_faqCtg.list", bean);
    }
    
    public FaqCtgBean view(FaqCtgBean bean) {
        
        return (FaqCtgBean)selectOne("_faqCtg.view", bean);
    }
    
    public synchronized Object insertAction(FaqCtgBean bean) {
        
        bean.setCtgCd(seqGenerator.getNextInteger());
        
        int affected = insert("_faqCtg.insert", bean);
        if (affected == ONE) {
            return bean.getCtgCd();
        }
        return null;
    }

    public int updateAction(FaqCtgBean bean) {
        
        // 기본 정보 수정
        if ( bean.getOrderNo() == ZERO ) {

            int affected = update("_faqCtg.update", bean);
            if (affected == ONE)
                update("_faqCtg.updateRecursive", bean);
            
            return affected;
        }
        // 정렬 정보 수정
        else {
            
            List<FaqCtgBean> sameLevelList = selectList("_faqCtg.listSameLevel", bean);
            int sameLevelLength = sameLevelList.size();
            
            int newOrderNo = bean.getOrderNo();

            if ( newOrderNo <= ZERO )
                newOrderNo = 1;
            if ( newOrderNo > sameLevelLength )
                newOrderNo = sameLevelLength + 1;
            
            sameLevelList.add(newOrderNo-1, bean);
            sameLevelLength++;
            
            int affected = ZERO;
            
            for (int i=0 ; i < sameLevelLength ; i++) {
                FaqCtgBean sameLevelBean = (FaqCtgBean)sameLevelList.get(i);
                
                sameLevelBean.setOrderNo( i + 1 );
                affected += update("_faqCtg.updateOrder", sameLevelBean);
            }
            
            if ( affected == sameLevelLength ) {
                return ONE;
            }
            else {
                return ZERO;
            }
        }
    }

    public int deleteAction(FaqCtgBean bean) {
        
        return delete("_faqCtg.delete", bean);
    }
    
    public List<FaqCtgBean> listAll() {
        
        return selectList("_faqCtg.listAll", Constant.TOP_CTG_CD);
    }
}
