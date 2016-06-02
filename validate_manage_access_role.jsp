<%@ page language="java" import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="org.undp.database.*" %>
<%@ page import="org.undp.log.*" %>
<%@ page import="org.undp.utils.*" %>
<%@ page import="org.undp.utils.arrays.*" %>



<%
	ServletContext context = pageContext.getServletContext();
	request.setCharacterEncoding("UTF-8");
	int size=0;
	int x=0;

	String p_access_id = "";
	String p_country_id = request.getParameter("country_id");
	DynStringArray parameters = new DynStringArray();
	DbResults db_roles = Database.callProcResults("p_get_roles", parameters);
	String p_user_id = session.getAttribute("user_id").toString();
	
	try {
		while( size<db_roles.getRowCount() )
		{
			p_access_id = request.getParameter(db_roles.getRow(size).get(0));
			parameters.clear();
			

			parameters.add(p_country_id);
			parameters.add(db_roles.getRow(size).get(0));
			parameters.add(p_access_id);
			parameters.add(p_user_id);
			
			try {
				x =  Database.callProc("p_ins_country_role", parameters);
			} catch (SQLException sql) {
				x =  Database.callProc("p_upd_country_role", parameters);
			}

			
			size++;
		}
		
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=manage_access&country_id=" + p_country_id);
		
	} catch (Exception e) {
		LogManager.writeLog("Manage Access Role", e.getMessage());
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=error");
	}
	
	
%>