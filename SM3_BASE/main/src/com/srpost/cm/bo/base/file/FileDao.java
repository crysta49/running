package com.srpost.cm.bo.base.file;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.srpost.salmon.bean.BaseFileBean;
import com.srpost.salmon.bean.BasePagerBean;
import com.srpost.salmon.lang.FileUtil;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.spi.egov.ISalmonSeqGenerator;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;
import static com.srpost.salmon.constant.StringPool.ONE;
import static com.srpost.salmon.constant.StringPool.ZERO;

/**
 * 공용 파일처리 DAO
 *
 * @author  finkle
 * @date    2014-11-14
 * @since   2.0
 */
@Repository
public class FileDao extends EgovAbstractMapper {

    @Resource(name = "fileSeqGenerator")
    ISalmonSeqGenerator seqGenerator;
    
    public List<BaseFileBean> list(Integer fileSeq) {

        if (FileCommonUtil.isValidFileSeq(fileSeq))
            return selectList("_file.list", fileSeq);
        
        return null;
    }
    
    public BaseFileBean view(String fileId) {

        return (BaseFileBean)selectOne("_file.view", fileId);
    }
    
    public int insertAction(List<BaseFileBean> list) {
        return insertAction(list, -1);
    }
    public int insertAction(List<BaseFileBean> list, Integer fileSeq) {
        return insertAction(list, fileSeq, null);
    }
    public synchronized int insertAction(List<BaseFileBean> list, Integer fileSeq, String inputNm) {

        if ( StringUtil.isNotEmpty(list) ) {
            
            if (!FileCommonUtil.isValidFileSeq(fileSeq)) {
                fileSeq = seqGenerator.getNextInteger();
            }
            
            for (BaseFileBean item : list) {

                item.setFileSeq(fileSeq);                
                FileCommonUtil.setNotNullValue(item);
                        
                update("_file.insert", item);
            }
        }
        return fileSeq;
    }
    
    public int deleteAction(Integer fileSeq) {

        if (!FileCommonUtil.isValidFileSeq(fileSeq)) return ZERO;
        
        List<BaseFileBean> fileList = selectList("_file.list", fileSeq);
        
        int affected = delete("_file.deleteAll", fileSeq);
        
        if (affected > 0) {
            try {
                for (BaseFileBean baseFileBean : fileList) {
                    FileUtil.deleteFile( baseFileBean.getFilePath() );
                }
            }
            catch (IOException e) {
                logger.warn("Failed to delete the file.", e);
            }
        }
        return affected;
    }
    
    public int deleteAction(Integer fileSeq, String fileId) {

        return deleteAction(fileSeq, new String[] {fileId});
    }
    
    public int deleteAction(Integer fileSeq, String[] fileIds) {

    	 if (!FileCommonUtil.isValidFileSeq(fileSeq)) return ZERO;
         
         int affected = ZERO;
         
         if ( StringUtil.isNotEmpty(fileIds) ) {
             
             List<BaseFileBean> fileList = selectList("_file.list", fileSeq);
             
             for (String fileId : fileIds) {
                 for (BaseFileBean baseFileBean : fileList) {
                     if ( StringUtil.equals(fileId, baseFileBean.getFileId()) ) {
                         affected += delete("_file.delete", baseFileBean);                        
                         try {
                             FileUtil.deleteFile( baseFileBean.getFilePath() );
                         } catch (Exception e) {
                             logger.warn("Failed to delete the file.", e);
                         }
                         
                         break;
                     }
                 }
             }
         }
         return affected;         
             	
	   /*
	    * allen 주석 처리함 
	    * 파일이 없으면 FileUtil.deleteFile Lib 에서 강제 오류 처리함
	    * 파일이 없어도 DB는 지워주고 물리적 파일은 무시한다.
	    * 
        if (!FileCommonUtil.isValidFileSeq(fileSeq)) return ZERO;
        
        int affected = ZERO;
        
        if ( StringUtil.isNotEmpty(fileIds) ) {
            
            List<BaseFileBean> fileList = selectList("_file.list", fileSeq);
            try {
                for (String fileId : fileIds) {
                    for (BaseFileBean baseFileBean : fileList) {
                        if ( StringUtil.equals(fileId, baseFileBean.getFileId()) ) {
                            FileUtil.deleteFile( baseFileBean.getFilePath() );
                            affected += delete("_file.delete", baseFileBean);
                            break;
                        }
                    }
                }
            }
            catch (IOException e) {
                logger.warn("Failed to delete the file.", e);
            }
        }
        return affected;*/
    }
    
    
    public void updateDownCntAction(FileLogBean bean) {
        
        int affected = update("_file.updateDownCnt", bean.getFileId());
        
        if (affected == ONE) {
            String fileId = selectOne("_file.viewLog", bean);
            if (StringUtil.isEmpty(fileId)) {
                insert("_file.insertLog", bean);
            }
            else {
                update("_file.updateLog", bean);
            }
        }
    }
    
