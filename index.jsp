<%
	ServletContext context = pageContext.getServletContext();
	response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=login");
%>
