package com.srpost.cm.bo.base.cache;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.salmon.cache.CacheManager;
import com.srpost.salmon.cache.ICache;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 내부단 캐시 컨트롤러
 *
 * @author  finkle
 * @date    2014-11-11
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/cache")
public class CacheController extends BaseController {

    @Autowired(required=true)
    CacheManager cacheManager;
    
	/**
	 * Cache 리로드 초기화면
	 */
	@RequestMapping(value="NR_index.do", method=RequestMethod.GET)
	public void index(ModelMap model) {

        model.addAttribute("cacheList", cacheManager.getCacheList());
	    model.addAttribute("serverList", cacheManager.getServerList());
    }

    /**
     * Cache 정보 조회
     */
    @RequestMapping(value="AR_view.do", method=RequestMethod.POST)
    public void view(@RequestParam(required=true) String id, ModelMap model) {
        
        ICache cacheClass = cacheManager.get(id);
        
        if ( StringUtil.isNotEmpty(cacheClass) )
            model.addAttribute("dataBean", cacheClass.getCacheContents());
    }

	/**
     * Cache 리로드 액션
     */
	@RequestMapping(value="TR_reloadAction.do", method=RequestMethod.POST)
    public ModelAndView reloadCache(
    		@RequestParam(required=true) String id, ModelMap model) {

	    ICache cacheClass = cacheManager.get(id);

        if ( StringUtil.isEmpty(cacheClass) )
        	return responseText(model, Message.fail(Message.BASE_CACHE_FAIL_KEY));
        
        cacheClass.reloadCache();
        
        return responseText(model, Message.success(Message.BASE_CACHE_SUCCESS_KEY));
    }
}
