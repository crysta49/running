package com.srpost.cm.bo.si.ipFilter;

import com.srpost.salmon.bean.BasePagerBean;

/**
 * 내부단 IP Filter 정보 서비스 인터페이스
 *
 */
public interface IIpFilterService {

    BasePagerBean list(IpFilterBean bean);
    
    IpFilterBean view(IpFilterBean bean);
    
    int insertAction(IpFilterBean bean);
    
    int updateAction(IpFilterBean bean);
    
    int deleteAction(IpFilterBean bean);
    
}