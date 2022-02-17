package com.srpost.cm.bo.base.code;

import static com.srpost.salmon.constant.StringPool.*;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.srpost.salmon.lang.StringUtil;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 내부단 코드관리 DAO
 *
 * @author  finkle
 * @date    2014-10-27
 * @since   2.0
 */
@Repository
public class CodeDao extends EgovAbstractMapper {

    public List<CodeBean> list(CodeBean bean) {
        
        if ( CodeUtil.isGrpList(bean) )
            return selectList("_code.listGrp", bean);
        else
            return selectList("_code.listPrv", bean);
    }
    
    public CodeBean view(CodeBean bean) {
        
        if ( CodeUtil.isGrpView(bean) ) {
            
            if (StringUtil.isEmpty(bean.getGrpCd()))
                return bean; 
            
            return (CodeBean)selectOne("_code.viewGrp", bean);
        }
        else
            return (CodeBean)selectOne("_code.viewPrv", bean);
    }
    
    public int insertAction(CodeBean bean) {
        
        return insert("_code.insertGrp", bean);
    }

    public int updateAction(CodeBean bean) {
        
        return update("_code.updateGrp", bean);
    }

    public int deleteAction(CodeBean bean) {
        
        return delete("_code.deleteGrp", bean);
    }
    
    public int crudAction(String[] inserts, String[] updates, String[] deletes) {

        /* 배열 정보 
         * grpCd^prvCd^prvNm^orderNo^subGrpCd^isUse
         */

    	 if (StringUtil.isNotEmpty(deletes)) {
             for (String item : deletes) {
                 // grpCd^prvCd^prvNm^orderNo^isUse
                 String[] items = StringUtil.split(item, HAT);
                 CodeBean bean = new CodeBean();
                 bean.setGrpCd(items[0]);
                 bean.setPrvCd(items[1]);
                 
                 delete("_code.deletePrv", bean);
             }
         }
    	
        if (StringUtil.isNotEmpty(inserts)) {
            for (String item : inserts) {
                String[] items = StringUtil.split(item, HAT);
                CodeBean bean = new CodeBean();
                bean.setGrpCd(items[0]);
                bean.setPrvCd(items[1]);
                bean.setPrvNm(items[2]);
                bean.setOrderNo(Integer.parseInt(items[3]));
                bean.setSubGrpCd(items[4]);
                bean.setUseYn(Boolean.valueOf(items[5]) ? Y : N);
                
                update("_code.insertPrv", bean);
            }
        }
        
        if (StringUtil.isNotEmpty(updates)) {
            for (String item : updates) {
                String[] items = StringUtil.split(item, HAT);
                CodeBean bean = new CodeBean();
                bean.setGrpCd(items[0]);
                bean.setPrvCd(items[1]);
                bean.setPrvNm(items[2]);
                bean.setOrderNo(Integer.parseInt(items[3]));
                bean.setSubGrpCd(items[4]);
                bean.setUseYn(Boolean.valueOf(items[5]) ? Y : N);
                
                insert("_code.updatePrv", bean);
            }
        }
        
       
        
        return ONE;
    }
    
    public int orderAction(String grpCd, String[] orders) {
        
        if (StringUtil.isNotEmpty(orders)) {
            int orderNo = 1;
            for (String item : orders) {

                CodeBean bean = new CodeBean();
                bean.setGrpCd(grpCd);
                bean.setPrvCd(item);
                bean.setOrderNo(orderNo++);
                
                update("_code.updateOrderPrv", bean);
            }
        }
        return ONE;
    }
    
    /*--
    public List<CodeBean> listSub(String subGrpCd) {
        
        CodeBean bean = new CodeBean();
        bean.setGrpCd(subGrpCd);
        bean.setUseYn(Y);
        
        return selectList("_code.listPrv", bean);
    } --*/
}
