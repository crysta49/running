package com.srpost.cm.bo.base.file;

import static com.srpost.salmon.constant.StringPool.*;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveOutputStream;
import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.srpost.salmon.bean.BaseFileBean;
import com.srpost.salmon.constant.Constant;
import com.srpost.salmon.constant.StringPool;
import com.srpost.salmon.lang.FileUtil;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.spi.env.repository.LogFileRepository;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 공용 파일처리 컨트롤러
 *
 * @author  finkle
 * @date    2014-11-14
 * @since   2.0
 */
@Controller
@RequestMapping(value="/common/file")
public class FileCommonController extends BaseController {

    @Resource
    IFileService service;

    /**
     * 파일 다운로드
     */
    @RequestMapping(value="NR_download.do", method=RequestMethod.GET)
    public ModelAndView download(
            @RequestParam(value="id", required=true) String id, 
            HttpServletRequest request, ModelMap model) {

        BaseFileBean dataBean = service.view(id);
        
        if (dataBean != null) {
            service.updateDownCntAction( 
                    FileCommonUtil.createFileLogBean(request, dataBean) );
        }
        
        return responseDownload(model, dataBean);
    }
    
    /**
     * 파일 다운로드 (ZIP)
     */
    @RequestMapping(value="NR_downloadAll.do", method=RequestMethod.GET)
    public ModelAndView downloadAll(
            @RequestParam(value="fileSeq", required=true) Integer fileSeq, 
            HttpServletRequest request, ModelMap model) {

        List<BaseFileBean> fileList = service.list(fileSeq);

        ZipArchiveOutputStream zos = null;
        File zipFile = null;
        
        if (StringUtil.isNotEmpty(fileList)) {
            
            // 중복 파일명 체크용 저장소
            List<String> fileNameStore = new ArrayList<String>();
            
            try {
                File tempDir = jodd.io.FileUtil.createTempDirectory();
                zipFile = new File(tempDir + File.separator + "ALL_FILES.zip");
        
                zos = new ZipArchiveOutputStream(new FileOutputStream(zipFile));
                zos.setEncoding(Constant.ENCODING);
                
                System.out.println("**** " + fileList.size() + " ****");
                
                for (BaseFileBean item : fileList) {

                    String targetFileName = item.getOrgFileNm();
                    // 파일명 중복 시 파일명 변경
                    if (fileNameStore.contains(targetFileName)) {
                        targetFileName = Math.round(Math.random() * 10000) + "_" + targetFileName;
                    }
                    
                    File sourceFile = new File(item.getFilePath());
                    File targetFile = new File(tempDir + File.separator + targetFileName);
                    jodd.io.FileUtil.copy(sourceFile, targetFile);
                    
                    zos.putArchiveEntry(new ZipArchiveEntry(targetFileName));
                    IOUtils.copy(new FileInputStream(targetFile), zos);
                    zos.closeArchiveEntry();
                    
                    fileNameStore.add(targetFileName);
                    
                    service.updateDownCntAction( 
                            FileCommonUtil.createFileLogBean(request, item) );
                }
            }
            catch (IOException e) {
                logger.warn(e.toString());
            }
            finally {
                IOUtils.closeQuietly(zos);
            }
        }
        
        System.out.println("**** " + zipFile + " ****");
        
        return responseDownload(model, zipFile);
    }
    
    
    /**
     * 파일 다운로드 (파일 URL 직접 호출)
     */
    @RequestMapping(value="NR_directDownload.do", method=RequestMethod.GET)
    public ModelAndView directDownload(
            @RequestParam(value="fn", required=true) String fn, 
            @RequestParam(value="fp", required=true) String fp, 
            HttpServletRequest request, ModelMap model) {

        BaseFileBean baseFileBean = new BaseFileBean();
        
        if (!fp.startsWith(SLASH)) {
            fp = SLASH + fp;
        }
        File file = new File(Constant.WEB_APP_ROOT + fp, fn);

        if ( file.exists() && isValidDirectory(fp) ) {
            baseFileBean.setOrgFileNm(fn);
            baseFileBean.setFilePath(file.getAbsolutePath());
        }
        
        return responseDownload(model, baseFileBean);
    }
    
