<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ page language="java" import="java.sql.*" %>
<%@ page import="org.undp.database.*" %>
<%@ page import="org.undp.utils.*" %>
<%@ page import="org.undp.utils.arrays.*" %>
<%@ page import="org.undp.log.*" %>




<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	String p_country_id = request.getParameter("country_id");
	String p_pnud_logo = request.getParameter("pnud_logo");
	String _check_access = request.getParameter("check_access");
	
	int access_id = 4;
	int size = 0;
	
	if (p_pnud_logo == null || p_pnud_logo.equals("")) {
		p_pnud_logo = "yes";
	}
	
	if (_check_access == null || _check_access.equals("")) {
		_check_access = "yes";
	}	
	
%>

<!--  %
	String un = (String) session.getAttribute("user_id");
	System.out.println(un);
	if ( un == null || un.equals("null")) {
		System.out.println("in if statement");
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=login&page=country_report&country_id=" + p_country_id);
		System.out.println("after redirect");
		return;
	} else {
	
		System.out.println("in else statement");
% -->

<%	
   

	DynStringArray parameters = new DynStringArray();
	parameters.add(p_country_id);

	DbResults db_country = Database.callProcResults("p_get_country_all_cols", parameters);
	String _code_3char = db_country.getRow(0).get(7);
	
	DbResults db = Database.callProcResults("p_get_country", parameters);
	// DbResults db_published_reports = Database.callProcResults("p_get_published_reports", parameters);	
	
	parameters.clear();
	parameters.add("1");
	parameters.add(p_country_id);
	parameters.add("N");
	DbResults db_section1 = Database.callProcResults("p_get_country_section_form_view_only", parameters);

	parameters.clear();
	parameters.add("2");
	parameters.add(p_country_id);
	DbResults db_flag = Database.callProcResults("p_get_field_value", parameters);
	
	
	parameters.add("N");
	DbResults db_section2 = Database.callProcResults("p_get_country_section_form_view_only", parameters);

	parameters.clear();
	parameters.add("3");
	parameters.add(p_country_id);
	parameters.add("N");
	DbResults db_section3 = Database.callProcResults("p_get_country_section_form_view_only", parameters);

	parameters.clear();
	parameters.add("4");
	parameters.add(p_country_id);
	parameters.add("N");
	DbResults db_section4 = Database.callProcResults("p_get_country_section_form_view_only", parameters);

	parameters.clear();
	parameters.add("5");
	parameters.add(p_country_id);
	parameters.add("N");
	DbResults db_section5 = Database.callProcResults("p_get_country_section_form_view_only", parameters);

	parameters.clear();
	parameters.add("6");
	parameters.add(p_country_id);
	parameters.add("N");
	DbResults db_section6 = Database.callProcResults("p_get_country_section_form_view_only", parameters);	

	if (_check_access.equals("yes") ) {
		parameters.clear();
		parameters.add(session.getAttribute("user_id").toString());
		DbResults db_user_country_access = (DbResults) session.getAttribute("user_country_access");
	
	
		if (db_user_country_access.getRowCount()>size) {
			while(size<db_user_country_access.getRowCount())
			{
				if ( p_country_id.equals(db_user_country_access.getRow(size).get(0)) ) {
					access_id = Integer.parseInt( db_user_country_access.getRow(size).get(1) );
				}
				size++;
			}
		
		} else {
			// nothing to do
		}
	}

	parameters.clear();
	parameters.add(p_country_id);
	parameters.add(Integer.toString(access_id));
	
	DbResults db_published_reports = Database.callProcResults("p_get_published_reports", parameters);	
	
	// if (access_id > 5) {
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
		
		 <link rel="stylesheet" href="/cofiche/assets/css/COinfo.css" media="all">
		
		<!-- Latest Bootstrap compiled and minified CSS -->
		<link rel="stylesheet" href="/cofiche/assets/css/bootstrap.min.css" media="all">
	
	
		<!-- Custom CSS -->
		<link rel="stylesheet" href="/cofiche/assets/css/custom.css" media="all">
		
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

	<jsp:include page="undp_js.jsp">
		<jsp:param name="country_id" value="<%= p_country_id %>"/>
	</jsp:include>
			
	</head>
	<body>		
		
		<section id="contenido-resultados" class="borde-superior ">

				<div class="container">
					
					<div class="row">
<%
	if (p_pnud_logo.equals("yes")) {
%>

						<div class="logo-pnud64-3 logo-pnud-home">Logo Pnud</div>
<%
	}
%>					

						<div class=" logo-cofiche-home2"><img alt="Country Flag" src="<%= db_flag.generateHtml() %>" height="100"></div> 

						<div>
							<div class="col-centered text-center" ><h1 class="text-center text-black"><%= db.generateHtml() %></h1></div>
						</div>
					</div>
				</div>
			
				<div class="container resultados">
				
					<div class="col-xs-12 cuadrado separador-top separador-bottom">
						<fieldset>
							<legend><h1>Country Overview</h1></legend>
							<%= db_section1.generateHtml() %>
						</fieldset>
					</div>
				
				
					<div class="col-xs-12 cuadrado separador-top separador-bottom pbreak">
						<fieldset>
						
							<legend><h1>Country Office General Information</h1></legend>
							
								<%= db_section2.generateHtml() %>
							
						</fieldset>
					</div>

					
					<div class="col-xs-12 cuadrado separador-top separador-bottom pbreak">
						<fieldset>
							<legend><h1>Programme</h1></legend>
							<%= db_section3.generateHtml() %>
						</fieldset>
					</div>

					<div class="col-xs-12 cuadrado separador-top separador-bottom pbreak">
						<fieldset>
							<legend><h1>Management</h1></legend>
							<!-- %= UndpIntranet.getSeniorManagementListing(_code_3char) % -->
							<!-- %= UndpIntranet.getFocalPointListing(_code_3char) % -->
							<!-- %= UndpIntranet.getStaffListing(_code_3char) % -->
							<%= db_section4.generateHtml() %>
						</fieldset>
					</div>
					
					<div class="col-xs-12 cuadrado separador-top separador-bottom pbreak">
						<fieldset>
							<legend><h1>Finance</h1></legend>
							<%= db_section5.generateHtml() %>
						</fieldset>
					</div>
					
					<div class="col-xs-12 cuadrado separador-top separador-bottom pbreak">
						<fieldset>
							<legend><h1>UN Coordination</h1></legend>
							<%= db_section6.generateHtml() %>
						</fieldset>
					</div>					
					
			</div>
			
<%
	if (p_pnud_logo.equals("no")) {
%>		
			<div id="published-reports" class="col-md-8 col-centered separador-bottom ">
				
				<h3 class="text-center separador-top "> List of published reports</h3>
				
				<table class="table table-hover separador-top separador-bottom" >
					<tbody>	
						<%= db_published_reports.generateHtml() %>
					</tbody>
				</table>		
			</div>
<%
	}
%>						
		</section>

	</body>
</html>

<%
// 	}
%>

<!-- %
	}
% -->
