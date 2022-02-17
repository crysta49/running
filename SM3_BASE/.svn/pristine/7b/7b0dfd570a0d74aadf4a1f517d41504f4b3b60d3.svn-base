package com.srpost.cm.bo.base.file;

import java.util.List;

import com.srpost.salmon.bean.BaseFileBean;
import com.srpost.salmon.bean.BasePagerBean;


/**
 * 공용 파일처리 서비스 인터페이스
 *
 * @author  finkle
 * @date    2014-11-14
 * @since   2.0
 */
public interface IFileService {

    List<BaseFileBean> list(Integer fileSeq);
    
    BaseFileBean view(String fileId);
    
    int insertAction(List<BaseFileBean> fileList);
    
    int insertAction(List<BaseFileBean> fileList, Integer fileSeq);
    
    int insertAction(List<BaseFileBean> fileList, Integer fileSeq, String inputNm);
    
    int deleteAction(Integer fileSeq);
    
    int deleteAction(Integer fileSeq, String fileId);
    
    int deleteAction(Integer fileSeq, String[] fileIds);
    
    void updateDownCntAction(FileLogBean logBean);
    
    BasePagerBean listLog(FileLogBean bean);
}
