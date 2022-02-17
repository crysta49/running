<%@page import="org.springframework.web.servlet.support.RequestContextUtils"%>
<%@page import="org.springframework.web.multipart.MultipartResolver"%>
<%@page import="jodd.datetime.*"%>
<%@page import="com.srpost.salmon.spi.crypto.SalmonCrypto"%>
<%@page import="org.springframework.util.AntPathMatcher"%>
<%@page import="com.srpost.salmon.cache.Cache"%>
<%@page import="java.util.*, com.srpost.salmon.lang.StringUtil"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.*"%>
<%@page import="com.srpost.cm.bo.base.menu.front.*"%>

SAMPLE

<%--
    Map<String, List<MenuFrontBean>> cacheMap = 
        (Map<String, List<MenuFrontBean>>)Cache.get(MenuFrontCache.MENU_MAP_KEY);
    
    AntPathMatcher apm = new AntPathMatcher();
--%>


<%//= apm.match("/**/bbs/NR_*.do*bbsCd=1", "/fe/bbs/NR_view.do?aaaa=bbbb&bbsCd=1") %>

<%--
    ServletContext servletContext = this.getServletContext();
    WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
    
    SalmonCrypto crypto = (SalmonCrypto)wac.getBean("salmonCrypto");
    
    out.println( "____" + crypto.encodePassword("1111") + "____");
--%>

<%--
JDateTime jdt1 = new JDateTime("2015-12-31 10:10:10");
JDateTime jdt2 = new JDateTime(new Date());

Period p = new Period(jdt1, jdt2);

StringBuilder builder = new StringBuilder();

builder.append("--------------------------------\n");
builder.append("시작일 : " + jdt1.toString("YYYY-MM-DD hh:mm:ss") + "\n");
builder.append("종료일 : " + jdt2.toString("YYYY-MM-DD hh:mm:ss") + "\n");
builder.append("위 두 날짜의 차이는 ....\n");
builder.append(p.getDays() + "일\n");
builder.append(p.getHours() + "시간\n");
builder.append(p.getMinutes() + "분\n");
builder.append(p.getSeconds() + "초\n");
builder.append("--------------------------------\n");

out.println(builder.toString());
--%>

<%--
    ServletContext servletContext = this.getServletContext();
    WebApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(servletContext);
    WebApplicationContext wac2 = RequestContextUtils.getWebApplicationContext(request);
    out.println( "____" + wac2.getBean("filterMultipartResolver") + "____");
--%>

