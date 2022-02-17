package com.srpost.cm.fe.cms;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 외부단 CMS 컨트롤러
 * --------------------------------------------------------
 * [http://www.domain.com/fe/cms/{dirName}/{fileName}/NR_index.do] 형식으로
 * URL을 요청하면 서버내 /WEB-INF/jsp/fe/cms 폴더 하위에서
 * dirName과 fileName을 읽어서 View로 반환함
 * --------------------------------------------------------
 * 
 * @author  finkle
 * @date    2015-12-29
 * @since   3.0
 */
@Controller
@RequestMapping(value="/fe/cms")
public class CmsController extends BaseController {


    @RequestMapping(value="/{dirName}/{fileName}/NR_index.do")
    public String index(@PathVariable("dirName") String dirName,
            @PathVariable("fileName") String fileName) {
        
        return baseUrl + "/" + dirName + "/" + fileName;
    }
}
