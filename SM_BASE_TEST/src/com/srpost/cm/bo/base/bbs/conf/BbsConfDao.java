package com.srpost.cm.bo.base.bbs.conf;

import static com.srpost.salmon.constant.StringPool.*;

import java.lang.reflect.Array;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.srpost.salmon.bean.BasePagerBean;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.spi.egov.ISalmonSeqGenerator;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 내부단 게시판설정 DAO
 *
 * @author  finkle
 * @date    2014-11-10
 * @since   2.0
 */
@Repository
public class BbsConfDao extends EgovAbstractMapper {

    @Resource(name = "bbsConfSeqGenerator")
    ISalmonSeqGenerator seqGenerator;
    
    public BasePagerBean list(BbsConfBean bean) {
        
        Map<String, Object> parameterMap = BbsConfUtil.getParameterMap(bean);
        
        List<BbsConfBean> dataList = selectList("_bbsConf.list", parameterMap);
        int totalCount = (Integer)selectOne("_bbsConf.listCount", parameterMap);

        return new BasePagerBean(dataList, totalCount, bean);
    }
    
    public List<Map<String, Object>> listExcel(BbsConfBean bean) {
    	
        Map<String, Object> parameterMap = BbsConfUtil.getParameterMap(bean);
    	
        BbsConfExcelRowHandler rowHandler = new BbsConfExcelRowHandler();
        
    	if ( StringUtil.equals(bean.getXlsScope(), BbsConfBean.SCOPE_TOTAL)) {
    		getSqlSession().select("_bbsConf.listExcel", parameterMap, rowHandler);
    	}
    	else {
    	    getSqlSession().select("_bbsConf.list", parameterMap, rowHandler);
    	}
    	
    	return rowHandler.getList();
    }
    
    public BbsConfBean view(BbsConfBean bean) {
        
        BbsConfBean dataBean = (BbsConfBean)selectOne("_bbsConf.view", bean);
        if (dataBean != null) {
            if (StringUtil.equals(dataBean.getCtgYn(), Y))
                dataBean.setCtgList( listBbsCtg(bean.getBbsCd()) );
            if (StringUtil.equals(dataBean.getAdmYn(), Y))
                dataBean.setMgrList( listBbsMgr(bean.getBbsCd()) );
        }
        return dataBean;
    }
    
    public synchronized int insertAction(BbsConfBean bean, String[] ctgDatas, String[] mgrDatas) {
        
        BbsConfUtil.setNotNullValue(bean);
        
        bean.setBbsCd(seqGenerator.getNextInteger());
        
        int affected = insert("_bbsConf.insert", bean);
        if (affected == ONE) {
            insertBbsCtgAction(bean.getBbsCd(), ctgDatas);
            insertBbsMgrAction(bean.getBbsCd(), mgrDatas);
        }
        return affected;
    }

    public int updateAction(BbsConfBean bean, String[] ctgDatas, String[] mgrDatas) {
        
        BbsConfUtil.setNotNullValue(bean);
        
        int affected = update("_bbsConf.update", bean);
        if (affected == ONE) {
            insertBbsCtgAction(bean.getBbsCd(), ctgDatas);
            insertBbsMgrAction(bean.getBbsCd(), mgrDatas);
        }
        return affected;
    }    

    public int deleteAction(BbsConfBean bean) {
        
        if (StringUtil.isNotEmpty(bean.getBbsCds())) {
            int affected = delete("_bbsConf.delete", bean);
            if (affected == Array.getLength(bean.getBbsCds())) 
                return ONE;
        }
        
        return ZERO;
    }
    
    
    
    private List<BbsCtgBean> listBbsCtg(Integer bbsCd) {
        
        return selectList("_bbsConf.listBbsCtg", bbsCd);
    }
    
    private int insertBbsCtgAction(Integer bbsCd, String[] ctgDatas) {
        
        int affected = ZERO;
        
        if (StringUtil.isNotEmpty(ctgDatas)) {
            
            delete("_bbsConf.deleteBbsCtgAll", bbsCd);

            for (String ctgData : ctgDatas) {
                String[] ctgArray = StringUtil.split(ctgData, HAT);

                BbsCtgBean ctgBean = new BbsCtgBean();
                ctgBean.setBbsCd(bbsCd);
                ctgBean.setCtgCd(Integer.parseInt(ctgArray[0]));
                ctgBean.setCtgNm(ctgArray[1]);
                ctgBean.setOrderNo(Integer.parseInt(ctgArray[2]));
                
                affected += insert("_bbsConf.inserBbsCtg", ctgBean);
            }
        }
        return affected;
    }
    
    private List<BbsMgrBean> listBbsMgr(Integer bbsCd) {
        
        return selectList("_bbsConf.listBbsMgr", bbsCd);
    }
    
    private int insertBbsMgrAction(Integer bbsCd, String[] mgrDatas) {
        
        int affected = ZERO;
        
        if (StringUtil.isNotEmpty(mgrDatas)) {
            
            delete("_bbsConf.deleteBbsMgrAll", bbsCd);
            
            for (String mgrData : mgrDatas) {
                String[] mgrArray = StringUtil.split(mgrData, HAT);
                
                BbsMgrBean mgrBean = new BbsMgrBean();
                mgrBean.setBbsCd(bbsCd);
                mgrBean.setMgrId(mgrArray[0]);
                mgrBean.setMgrNm(mgrArray[1]);
                
                affected += insert("_bbsConf.inserBbsMgr", mgrBean);
            }
        }
        return affected;
    }
    
    
    public List<BbsConfBean> listCache() {
        
        Map<String, String> parameterMap = new HashMap<String, String>();
        parameterMap.put("useYn", Y);
        
        return selectList("_bbsConf.listExcel", parameterMap);
    }
}
