package com.srpost.cm.bo.base.file;

import static com.srpost.salmon.constant.StringPool.*;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.srpost.cm.bo.base.login.LoginBean;
import com.srpost.cm.bo.base.mgr.MgrUtil;
import com.srpost.cm.bo.base.user.UserBean;
import com.srpost.cm.bo.base.user.UserUtil;
import com.srpost.salmon.bean.BaseFileBean;
import com.srpost.salmon.lang.FileUtil;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.lang.UTF8Util;

/**
 * 공용 파일 Util
 *
 * @author  finkle
 * @date    2014-11-14
 * @since   3.0
 */
public class FileCommonUtil {


    public static Map<String, Object> getParameterMap(FileLogBean bean) {
        
        Map<String, Object> parameterMap = bean.createPagerMap();
        if ( StringUtil.isNotEmpty(bean.getFileSeq()) )
            parameterMap.put("fileSeq", bean.getFileSeq());
        if ( StringUtil.isNotEmpty(bean.getFileId()) )
            parameterMap.put("fileId", bean.getFileId());
        
        return parameterMap;
    }
    
    public static void setNotNullValue(BaseFileBean bean) {

        if (UTF8Util.length(bean.getOrgFileNm()) > 200) {
            String baseName = FileUtil.basename(bean.getOrgFileNm());
            String extension = bean.getExtension();
            
            bean.setOrgFileNm(
                UTF8Util.fixLength(baseName, 200 - (extension.length() + 1)) + DOT + extension);
        }
        
        bean.setFileType(UTF8Util.fixLength(bean.getFileType(), 100));
    }
    
    public static FileLogBean createFileLogBean(HttpServletRequest request, BaseFileBean dataBean) {
        
        FileLogBean bean = new FileLogBean();
        bean.setFileSeq(dataBean.getFileSeq());
        bean.setFileId(dataBean.getFileId());

        LoginBean loginBean = MgrUtil.getSession(request);
        if ( StringUtil.isNotEmpty(loginBean) ) {
            bean.setWorkerId(loginBean.getMgrId());
            bean.setWorkerNm(loginBean.getMgrNm());
        }
        else {
            UserBean userBean = UserUtil.getSession(request);
            if ( StringUtil.isNotEmpty(userBean) ) {
                bean.setWorkerId(userBean.getUserKey());
                bean.setWorkerNm(userBean.getUserNm());
            }
        }
        
        if ( StringUtil.isEmpty(bean.getWorkerNm()) ) {
            bean.setWorkerId("N/A");
            bean.setWorkerNm("알수없음");
        }

        return bean;
    }
    
    public static boolean isValidFileSeq(Integer fileSeq) {
        
        return StringUtil.isNotEmpty(fileSeq) && fileSeq != MINUS_ONE;
    }
}
