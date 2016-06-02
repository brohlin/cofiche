<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ page language="java" import="java.sql.*" %>
<%@ page import="org.undp.database.*" %>
<%@ page import="org.undp.utils.*" %>
<%@ page import="org.undp.utils.arrays.*" %>
<%@ page import="org.undp.log.*" %>

<!-- %
	String un = (String) session.getAttribute("user_id");
	System.out.println(un);
	if ( un == null || un.equals("null")) {
		System.out.println("in if statement");
		response.sendRedirect("/cofiche/main.jsp?target=login&page=at-a-glance");
		System.out.println("after redirect");
		return;
	} else {
	
		System.out.println("in else statement");
% -->

<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	String p_country_id = request.getParameter("country_id");
	String p_pnud_logo = request.getParameter("pnud_logo");
	
	int access_id = 4;
	int size = 0;
	
	if (p_pnud_logo == null || p_pnud_logo.equals("")) {
		p_pnud_logo = "yes";
	}
	
%>



<%	
	
	DynStringArray parameters = new DynStringArray();
	parameters.add(p_country_id);
	DbResults db = Database.callProcResults("p_get_country", parameters);

	/*
	c.id,
    c.region_id,
    c.code_2char,
    c.name,
    c.affiliation,
    c.completed,
    c.last_mod_tmstmp,
    c.code_3char
    */
    
	DbResults db_country = Database.callProcResults("p_get_country_all_cols", parameters);
	
	String _url_to_flag = "/cofiche/assets/images/flags-normal/" + db_country.getRow(0).get(2) + ".png";
	String _code_3char = db_country.getRow(0).get(7);	
	String _prev = db_country.getRow(0).get(8); 
	String _next = db_country.getRow(0).get(9);
	
	parameters.clear();
	parameters.add(p_country_id);
	DbResults db_at_a_glance = Database.callProcResults("p_get_at_a_glance", parameters);

%>		

		
<!DOCTYPE html>
<html lang="en">

	<head>
		<meta charset="utf-8">
		<title>Country Fiche</title>
		<meta name="description" content="Country Fiche">
		<meta name="author" content="UNDP">
		<!-- Mobile Specific Meta -->
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		
		<!-- Latest Bootstrap compiled and minified CSS -->
		<link rel="stylesheet" href="/cofiche/assets/css/bootstrap.min.css" media="all">
	
	
		<!-- Custom CSS -->
		<link rel="stylesheet" href="/cofiche/assets/css/custom.css" media="all">
		<link rel="stylesheet" href="/cofiche/assets/css/UserControl.css" media="all">
		
		<!-- Fonts -->
		<link href='http://fonts.googleapis.com/css?family=Lato:400,700%7cJosefin+Sans:400,700%7cRoboto+Condensed:300,400' rel='stylesheet' type='text/css' media="all">
		
		<!-- Glyphicons -->
		<link rel="stylesheet" href="/cofiche/assets/css/font-awesome.min.css" media="all">
	   	
	   	<!-- Favicon-->
		<link rel="shortcut icon" href="/cofiche/assets/images/favicon.ico" type="image/x-icon">
		<link rel="icon" href="/cofiche/assets/images/favicon.ico" type="image/x-icon">

		<style>
			.pbreak {
				page-break-before: always;
			}
		</style>		
		
	</head>
	<body>
	
	<jsp:include page="undp_js.jsp">
		<jsp:param name="country_id" value="<%= p_country_id %>"/>
	</jsp:include>

		
		<section id="contenido-resultados">

				<div class="container">
					
					<div class="row">
<%
	if (p_pnud_logo.equals("yes")) {
%>

						<div class="logo-pnud64-3 logo-pnud-home">Logo Pnud</div>
<%
	}
%>					

						<div class=" logo-cofiche-home2"><img alt="Country Flag" src="<%= _url_to_flag %>" height="100"></div> 

						<div>
							<div class="col-centered text-center" ><h1 class="text-center text-black"><%= db.generateHtml() %></h1></div>
						</div>
					</div>
				</div>
			
				<div class="container resultados">
				
					<div class="col-xs-12 cuadrado separador-top separador-bottom pbreak">
						<fieldset>
						
							<legend><h1>At-a-Glance</h1></legend>
							
								<%= db_at_a_glance.generateHtml() %>
							
						</fieldset>
					</div>
					

					        
				</div>					


		</section>

	</body>
</html>

<!-- %
	}
% -->