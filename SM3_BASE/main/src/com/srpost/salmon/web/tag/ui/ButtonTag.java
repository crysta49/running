package com.srpost.salmon.web.tag.ui;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;

import com.srpost.salmon.constant.Message;
import com.srpost.salmon.lang.StringUtil;
import com.srpost.salmon.web.tag.SalmonTagSupport;

/**
 * Salmon button taglib
 *
 * @author  finkle
 * @date    2014-10-22
 * @since   2.0
 */
public class ButtonTag extends SalmonTagSupport {

    private String id;
    private String type = "button";
    private String value;
    private String msgKey;
    private String icon;
    private String glyph;
    private String tip;
    private String badge;
    private String cssClass;
    private String btnSize = "btn-sm";
    

    private String onclick;
    
    public void setId(String id) {
        this.id = id;
    }
    public void setType(String type) {
        this.type = type;
    }
    public void setValue(String value) {
        this.value = value;
    }
    public void setMsgKey(String msgKey) {
        this.msgKey = msgKey;
    }
    public void setIcon(String icon) {
    	this.icon = icon;
    }
    public void setGlyph(String glyph) {
        this.glyph = glyph;
    }
    public void setTip(String tip) {
        this.tip = tip;
    }
    public void setBadge(String badge) {
        this.badge = badge;
    }
    public void setOnclick(String onclick) {
        this.onclick = onclick;
    }
    public void setCssClass(String cssClass) {
        this.cssClass = cssClass;
    }
    public void setBtnSize(String btnSize) {
        this.btnSize = btnSize;
    }
    
    public void doTag() throws JspException, IOException {

        StringBuilder html = new StringBuilder();

        html.append("<button");
        html.append(" data-loading-text=\"처리중 ..\"");
        html.append(" type=\"" + type + "\"");
        
        if ( StringUtil.isNotEmpty(id) )
            html.append(" id=\"" + id + "\"");
        
        if ( StringUtil.isNotEmpty(onclick) )
            html.append(" onclick=\"" + onclick + "\"");
        
        if ( StringUtil.isNotEmpty(tip) )
            html.append(" data-toggle=\"tooltip\" data-placement=\"top\" title=\"" + tip + "\"");
        
        html.append(" class=\"btn");
        
        if ( !StringUtil.equals(btnSize, "btn-md") )
            html.append(" " + btnSize);
        
        if ( StringUtil.isNotEmpty(cssClass) )
            html.append(" " + cssClass);
        else
            html.append(" btn-salmon");
        
        html.append("\" >");

        if ( StringUtil.isNotEmpty(glyph) )
            html.append("\n<span class=\"glyphicon glyphicon-" + glyph + "\"></span> ");
        else if ( StringUtil.isNotEmpty(icon) )
            html.append("\n<span class=\"" + icon + "\"></span> ");

        if ( StringUtil.isNotEmpty(msgKey) )
            value = Message.get(msgKey);
        
        html.append(value);
        
        if ( StringUtil.isNotEmpty(badge) )
            html.append("\n<span class=\"badge\">" + badge + "</span>");
        
        html.append("</button>");
        
        JspWriter writer = getJspContext().getOut();

        writer.write(html.toString());
    }
}