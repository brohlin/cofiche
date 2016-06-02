<%@ page language="java" import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="org.undp.database.*" %>
<%@ page import="org.undp.log.*" %>
<%@ page import="org.undp.utils.*" %>
<%@ page import="org.undp.utils.arrays.*" %>
<%@ page import="com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException" %>


<%
	ServletContext context = pageContext.getServletContext();
	request.setCharacterEncoding("UTF-8");
	String p_role = request.getParameter("role");
	String p_user_status = request.getParameter("user_status");
	String p_email = request.getParameter("email");
	String p_first_nm = request.getParameter("first_nm");
	String p_last_nm = request.getParameter("last_nm");
	String p_position_title = request.getParameter("position_title");
	String p_tel_nbr = request.getParameter("tel_nbr");
	String p_skype_handle = request.getParameter("skype_handle");	
	String p_pwd = request.getParameter("pwd");
	String p_user_id = request.getParameter("user_id");		
	
	DynStringArray parameters = new DynStringArray();
	parameters.clear();
	parameters.add(p_user_status);
	parameters.add(p_role);
	parameters.add(p_email);
	parameters.add(p_pwd);
	parameters.add(p_first_nm);
	parameters.add(p_last_nm);
	parameters.add(p_position_title);
	parameters.add(p_tel_nbr);
	parameters.add(p_skype_handle);
	parameters.add(p_user_id);
	
	int x = 0;
	
	x = Database.callProc("p_upd_user", parameters);

	if (x>0) {
		
		if (session.getAttribute("user_role_nm") != null && session.getAttribute("user_role_nm").equals("ADMIN")) {
			response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=manage_user_accounts");
		} else {
			response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=home");
		}
	} else {
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=error");
	}

%>