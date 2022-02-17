package com.srpost.cm.bo.si.ipFilter;

import static com.srpost.salmon.constant.StringPool.ONE;
import static com.srpost.salmon.constant.StringPool.ZERO;

import java.lang.reflect.Array;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.srpost.salmon.bean.BasePagerBean;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.spi.egov.ISalmonSeqGenerator;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 내부단 IP Filter 정보 DAO
 *
 */
@Repository
public class IpFilterDao extends EgovAbstractMapper {

    @Resource(name = "ipFilterSeqGenerator")
    ISalmonSeqGenerator seqGenerator;

    public BasePagerBean list(IpFilterBean bean) {

        Map<String, Object> parameterMap = IpUtil.getParameterMap(bean);

        List<IpFilterBean> dataList = selectList("_ipFilter.list", parameterMap);
        int totalCount = (Integer) selectOne("_ipFilter.listCount", parameterMap);

        return new BasePagerBean(dataList, totalCount, bean);
    }

    public List<IpFilterBean> simpleList() {

        List<IpFilterBean> dataList = selectList("_ipFilter.simpleList");
        
        return dataList;
    }

    public IpFilterBean view(IpFilterBean bean) {

        IpFilterBean dataBean = (IpFilterBean) selectOne("_ipFilter.view", bean);

        return dataBean;
    }

    public int insertAction(IpFilterBean bean) {

        IpUtil.setNotNullValue(bean);

        bean.setIpSeq(seqGenerator.getNextInteger());

        int affected = insert("_ipFilter.insert", bean);

        return affected;
    }

    public int updateAction(IpFilterBean bean) {

        IpUtil.setNotNullValue(bean);

        int affected = update("_ipFilter.update", bean);

        return affected;
    }

    public int deleteAction(IpFilterBean bean) {

        int affected = ZERO;

        if (StringUtil.isNotEmpty(bean.getIpSeqs())) {
            affected = delete("_ipFilter.delete", bean);

            if (affected == Array.getLength(bean.getIpSeqs())) {
                return ONE;
            }
        }
        return affected;
    }

}