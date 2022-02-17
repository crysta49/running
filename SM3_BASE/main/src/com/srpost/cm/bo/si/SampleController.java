package com.srpost.cm.bo.si;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.salmon.bean.BaseFileBean;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.FileUtil;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 내부단 교육 및 테스트용 샘플 컨트롤러
 * 
 * @author finkle, 2014-10-22
 */
@Controller
@RequestMapping(value="/bo/si/sample")
public class SampleController extends BaseController {

    @Resource
    SampleDao dao;
    
    @RequestMapping(value="*.do")
    public void index() {
    }
    

    @RequestMapping(value="TR_*.do", method=RequestMethod.POST)
    public ModelAndView action(@RequestParam(value="command") int command, 
            ModelMap model) throws Exception {

        String message = null;

        if (command == 200) {
            message = Message.success(Message.COMMON_INSERT_SUCCESS_KEY);
        }
        else if (command == 201) {
            try {
                Thread.sleep(2000);
            }
            catch (InterruptedException e) {
            }
            message = Message.success(Message.COMMON_INSERT_SUCCESS_KEY);
        }
        else if (command == 500) {
            throw new Exception("임의로 발생한 에러입니다.");
        }
        else {
            message = Message.fail(Message.COMMON_CRUD_FAIL_KEY);
        }
        return responseText(model, message);
    }
    
    @RequestMapping(value="TR_upload.do", method=RequestMethod.POST)
    public ModelAndView upload(HttpServletRequest request, ModelMap model) {
        
        List<BaseFileBean> fileList = FileUtil.getUploadFile(request);

        StringBuilder builder = new StringBuilder();
        
        if (StringUtil.isNotEmpty(fileList)) {
            int index = 1;
            for (BaseFileBean bean : fileList) {
                builder.append( "\n[" + (index++) + "]번째 업로드 파일 정보" ).
                append( "\n\tFileId    : " + bean.getFileId() ).
                append( "\n\tFileNm    : " + bean.getFileNm() ).
                append( "\n\tOrgFileNm : " + bean.getOrgFileNm() ).
                append( "\n\tFileType  : " + bean.getFileType() ).
                append( "\n\tFileSize  : " + bean.getFileSize() ).
                append( "\n\tInputNm   : " + bean.getInputNm() ).
                append( "\n\tExtension : " + bean.getExtension() ).
                append( "\n\tFilePath  : " + bean.getFilePath() ).
                append( "\n\tFileUrl   : " + bean.getFileUrl() ).
                append( "\n--------------------------" );
            }
            
            logger.info( StringUtil.toString(builder) ); 
        }
        else {
            logger.warn("첨부파일이 존재하지 않습니다.");
        }
        
        return responseText(model, Message.successMessage("업로드 완료 ! 콘솔창 로그를 확인하세요."));
    }
}
