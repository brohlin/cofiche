<%@ page language="java" import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="org.undp.database.*" %>
<%@ page import="org.undp.log.*" %>
<%@ page import="org.undp.utils.*" %>
<%@ page import="org.undp.utils.arrays.*" %>



<%	
	ServletContext context = pageContext.getServletContext();
	request.setCharacterEncoding("UTF-8");
	String p_email = request.getParameter("email");
	String p_pwd = request.getParameter("pwd");
	String p_page_target = request.getParameter("page");
	String p_country_id = request.getParameter("country_id");
	DynStringArray parameters = new DynStringArray();
	parameters.add(p_email);
	parameters.add(p_pwd);

	DbResults db = Database.callProcResults("p_get_user", parameters);
	DbResults db_user_country_access;
	
	int size=0;
	
	if (db.getRowCount()>size) {
		while(size<db.getRowCount())
		{
			session.setAttribute("user_id",db.getRow(size).get(0));
			session.setAttribute("user_user_status_id",db.getRow(size).get(1));
			session.setAttribute("user_user_status_nm",db.getRow(size).get(2));
			session.setAttribute("user_role_id",db.getRow(size).get(3));
			session.setAttribute("user_role_nm",db.getRow(size).get(4));
			session.setAttribute("user_email",db.getRow(size).get(5));
			session.setAttribute("user_pwd",db.getRow(size).get(6));
			session.setAttribute("user_first_nm",db.getRow(size).get(7));
			session.setAttribute("user_last_nm",db.getRow(size).get(8));
			session.setAttribute("user_position_title",db.getRow(size).get(9));
			session.setAttribute("user_tel_nbr",db.getRow(size).get(10));
			session.setAttribute("user_skype_handle",db.getRow(size).get(11));

			parameters.clear();
			parameters.add(db.getRow(size).get(0));
			size++;
		}

		db_user_country_access = Database.callProcResults("p_get_user_country_access", parameters);
		System.out.println("DO I MAKE IT HERE?");
		session.setAttribute("user_country_access", db_user_country_access);
		
		
		if (p_page_target.equals("at-a-glance")) {
			response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/" + p_page_target + ".jsp?country_id=" + p_country_id);
		} else if (p_page_target.equals("country_report")) {
			response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/" + p_page_target + ".jsp?country_id=" + p_country_id);
		} else if (p_page_target.equals("create_at_a_glance")) {
			response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/" + p_page_target + ".jsp?country_id=" + p_country_id);
		} else if (p_page_target.equals("create_country_pdf")) {
			response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/" + p_page_target + ".jsp?country_id=" + p_country_id);
		} else if (p_page_target.equals("field_value_history")) {
			response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/" + p_page_target + ".jsp?country_id=" + p_country_id);
		} else {
			response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=" + p_page_target);
		}
		
	} else if (db.getRowCount() == 0) { 
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=login&message=failed_login");
	} else {
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=error");
	}
	
%>