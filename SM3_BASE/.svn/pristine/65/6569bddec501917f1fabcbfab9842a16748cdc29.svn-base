package com.srpost.cm.bo.base.env;

import static com.srpost.salmon.constant.StringPool.*;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
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
import com.srpost.salmon.cache.CacheManager;
import com.srpost.salmon.constant.Config;
import com.srpost.salmon.lang.DateTimeUtil;
import com.srpost.salmon.lang.FileUtil;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.scheduelr.MultipleCacheReloadScheduler;
import com.srpost.salmon.spi.env.collector.CpuCollector;
import com.srpost.salmon.spi.env.collector.DiskCollector;
import com.srpost.salmon.spi.env.collector.MemoryCollector;
import com.srpost.salmon.spi.env.repository.ClasspathRepository;
import com.srpost.salmon.spi.env.repository.J2EERepository;
import com.srpost.salmon.spi.env.repository.LogFileRepository;
import com.srpost.salmon.spi.env.repository.OsRepository;
import com.srpost.salmon.spi.env.repository.PropertyRepository;
import com.srpost.salmon.web.mvc.controller.BaseController;

/**
 * 내부단 시스템 환경정보 컨트롤러
 *
 * @author  finkle
 * @date    2014-10-24
 * @since   2.0
 */
@Controller
@RequestMapping(value="/bo/base/env")
public class EnvController extends BaseController {

    @Resource
    CacheManager cacheManager;
    @Resource
    MultipleCacheReloadScheduler multipleCacheReloadScheduler;

    /**
     * 메인화면
     */
    @RequestMapping(value="NR_index.do", method=RequestMethod.GET)
    public void index() {
    }

    /**
     * 서버 정보
     */
    @RequestMapping(value="AR_server.do", method=RequestMethod.GET)
    public void server(HttpServletRequest request, ModelMap model) {

        model.addAttribute("dataMap", OsRepository.get());

        model.addAttribute("cpuList", new CpuCollector().collect());
        model.addAttribute("memoryList", new MemoryCollector().collect());
        model.addAttribute("diskList", new DiskCollector().collect());
    }
    
    /**
     * WAS 정보
     */
    @RequestMapping(value="AR_was.do", method=RequestMethod.GET)
    public void was(HttpServletRequest request, ModelMap model) {
        
        model.addAttribute("dataMap", 
                J2EERepository.get(request.getSession().getServletContext()));

        /*
        if (request.isRequestedSessionIdFromCookie()) {
            model.addAttribute("sessionTracking", "Cookie");
        }
        else if (request.isRequestedSessionIdFromURL()) {
            model.addAttribute("sessionTracking", "Url-encoding");
        }
        else {
            model.addAttribute("sessionTracking", "N/A");
        }

        model.addAttribute("creationTime", 
                DateTimeUtil.toDateFull(request.getSession().getCreationTime()));
        model.addAttribute("lastAccessTime", 
                DateTimeUtil.toDateFull(request.getSession().getLastAccessedTime())); */
    }
    
    /**
     * 환경 변수
     */
    @RequestMapping(value="AR_property.do", method=RequestMethod.GET)
    public void property(HttpServletRequest request, ModelMap model) {

        model.addAttribute("dataList", PropertyRepository.get());        
    }
    
    /**
     * 클래스 경로
     */
    @RequestMapping(value="AR_classpath.do", method=RequestMethod.GET)
    public void classpath(HttpServletRequest request, ModelMap model) {
        
        model.addAttribute("dataMap", ClasspathRepository.get());
    }
    
