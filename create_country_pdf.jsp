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
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=login&page=create_country_pdf");
		System.out.println("after redirect");
		return;
	} else {
	
		System.out.println("in else statement");
%>

<%
	String _country_id = request.getParameter("country_id");

	DynStringArray parameters = new DynStringArray();
	parameters.add(_country_id);
	DbResults db = Database.callProcResults("p_get_country", parameters);

%>

<section role="dialog" class="borde-superior fondo-gris">

	<header>
		<div class="bc-gray-2d text-white padding-small borde-inferior">
			<div class="container">
				<h3 class="text-white">Create Country PDF</h3>
				<h1 class="text-white"><%= db.generateHtml() %></h1>
			</div>
		</div>
	</header>
		
	<div class="container">
		<div class="col-xs-12 col-lg-8 cuadrado separador-top separador-bottom">
			<form class="form-plantilla" role="form" action="validate_create_country_pdf.jsp" method="post">
				<input name="country_id" value="<%= _country_id %>" type="hidden">
				<label for=\"title">Title</label><br>
				<input class="form-control" name="title" id="title" value="" type="text" maxlength="100">
				
				<label for=\"description">Description</label><br>
				<textarea maxlength="10000" rows="5" cols="50" id="description" name="description" class="" placeholder="Enter the description"></textarea>
					<button type="submit" class="btn btn-info btn-block separador-top">SAVE</button>
			</form>	
		</div>
	</div>
</section>

<%
	}
%>