    /**
     * 로그 파일 다운로드
     */
    @RequestMapping(value="NR_logDownload.do", method=RequestMethod.GET)
    public ModelAndView logDownload(
            @RequestParam(value="fn", required=true) String fn, 
            HttpServletRequest request, ModelMap model) {

        File file = new File(LogFileRepository.FILE_PATH + SLASH + fn);

        if ( file.exists() && isValidDirectory(fn) ) {
            return responseDownload(model, file);
        }
        else {
            return responseDownload(model, null);
        }
    }
    
    
    /**
     * 이미지 파일 얻기
     */
    @RequestMapping(value="XR_image.do", method=RequestMethod.GET)
    public void downloadImage(
            @RequestParam(value="id", required=true) String id, 
            HttpServletResponse response, ModelMap model) {

        BaseFileBean dataBean = service.view(id);
        
        if (dataBean != null) {
            
            File file = new File(dataBean.getFilePath());
            FileInputStream fis = null;
            BufferedInputStream bis = null;
            ByteArrayOutputStream baos = null;
            
            try {
                fis = new FileInputStream(file);
                bis = new BufferedInputStream(fis);
                baos = new ByteArrayOutputStream();
                
                int imgByte;
                while ((imgByte = bis.read()) != -1) {
                    baos.write(imgByte);
                }
                
                if ( FileUtil.isImage(dataBean.getFileType()) ) {
                    response.setHeader("Content-Type", dataBean.getFileType());                    
                    response.setContentLength(baos.size());

                    baos.writeTo(response.getOutputStream());
                }
                else {
                    /*-- 
                    response.setHeader("Content-Type", dataBean.getFileType());                 
                    --*/
                    response.setContentLength(StringPool.ZERO);
                }

                response.getOutputStream().flush();
                response.getOutputStream().close();
            }
            catch(FileNotFoundException e) {
                logger.warn(e.getMessage());
            }
            catch(IOException e) {
                logger.warn("", e);
            }
            finally{
                IOUtils.closeQuietly(baos);
                IOUtils.closeQuietly(bis);
                IOUtils.closeQuietly(fis);
            }
        }
    }
    
    
    /**
     * 파일 업로드 (CKEditor)
     */
    @RequestMapping(value="NR_ckeditorUpload.do", method=RequestMethod.POST)
    public String fileUpload(HttpServletRequest request, ModelMap model) {

        String funcNum = request.getParameter("CKEditorFuncNum");
        String fileUrl = "";
        String message = "";
        
        List<BaseFileBean> fileList = FileUtil.getUploadFile(request);
        for (BaseFileBean fileBean : fileList) {
            /*--
            fileUrl = request.getContextPath() + fileBean.getFileUrl();
            --*/
            fileUrl = request.getContextPath() + baseUrl + "/XR_image.do?id=" + fileBean.getFileId();
            break;
        }
        
        service.insertAction(fileList);
        
        if (StringUtil.isEmpty(fileUrl)) {
            message = "업로드 파일 정보가 존재하지 않습니다.";
        }
        else {
            message = "성공적으로 파일을 업로드했습니다.";
        }
        
        /*--
        StringBuilder builder = new StringBuilder();
        builder.append("<script type=\"text/javascript\">");
        builder.append("window.parent.CKEDITOR.tools.callFunction(");
        builder.append(funcNum + ", '" + fileUrl + "', '" + message + "'");
        builder.append(");");
        builder.append("history.back();");
        builder.append("</script>");
        --*/
        
        model.addAttribute("funcNum", funcNum);
        model.addAttribute("fileUrl", fileUrl);
        model.addAttribute("message", message);
        
        return "/bo/common/spi/ckeditor/NR_upload";
    }
    
    private boolean isValidDirectory(String src) {
        
        if (StringUtil.isEmpty(src)) return false;
        
        return src.indexOf("..") == -1 && src.indexOf("WEB-INF") == -1;
    }
}
