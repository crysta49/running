package com.srpost.cm.bo.si;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 내부단 쪽지 DAO
 *
 * @author  finkle
 * @date    2014-11-13
 * @since   2.0
 */
@Repository
public class SampleDao extends EgovAbstractMapper {


    public List<Map<String, Object>> list(int cmd, HttpSession session) {
        
        SampleExcelRowHandler rowHandler = new SampleExcelRowHandler(session);
        
        Map<String, Integer> parameterMap = new HashMap<String, Integer>();
        parameterMap.put("cmd", cmd);
        
        getSqlSession().select("_sample.list", parameterMap, rowHandler);
        
        return rowHandler.getList();
    }
}
