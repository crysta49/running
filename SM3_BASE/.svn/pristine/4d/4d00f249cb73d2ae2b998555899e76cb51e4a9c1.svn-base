package com.srpost.cm.bo.base.bbs.conf;

import java.util.List;
import java.util.Map;

import com.srpost.salmon.bean.BasePagerBean;

/**
 * 내부단 게시판설정 서비스 인터페이스
 *
 * @author  finkle
 * @date    2014-11-10
 * @since   2.0
 */
public interface IBbsConfService {

    BasePagerBean list(BbsConfBean bean);
    
    List<Map<String, Object>> listExcel(BbsConfBean bean);
    
    BbsConfBean view(BbsConfBean bean);
    
    int insertAction(BbsConfBean bean, String[] ctgDatas, String[] mgrDatas);
    
    int updateAction(BbsConfBean bean, String[] ctgDatas, String[] mgrDatas);
    
    int deleteAction(BbsConfBean bean);
    
    List<String> tableList(String tableNmPrefix);
    
    List<BbsConfBean> listCache();
}
