package com.srpost.salmon.web.tag.ui;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import com.srpost.salmon.lang.StringUtil;

/**
 * Salmon button layout taglib
 *
 * @author  finkle
 * @date    2014-10-22
 * @since   2.0
 */
public class ButtonLayoutTag extends SimpleTagSupport {

    private String align = "right";
    public void setAlign(String align) {
        this.align = align;
    }
    
    private boolean group = false;
    public void setGroup(boolean group) {
        this.group = group;
    }
    
    public void doTag() throws JspException, IOException {
        
        JspWriter writer = getJspContext().getOut();
        
        StringBuilder css = new StringBuilder();
        css.append("btn-blank");
        if ( StringUtil.equals(align, "both"))
            css.append(" row");
        else if ( StringUtil.equals(align, "left"))
            css.append(" text-left");
        else if ( StringUtil.equals(align, "center"))
            css.append(" text-center");
        else if ( StringUtil.equals(align, "right"))
            css.append(" text-right");

        writer.write("<div class=\"" + css + "\">\n");
        
        if (group) writer.write("<div class=\"btn-group\">\n");
            
        getJspBody().invoke(null);

        if (group) writer.write("</div>\n");
        
        writer.write("</div>\n");
    }
}