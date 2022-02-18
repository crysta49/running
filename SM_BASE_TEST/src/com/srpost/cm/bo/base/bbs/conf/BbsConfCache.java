package com.srpost.cm.bo.base.bbs.conf;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.sql.DataSource;

import com.srpost.salmon.cache.AbstractCache;
import com.srpost.salmon.cache.Cache;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.spi.mybatis.DatabaseMetaDataHelper;

/**
 * 내부단 게시판설정 정보 Cache
 *
 * @author  finkle
 * @date    2014-11-11
 * @since   2.0
 */
public class BbsConfCache extends AbstractCache {

    public static final String LIST_KEY = "__bc_lk__";
    public static final String VIEW_KEY = "__bc_vk__";
    
    private List<BbsConfBean> cacheList = new ArrayList<BbsConfBean>();
    
    @Resource
    DataSource dataSource;
    @Resource
    IBbsConfService service;
    
    @Override
    public void createCache() {
     
        List<BbsConfBean> dataList = service.listCache();
        
        if (StringUtil.isNotEmpty(dataList)) {
            
            cacheList.clear();
            
            for (BbsConfBean item : dataList) {
                BbsConfBean dataBean = service.view(item);
                
                if (StringUtil.isNotEmpty(dataBean.getTableNm())) {
                    List<String> columnList = DatabaseMetaDataHelper.getColumnList(dataSource, dataBean.getTableNm());
                    
                    if (StringUtil.isNotEmpty(columnList)) {
                        columnList.remove("BBS_CD");
                        columnList.remove("BBS_SEQ");
                        
                        dataBean.setColumnList(columnList);
                    }
                }
                
                Cache.put(VIEW_KEY + item.getBbsCd(), dataBean);
                
                cacheList.add(dataBean);
            }
        }
        
        Cache.put(LIST_KEY, dataList);
    }
    
    @Override
    public void clearCache() {
        
        Cache.clear(LIST_KEY);
        Cache.clear(VIEW_KEY);
    }

    @Override
    public Object getCacheContents() {
        
        return cacheList;
    }

    @Override
    public String getName() {
        
        return "게시판 설정 정보";
    }

}
