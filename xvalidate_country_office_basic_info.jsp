ï»¿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 


<%@ page language="java" import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="org.undp.database.*" %>
<%@ page import="org.undp.log.*" %>
<%@ page import="org.undp.utils.*" %>
<%@ page import="org.undp.utils.arrays.*" %>

<%	
	request.setCharacterEncoding("UTF-8");
	String p_organization_id = request.getParameter("id");
	
	DynStringArray parameters = new DynStringArray();
	parameters.clear();
	parameters.add(request.getParameter("id"));
	parameters.add(request.getParameter("name"));


	int x = Database.callProc("p_upd_country_office_basic_info", parameters);

	if (x>0) {
		response.sendRedirect("/cofiche/main.jsp?target=country&section=overview&country_id=" + p_country_id);
	} else {
		response.sendRedirect("/cofiche/main.jsp?target=error");
	}

%>