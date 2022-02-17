package com.srpost.cm.bo.base.file;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.srpost.salmon.bean.BaseFileBean;
import com.srpost.salmon.bean.BasePagerBean;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 공용 파일처리 서비스 구현체
 *
 * @author  finkle
 * @date    2014-11-14
 * @since   2.0
 */
@Service
public class FileServiceImpl extends EgovAbstractServiceImpl implements IFileService {

    @Resource
    FileDao dao;

    @Override
    public List<BaseFileBean> list(Integer fileSeq) {
        
        return dao.list(fileSeq);
    }

    @Override
    public BaseFileBean view(String fileId) {
        
        return dao.view(fileId);
    }

    @Override
    public int insertAction(List<BaseFileBean> list) {
        
        return insertAction(list, -1);
    }

    @Override
    public int insertAction(List<BaseFileBean> list, Integer fileSeq) {
        
        return insertAction(list, fileSeq, null);
    }

    @Override
    public int insertAction(List<BaseFileBean> list, Integer fileSeq, String inputNm) {
        
        return dao.insertAction(list, fileSeq, inputNm);
    }

    @Override
    public int deleteAction(Integer fileSeq) {
        
        return dao.deleteAction(fileSeq);
    }

    @Override
    public int deleteAction(Integer fileSeq, String fileId) {
        
        return deleteAction(fileSeq, new String[] {fileId});
    }

    @Override
    public int deleteAction(Integer fileSeq, String[] fileIds) {
        
        return dao.deleteAction(fileSeq, fileIds);
    }

    @Override
    public void updateDownCntAction(FileLogBean logBean) {
        
        dao.updateDownCntAction(logBean);
    }
    
    @Override
    public BasePagerBean listLog(FileLogBean bean) {
        
        return dao.listLog(bean);
    }
}
