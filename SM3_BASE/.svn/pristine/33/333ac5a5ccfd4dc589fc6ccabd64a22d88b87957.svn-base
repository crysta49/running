package com.srpost.salmon.web.tag.ui;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import com.srpost.salmon.bean.BasePagerBean;
import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.web.tag.SalmonTagSupport;


/**
 * Salmon 목록 '자료없음' 표시용 taglib
 *
 * @author  finkle
 * @date    2015-01-02
 * @since   2.0
 */
public class NoDataTag extends SalmonTagSupport {

    private Object dataBean;
    private Integer colspan = 0;
    private String msg;
    
    public void doTag() throws JspException, IOException {

        if (dataBean == null) return;
        
        JspWriter writer = getJspContext().getOut();

        if (dataBean instanceof BasePagerBean) {
            List<?> list = ((BasePagerBean)dataBean).getList();
            if (StringUtil.isNotEmpty(list)) return;
        } 
        else if (dataBean instanceof List<?>) {
            List<?> list = (List<?>)dataBean;
            if (StringUtil.isNotEmpty(list)) return;
        } 
        else if (dataBean instanceof Object[]) {
            Object[] oArray = (Object[])dataBean;
            if (StringUtil.isNotEmpty(oArray)) return;
        }
        /*--
        else {
            return;
        } --*/
        
        if (StringUtil.isEmpty(msg)) {
            msg = Message.get("common.label.nodata");
        }
        if (msg.indexOf(Message.FAIL) != -1) {
            msg = "표시할 자료가 없습니다.";
        }
        
        StringBuilder html = new StringBuilder();

        if (colspan > 0) {
            html.append("<tr>\n");
            html.append("<td class=\"tc bg-box bg-info\" colspan=\"" + colspan + "\"");
            html.append("><span class=\"text-info\"><i class=\"glyphicon glyphicon-exclamation-sign\"></i> " + msg + "</span></td>\n");
            html.append("</tr>\n");
        }
        else {
            html.append("<div class=\"tc bg-box bg-info text-info\"><i class=\"glyphicon glyphicon-exclamation-sign\"></i> " + msg + "</div>\n");
        }
        
        
        writer.write(html.toString());
    }

    public void setDataBean(Object dataBean) {
        this.dataBean = dataBean;
    }

    public void setColspan(Integer colspan) {
        this.colspan = colspan;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}