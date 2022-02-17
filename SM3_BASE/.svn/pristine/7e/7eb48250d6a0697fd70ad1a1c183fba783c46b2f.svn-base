package com.srpost.salmon.web.tag.ui;

import java.io.IOException;
import java.util.Date;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import jodd.datetime.Period;

import static com.srpost.salmon.constant.StringPool.*;

import com.srpost.salmon.lang.DateTimeUtil;
import com.srpost.salmon.lang.StringUtil;

/**
 * Salmon 새글 new 아이콘 표시용 taglib
 *
 * @author  finkle
 * @date    2015-12-31
 * @since   2.0
 */
public class NewIconTag extends SimpleTagSupport {

    private final String HTML = "<span class=\"t3-new\">&nbsp;</span>";
    
    private String date;
    private Integer day = 3; // 기본값 3일
    
    
    public void doTag() throws JspException, IOException {
        
        if (date == null) return;
        
        if (date.indexOf("-") != -1)
            date = StringUtil.replace(date, DASH, EMPTY);
        
        if (date.length() > 8)
            date = date.substring(0, 8);
        
        if (date.length() != 8) return;

        Period period = DateTimeUtil.diff(DateTimeUtil.toCalendar(date).getTime(), new Date());
        
        long diffDay = period.getDays();
        
        if ( diffDay >= day ) return;

        JspWriter writer = getJspContext().getOut();

        writer.write(HTML);
    }
    
    public String getDate() {
        return date;
    }
    public void setDate(String date) {
        this.date = date;
    }
    public Integer getDay() {
        return day;
    }
    public void setDay(Integer day) {
        this.day = day;
    }
}