    /**
     * 클래스경로 획득 액션
     */
    @RequestMapping(value="TR_findClassAction.do", method=RequestMethod.POST)
    public ModelAndView findClassAction(ModelMap model, 
            @RequestParam(value="clazz",required=true) String clazz) {

        String orgClazz = clazz;
        
        if ( StringUtil.isNotEmpty(clazz) ) {
            
            clazz = StringUtil.replaceChar(clazz, '.', '/').trim();
            clazz = "/" + clazz + ".class";
            URL classUrl = this.getClass().getResource(clazz);

            if ( StringUtil.isNotEmpty(classUrl) ) {

                String jarFile = classUrl.getFile();
                int indexNo = jarFile.indexOf("!");
                if (indexNo != -1) {
                    jarFile = jarFile.substring(0, indexNo);
                }
                return responseText(
                    model, orgClazz + " 클래스는<br/>[<span>" + jarFile + "</span>] 에서 로드되었습니다.");
            }
        }
        return responseText(model, orgClazz + "를 찾을 수 없습니다.");
    }
    
    /**
     * 로그파일 정보
     */
    @RequestMapping(value="AR_log.do", method=RequestMethod.GET)
    public void log(HttpServletRequest request, ModelMap model) {
        
        if (StringUtil.isEmpty(LogFileRepository.FILE_PATH)) {
            model.addAttribute("error", "로그정보가 시스템 콘솔창에 기록되고 있으므로 로그파일을 조회할 수 없습니다.");
            return;
        }
        
        File logDir = new File(LogFileRepository.FILE_PATH);

        if (!logDir.exists()) {
            model.addAttribute("error", logDir.getAbsolutePath() + " 폴더가 존재하지 않습니다.");
        }
        else {
            File[] logFiles = logDir.listFiles(new FileFilter() {
                public boolean accept(File file) {
                    if ( file.isFile() && file.getName().indexOf("log") != -1 ) {
                        return true;   
                    }
                    return false;
                }
            });
            Arrays.sort( logFiles, new Comparator<File>() {
                public int compare(File f1, File f2) {
                    return Long.valueOf(f2.lastModified()).compareTo(f1.lastModified());
                }
            });
            
            // TODO : 로그파일 갯수 제한 ????
            
            List<BaseFileBean> fileList = new ArrayList<BaseFileBean>();
            for (File file : logFiles) {
                BaseFileBean bean = new BaseFileBean();
                bean.setFileNm(file.getName());
                bean.setFileSize(FileUtil.toHumanSize(file.length()));
                bean.setExtension(DateTimeUtil.toDateFull(file.lastModified()));
                
                fileList.add(bean);
            }
            
            model.addAttribute("dataList", fileList);
        }
    }
    
    /**
     * 로그파일 상세조회
     */
    @RequestMapping(value="AR_logView.do", method=RequestMethod.POST)
    public void logView(ModelMap model, 
            @RequestParam(value="file",required=true) String file) throws IOException {
        
        File logFile = new File(LogFileRepository.FILE_PATH + SLASH + file);
        
        if (!logFile.exists()) {
            model.addAttribute("error", logFile.getAbsolutePath() + " 파일이 존재하지 않습니다.");
        }
        else {
            double size = logFile.length()/ONE_KB;
            if (size > 500) {
                model.addAttribute("exceed", "500 KB");
            }
            else {
                model.addAttribute("data", FileUtil.readUTFString(logFile));
            }
        }
    }

    /**
     * 라이센스 정보
     */
    @RequestMapping(value="AR_license.do", method=RequestMethod.GET)
    public void license(HttpServletRequest request, ModelMap model) {
    }
    
    /**
     * 서버 이중화 설정 정보
     */
    @RequestMapping(value="AR_dualServerInfo.do", method=RequestMethod.GET)
    public void dualServerInfo(HttpServletRequest request, ModelMap model) {

        model.addAttribute("excludeServerList", Config.getList("salmon.base.scheduler.exclude"));
        model.addAttribute("serverIp", multipleCacheReloadScheduler.getServerIpAddress());
        model.addAttribute("isExcludeServer", multipleCacheReloadScheduler.isExcludeServer());
        model.addAttribute("cacheServerList", cacheManager.getServerList());
    }

}
