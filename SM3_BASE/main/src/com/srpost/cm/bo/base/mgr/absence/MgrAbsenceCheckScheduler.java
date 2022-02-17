package com.srpost.cm.bo.base.mgr.absence;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.srpost.salmon.scheduelr.BaseScheduler;

/**
 * 부재중 직원 부재기간 체크 스케줄러
 * 
 * @author  finkle
 * @date    2015-09-03
 * @since   3.0
 */
public class MgrAbsenceCheckScheduler extends BaseScheduler {

    protected final Logger logger = LoggerFactory.getLogger(getClass());

	@Resource
	MgrAbsenceDao maDao;

	public void doSchedule() {

        if ( isExcludeServer() ) return;

        int affected = maDao.deleteInvalidAbsenceDataAction();
        
        if (affected > 0)
            logger.info("Delete invalid absence data : {}", affected);
	}
}
