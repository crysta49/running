package com.srpost.cm.bo.fm.voc.suppoter;

import static com.srpost.salmon.constant.StringPool.*;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import com.srpost.cm.bo.base.hday.HdayBean;
import com.srpost.cm.bo.base.hday.HdayCache;
import com.srpost.cm.bo.base.hday.HdayUtil;
import com.srpost.cm.bo.base.hday.Lunar;
import com.srpost.salmon.cache.Cache;
import com.srpost.salmon.constant.Config;
import com.srpost.salmon.lang.DateTimeUtil;
import com.srpost.salmon.lang.StringUtil;

/**
 * VOC 처리기한 계산기
 *
 * @author  finkle
 * @date    2014-12-01
 * @since   3.0
 */
@SuppressWarnings("unchecked")
public class LmtDtCalculator {
    
    /* 휴일 목록 */
    protected List<HdayBean> hdayList;
    /* 처리기산 산정 로그 */
    private StringBuilder lmtDtLog = new StringBuilder();

    public LmtDtCalculator() {
        this.hdayList = (List<HdayBean>)Cache.get(HdayCache.LIST_KEY);
    }
    
    /*
     * 지정한 날짜가 휴일인지 판단
     */
    public boolean isHoliday(Calendar target) {
        return isHoliday(target, true);
    }
    protected boolean isHoliday(Calendar target, boolean logging) {
        
        if (StringUtil.isNotEmpty(hdayList)) {
            
            for (HdayBean item : hdayList) {
                
                if (item.getCycle() == HdayUtil.EVERY_WEEK) {
                    if (
                        (item.getWeek() == ZERO || /* 매주 */
                                target.get(Calendar.WEEK_OF_MONTH) == item.getWeek()) && 
                            target.get(Calendar.DAY_OF_WEEK) == item.getDow()) 
                    {
                        if (logging) lmtDtLog.append( parseLogData(target, item.getHdayNm()) );
                        return true;
                    }
                }
                else {
                    Calendar start = DateTimeUtil.toCalendar(item.getStartDd());
                    Calendar end = DateTimeUtil.toCalendar(item.getEndDd());
                    
                    if (item.getCycle() == HdayUtil.NO_CYCLE) {
                        if ( isContains(target, start, end) ) {
                            if (logging) lmtDtLog.append( parseLogData(target, item.getHdayNm()) );
                            return true; /* 대상일자가 공휴일 시작, 종료일자 구간에 포함됨 */
                        }
                    }
                    else if (item.getCycle() == HdayUtil.EVERY_MONTH) {
                        
                        int targetDay = target.get(Calendar.DAY_OF_MONTH);
                        int startDay = start.get(Calendar.DAY_OF_MONTH);
                        int endDay = end.get(Calendar.DAY_OF_MONTH);
                        
                        if (startDay <= targetDay && endDay >= targetDay) {
                            if (logging) lmtDtLog.append( parseLogData(target, item.getHdayNm()) );
                            return true; /* 대상일자가 대상월(月) 시작, 종료일자 구간에 포함됨 */
                        }
                    }
                    else if (item.getCycle() == HdayUtil.EVERY_YEAR) {
    
                        if (StringUtil.equals(item.getLunarYn(), Y)) {
                            
                            boolean isBigHoliday = isBigHoliday(start);
                            
                            start = toSolar(start);
                            end = toSolar(end);
                            
                            // 구정, 추석은 당일의 전, 후일 모두 휴일처리 (연휴 3일로 계산)
                            if ( isBigHoliday ) {
                                start.add(Calendar.DAY_OF_MONTH, -1);
                                end.add(Calendar.DAY_OF_MONTH, 1);
                            }
                        }
    
                        if( isContainsForRemoveYear(target, start, end) ) {
                            if (logging) lmtDtLog.append( parseLogData(target, item.getHdayNm()) );
                            return true; /* 대상일자가 대상월(月), 일(日) 시작, 종료일자 구간에 포함됨 */
                        }
                    }
                }
            }
        }
        
        // 토요일 계산
        if (target.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY) {
            return true;
        }
        // 일요일 계산
        else if (target.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
            if (logging) lmtDtLog.append( parseLogData(target, "일요일") );
            return true;
        }
        
        return false;
    }
    
    /*
     * 지정한 날짜가 지정한 시작 ~ 종료일 구간에 포함되는지 확인
     */
    private boolean isContains(Calendar target, Calendar start, Calendar end) {
        
        int iTarget = Integer.parseInt(DateTimeUtil.totDateShortISO(target));
        int iStart = Integer.parseInt(DateTimeUtil.totDateShortISO(start));
        int iEnd = Integer.parseInt(DateTimeUtil.totDateShortISO(end));
        
        return iTarget >= iStart && iTarget <= iEnd;
    }
    private boolean isContainsForRemoveYear(Calendar target, Calendar start, Calendar end) {
        
        SimpleDateFormat sdFormat = new SimpleDateFormat("MMdd");
        
        int iTarget = Integer.parseInt(sdFormat.format(target.getTime()));
        int iStart = Integer.parseInt(sdFormat.format(start.getTime()));
        int iEnd = Integer.parseInt(sdFormat.format(end.getTime()));
        
        return iTarget >= iStart && iTarget <= iEnd;
    }
    
    /*
     * 지정한 날짜가 구정, 추석인지 확인
     */
    private boolean isBigHoliday(Calendar target) {
        
        int month = target.get(Calendar.MONTH) + 1;
        int day = target.get(Calendar.DAY_OF_MONTH);
        
        // 구정
        if (month == 1 && day == 1) return true;
        // 추석
        else if (month == 8 && day == 15) return true;

        return false;
    }
    
    /*
     * 지정한 날짜를 음력날짜로 변환
     */
    private Calendar toSolar(Calendar target) {
        
        Calendar now = Calendar.getInstance();
        Calendar lunar = (Calendar)target.clone();
        
        lunar.set(Calendar.YEAR, now.get(Calendar.YEAR));

        return DateTimeUtil.toCalendar( 
                Lunar.toSolar(DateTimeUtil.totDateShortISO(lunar), false) );
    }

    private String parseLogData(Calendar target, String day) {
        return DateTimeUtil.totDateShort(target.getTime()) + " : " + day + "\n";
    }
}