    public BasePagerBean listLog(FileLogBean bean) {
        
        Map<String, Object> parameterMap = FileCommonUtil.getParameterMap(bean);
        
        List<FileLogBean> dataList = selectList("_file.listLog", parameterMap);
        int totalCount = (Integer)selectOne("_file.listLogCount", parameterMap);

        return new BasePagerBean(dataList, totalCount, bean);
    }
    
    
    
    
    
    /*
    public int fileReplaceAction(List<BaseFileBean> fileList, Integer fileSeq, String inputNm) {
        
        int affected = ZERO;
        
        if (fileSeq <= 0) return affected;
        if ( StringUtil.isEmpty(inputNm) ) return affected;
        if ( StringUtil.isEmpty(fileList) ) return affected;

        List<BaseFileBean> dataList = selectList("_file.list", fileSeq);
        for (BaseFileBean baseFileBean : dataList) {
            if ( inputNm.equals(baseFileBean.getInputNm()) ) {
                FileUtil.delete( baseFileBean.getFilePath() );
                affected += delete("_file.fileDelete", baseFileBean);
            }
        }
        
        return insertAction(fileList, fileSeq, inputNm);
    } */
    
    /*
     * VOC 처리 시 FAQ 자동 등록 처럼 물리 파일 이동없이 파일 ID만 복사, 추가하는 경우 사용됨
    public List<BaseFileBean> renameFileId(List<BaseFileBean> fileList) {
        
        List<BaseFileBean> newList = new ArrayList<BaseFileBean>();
        
        for (BaseFileBean baseFileBean : fileList) {

            BaseFileBean fileBean = new BaseFileBean();
            
            fileBean.setFileId( UUID.randomUUID().toString() );
            fileBean.setFile( baseFileBean.getFile() );
            fileBean.setFilePath( baseFileBean.getFilePath() );
            fileBean.setFileUrl( baseFileBean.getFileUrl() );
            fileBean.setInputNm( baseFileBean.getInputNm() );
            fileBean.setFileNm( baseFileBean.getFileNm() );
            fileBean.setOrgFileNm( baseFileBean.getOrgFileNm() );
            fileBean.setFileType( baseFileBean.getFileType() );
            fileBean.setFileSize( baseFileBean.getFileSize() );
            fileBean.setExtension( baseFileBean.getExtension() );
            
            newList.add(fileBean);
        }
        return newList;
    } */
    
    /*--
    public void resizeImage(BaseFileBean baseFileBean, int width, int height) {
        
        List<BaseFileBean> list = new ArrayList<BaseFileBean>();
        list.add(baseFileBean);
        
        resizeImage(list, width, height);
    }
    public void resizeImage(List<BaseFileBean> fileList, int width, int height) {
        
        resizeImage(fileList, width, height, null);
    }
    public void resizeImage(List<BaseFileBean> fileList, int width, int height, String inputNm) {
        
        if ( Validator.isEmpty(fileList) ) return;
        
        for (BaseFileBean baseFileBean : fileList) {

            if ( Utils.isImage(baseFileBean.getFileType()) ) {
                if (inputNm != null && !inputNm.equals(baseFileBean.getInputNm())) {
                    continue;
                }
                File resizeFile = Utils.resizeImage(baseFileBean.getFile(), baseFileBean.getExtension(), width, height);
                if (resizeFile != null) {
                    baseFileBean.setFileSize(FileUtil.toDisplaySize(resizeFile));
                }
            }
        }
    }--*/
}
