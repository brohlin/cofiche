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
	String p_organization = request.getParameter("organization");		
	

	DynStringArray parameters2 = new DynStringArray();
	parameters2.add(p_email);
	
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
	parameters.add(p_organization);

	int x = 0;
	int z = 0;
	
	try {
		x = Database.callProc("p_ins_user", parameters);
	} catch (MySQLIntegrityConstraintViolationException m) {
		z = -1;
	}
	
	if (z<0) {
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=user_account&message=user_email_already_exists&email=" + p_email);
	} else if (x>0) {
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=manage_accounts");
	} else {
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=error");
	}

%>