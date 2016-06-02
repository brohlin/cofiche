<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ page language="java" import="java.sql.*" %>
<%@ page import="org.undp.database.*" %>
<%@ page import="org.undp.utils.*" %>
<%@ page import="org.undp.utils.arrays.*" %>
<%@ page import="org.undp.log.*" %>

<%
	response.setCharacterEncoding("UTF-8");
%>

<%
	ServletContext context = pageContext.getServletContext();
	String un = (String) session.getAttribute("user_id");
	System.out.println(un);
	if ( un == null || un.equals("null")) {
		System.out.println("in if statement");
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=login&page=field_value_history");
		System.out.println("after redirect");
		return;
	} else {
	
		System.out.println("in else statement");
%>

<%	
	
	DynStringArray parameters = new DynStringArray();
	
	parameters.clear();
	parameters.add(request.getParameter("field_id"));	
	parameters.add(request.getParameter("country_id"));
	DbResults db = Database.callProcResults("p_get_field_value_history", parameters);
%>				
<html>
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
	
	<!-- Fonts -->
	<link href='http://fonts.googleapis.com/css?family=Lato:400,700%7cJosefin+Sans:400,700%7cRoboto+Condensed:300,400' rel='stylesheet' type='text/css' media="all">
	
	<!-- Glyphicons -->
	<link rel="stylesheet" href="/cofiche/assets/css/font-awesome.min.css" media="all">
   	
   	<!-- Favicon-->
	<link rel="shortcut icon" href="/cofiche/assets/images/favicon.ico" type="image/x-icon">
	<link rel="icon" href="/cofiche/assets/images/favicon.ico" type="image/x-icon">
</head>
<body>

<div class="scroll separador-bottom col-lg-10 col-centered">	
	<table class="table table-hover table-font-09 separador-top separador-bottom">
	<caption>History</caption>
	
	<tbody> 
		<tr>
			<th nowrap class="text-left">Field</th>
			<th nowrap class="text-left">Field Value</th>
			<th nowrap class="text-left">Source</th>				
			<th nowrap class="text-left">User</th>
			<th nowrap class="text-left">Date Modified</th>
		</tr>
		<%= db.generateHtml() %>
	</tbody>
	</table>
</div>



</body>
</html>

<%
	}
%>