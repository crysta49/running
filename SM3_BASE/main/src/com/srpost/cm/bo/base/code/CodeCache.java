package com.srpost.cm.bo.base.code;

import static com.srpost.salmon.constant.StringPool.*;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import com.srpost.salmon.cache.AbstractCache;
import com.srpost.salmon.cache.Cache;
import com.srpost.salmon.lang.StringUtil;

/**
 * 내부단 코드 정보 Cache
 *
 * @author  finkle
 * @date    2014-11-11
 * @since   2.0
 */
public class CodeCache extends AbstractCache {

    public static final String LIST_KEY = "__cc_lk__";
    public static final String LIST_SUB_KEY = "__cc_lsk__";
    
    private List<List<CodeBean>> cacheList = new ArrayList<List<CodeBean>>();
    
    @Resource
    ICodeService service;
    
    @Override
    public void createCache() {
     
        CodeBean parameterBean = new CodeBean();
        List<CodeBean> dataList = service.list(parameterBean);
        
        if (StringUtil.isNotEmpty(dataList)) {
            
            cacheList.clear();
            
            parameterBean.setUseYn(Y);
            parameterBean.setPrvCd(String.valueOf(MINUS_ONE));
            
            for (CodeBean bean : dataList) {
                parameterBean.setGrpCd(bean.getGrpCd());
                
                List<CodeBean> prvList = service.list(parameterBean);
                
                Cache.put(LIST_KEY + bean.getGrpCd(), prvList);
                
                cacheList.add(prvList);
            }
        }
    }
    
    @Override
    public void clearCache() {
        
        Cache.clear(LIST_KEY);
        Cache.clear(LIST_SUB_KEY);
    }

    @Override
    public Object getCacheContents() {

        return cacheList;
    }

    @Override
    public String getName() {
        
        return "공통코드 정보";
    }

}
