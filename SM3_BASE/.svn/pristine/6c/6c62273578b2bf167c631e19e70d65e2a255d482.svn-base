package com.srpost.cm.bo.base.dept;

import static com.srpost.salmon.constant.StringPool.*;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.srpost.salmon.constant.Constant;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.spi.egov.ISalmonSeqGenerator;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 내부단 부서관리 DAO
 *
 * @author  finkle
 * @date    2014-10-27
 * @since   2.0
 */
@Repository
public class DeptDao extends EgovAbstractMapper {

    @Resource(name = "deptSeqGenerator")
    ISalmonSeqGenerator seqGenerator;
    
    public List<DeptBean> list(DeptBean bean) {
        
        return selectList("_dept.list", bean);
    }
    
    public DeptBean view(DeptBean bean) {
        
        return (DeptBean)selectOne("_dept.view", bean);
    }
    
    public synchronized Object insertAction(DeptBean bean) {

        bean.setDeptCd(seqGenerator.getNextString());
        
        if (Constant.USE_BRANCH && StringUtil.isEmpty(bean.getBranchCd())) {
            bean.setBranchCd(bean.getDeptCd());
        }
        
        int affected = insert("_dept.insert", bean);
        if (affected == ONE) {
            return bean.getDeptCd();
        }
        return null;
    }

    public int updateAction(DeptBean bean) {
        
        // 기본 정보 수정
        if ( bean.getOrderNo() == ZERO ) {

            if (Constant.USE_BRANCH && StringUtil.isEmpty(bean.getBranchCd())) {
                bean.setBranchCd(bean.getDeptCd());
            }

            int affected = update("_dept.update", bean);
            if (affected == ONE)
                update("_dept.updateRecursive", bean);
            
            return affected;
        }
        // 정렬 정보 수정
        else {
            
            List<DeptBean> sameLevelList = selectList("_dept.listSameLevel", bean);
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
                DeptBean sameLevelBean = (DeptBean)sameLevelList.get(i);
                
                sameLevelBean.setOrderNo( i + 1 );
                affected += update("_dept.updateOrder", sameLevelBean);
            }
            
            if ( affected == sameLevelLength ) {
                return ONE;
            }
            else {
                return ZERO;
            }
        }
    }

    public int deleteAction(DeptBean bean) {
        
        return delete("_dept.delete", bean);
    }
    
    public String listAllJSON() {
        
        List<String> dataList = selectList("_dept.listAllJSON", Constant.TOP_DEPT_CD);
        
        StringBuilder builder = new StringBuilder(LEFT_SQ_BRACKET);
        for (String item : dataList) {
            builder.append(item);
        }
        builder.append(RIGHT_SQ_BRACKET);
        return builder.toString();
    }
    
    public List<DeptBean> listAll() {
        
        return selectList("_dept.listAll", Constant.TOP_DEPT_CD);
    }
}
