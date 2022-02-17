package com.srpost.cm.bo.base.hday;

import static com.srpost.salmon.constant.StringPool.*;

import com.srpost.salmon.lang.DateTimeUtil;


/**
 * 내부단 공휴일 정보 Util
 *
 * @author  finkle
 * @date    2014-11-07
 * @since   2.0
 */
public final class HdayUtil {
    
    /** 공휴일 반복주기 : 없음 */
    public final static int NO_CYCLE = 4000;
    /** 공휴일 반복주기 : 매주 */
    public final static int EVERY_WEEK = 4001;
    /** 공휴일 반복주기 : 매월 */
    public final static int EVERY_MONTH = 4002;
    /** 공휴일 반복주기 : 매년 */
    public final static int EVERY_YEAR = 4003;

    
    public static void setNotNullValue(HdayBean bean) {
        
        if ( bean.getCycle() == EVERY_WEEK ) {
            bean.setStartDd(EMPTY);
            bean.setEndDd(EMPTY);
        }
        else {
            bean.setStartDd( DateTimeUtil.removeDash(bean.getStartDd()) );
            bean.setEndDd( DateTimeUtil.removeDash(bean.getEndDd()) );
            
            bean.setDow(ZERO);
            bean.setWeek(ZERO);
        }
        
        if ( bean.getCycle() != EVERY_YEAR ) {
            bean.setLunarYn("N");
        }
    }
}
