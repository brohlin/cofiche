<%@ page language="java" import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="org.undp.database.*" %>
<%@ page import="org.undp.log.*" %>
<%@ page import="org.undp.utils.*" %>
<%@ page import="org.undp.utils.arrays.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>

<%	
	ServletContext context = pageContext.getServletContext();
	request.setCharacterEncoding("UTF-8");
	String p_report_id = request.getParameter("report_id");	
	String p_country_id = request.getParameter("country_id");	
	int y = 0;

	
	DynStringArray parameters = new DynStringArray();
	parameters.add(p_report_id);
	
	try {
		y = Database.callProc("p_del_report", parameters);
		
	} catch (Exception e) {
		e.printStackTrace();
		LogManager.writeLog("Delete report", e.getMessage());
	}
	
	if (y==1) {	
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=view_reports&country_id=" + p_country_id);
	} else {
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=error");
	}
	
	

%>