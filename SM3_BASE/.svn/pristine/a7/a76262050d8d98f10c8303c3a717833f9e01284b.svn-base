package com.srpost.cm.bo.base.file;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * 내부단 파일처리 컨트롤러
 *
 * @author  finkle
 * @date    2014-11-14
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/file")
public class FileController extends FileCommonController {

    /**
     * 파일 다운로드 로그 목록 메인
     */
    @RequestMapping(value="PR_fileLogIndex.do", method=RequestMethod.GET)
    public void fileLogIndex(FileLogBean bean) {
    }
    
    /**
     * 파일 다운로드 로그 목록 조회
     */
    @RequestMapping(value="JR_fileLogList.do", method=RequestMethod.GET)
    public ModelAndView fileLogList(FileLogBean bean, ModelMap model) {

        return responseJson(model, service.listLog(bean));
    }
}
