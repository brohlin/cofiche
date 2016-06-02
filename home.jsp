<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ page language="java" import="java.sql.*" %>
<%@ page import="org.undp.database.*" %>
<%@ page import="org.undp.utils.*" %>
<%@ page import="org.undp.utils.arrays.*" %>
<%@ page import="org.undp.log.*" %>

<%
	ServletContext context = pageContext.getServletContext();
	String un = (String) session.getAttribute("user_id");
	System.out.println(un);
	if ( un == null || un.equals("null")) {
		System.out.println("in if statement");
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=login&page=home");
		System.out.println("after redirect");
		return;
	} else {
	
		System.out.println("in else statement");
%>

<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	String _country_id = request.getParameter("country_id");

	if (_country_id.equals("0")) {
		_country_id = "101";
	}

	DynStringArray parameters = new DynStringArray();
	parameters.add(_country_id);
	
	DbResults db_country2 = Database.callProcResults("p_get_country_all_cols", parameters);


	String _prev = db_country2.getRow(0).get(8); 
	String _next = db_country2.getRow(0).get(9);
%>

<section>
	<header>
		<div class="bc-gray-2d text-white padding-small borde-inferior">
			<div class="container">
				<h3 class="text-white">&nbsp;</h3>
				<h1 class="text-white">COUNTRY FICHE</h1>
			</div>
		</div>
	</header>
	

	<div class="container-fluid bc-gray ">
		<div id="carrusel-objetivos" class="carousel slide padding-medium separador-top separador-bottom" data-ride="carousel">
			
				<jsp:include page="at-a-glance.jsp">
					<jsp:param name="country_id" value="<%= _country_id %>"/>
		   			<jsp:param name="pnud_logo" value="no"/>
				</jsp:include>	

				<!-- Controls -->
				<a class="left carousel-control " href="/cofiche/main.jsp?target=home&country_id=<%= _prev %>" role="button" data-slide="prev">
					<span class="glyphicon glyphicon-chevron-left "></span>
					<span class="sr-only">Previous</span>
				</a>
				
				<a class="right carousel-control " href="/cofiche/main.jsp?target=home&country_id=<%= _next %>" role="button" data-slide="next">
					<span class="glyphicon glyphicon-chevron-right  "></span>
					<span class="sr-only">Next</span>
				</a>

		</div>		

	</div>
	
</section>

<%
	}
%>