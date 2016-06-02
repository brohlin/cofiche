<%
ServletContext context = pageContext.getServletContext();

session.setAttribute("user_id",null);
session.setAttribute("user_user_status_id",null);
session.setAttribute("user_user_status_nm",null);
session.setAttribute("user_role_id",null);
session.setAttribute("user_role_nm",null);
session.setAttribute("user_email",null);
session.setAttribute("user_pwd",null);
session.setAttribute("user_first_nm",null);
session.setAttribute("user_last_nm",null);
session.setAttribute("user_position_title",null);
session.setAttribute("user_tel_nbr",null);
session.setAttribute("user_skype_handle",null);

response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=home");

%>