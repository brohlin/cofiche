<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ page language="java" import="java.sql.*" %>
<%@ page import="org.undp.database.*" %>
<%@ page import="org.undp.utils.*" %>
<%@ page import="org.undp.utils.arrays.*" %>
<%@ page import="org.undp.log.*" %>

<%

	int size = 0;
	
	DynStringArray params = new DynStringArray();
	params.add("");
	DbResults db_iupdate = Database.callProcResults("p_get_iupdate", params);

%>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<title>iUpdate</title>
	<meta name="description" content="iUpdate">
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
	
    <style>
      #map {
        width: 750px;
        height: 500px;
      }
    </style>	

</head>
<body>
    <script>
      function initMap() {
  
<%
	while(size<db_iupdate.getRowCount()) {	
			if (size==0) {
%>				
				var myLatLng = {lat: <%= db_iupdate.getRow(size).get(6) %>, lng: <%= db_iupdate.getRow(size).get(5) %>};
				var map = new google.maps.Map(document.getElementById('map'), {zoom: 12,center: myLatLng});
<%
			}
%>
		  myLatLng = {lat: <%= db_iupdate.getRow(size).get(6) %>, lng: <%= db_iupdate.getRow(size).get(5) %>};
    	  var marker = new google.maps.Marker({position: myLatLng, map: map, title: '<%= db_iupdate.getRow(size).get(0) %>'});
<%
    	  size++;
	}
%>
      }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?callback=initMap"
        async defer></script>
    
    
	<section>
		<header>
			<div class="bc-gray-2d text-white padding-small borde-inferior">
				<div class="container">
					<h3 class="text-white"></h3>
					<h1 class="text-white">iUpdate example</h1>
				</div>
			</div>
		</header>	
				
		<div class="container">					
			<div id="list-countries" class="col-md-8 col-centered separador-bottom ">
				<p>
					<table  class="table table-hover separador-top separador-bottom" >
						<tbody>
							<tr>
								<td><div id="map"></div>
								</td>
							</tr>
						</tbody>
					</table>
				</p>								    				
			</div>	
		</div>
		
		<div class="container">
					
			<div id="list-countries" class="col-md-8 col-centered separador-bottom ">
				
				<h3 class="text-center separador-top "> iUpdate Submissions</h3>
				
				<table class="table table-hover separador-top separador-bottom" >
					<tr>
						<th nowrap>Title</th>
						<th nowrap>Event Date</th>
						<th nowrap>Description</th>
						<th nowrap>Submitted by</th>
						<th nowrap>Country</th>
						<!-- th nowrap>GPS longitude</th>
						<th nowrap>GPS latitude</th -->
						<th nowrap>Creation Date</th>
						<!-- th nowrap>Created by</th -->
						<th nowrap>Photo</th>
					</tr>	
					
					<%	
						db_iupdate.moveFirst();
						size=0;
						String bgColor = "bc-grayb";
						while(size<db_iupdate.getRowCount())
						{
							if (bgColor.equals("bc-grayb")) {
						%>
							<tr class="bc-grayb">
						<%
								bgColor = "";
						}  else {
						%>
					<tr>
						<%
								bgColor = "bc-grayb";
						}
						%>
							<td><%= db_iupdate.getRow(size).get(0) %></td>
							<td nowrap><%= db_iupdate.getRow(size).get(1) %></td>			
							<td><%= db_iupdate.getRow(size).get(2) %></td>
							<td><%= db_iupdate.getRow(size).get(3) %></td>
							<td><%= db_iupdate.getRow(size).get(4) %></td>
							<td><%= db_iupdate.getRow(size).get(7) %></td>
							<td><a href="<%= db_iupdate.getRow(size).get(9) %>" target="_blank" ><img src="<%= db_iupdate.getRow(size).get(9) %>&previewImage=true" /></a></td>								
					</tr>
					<%
						size++;
					}
					%>
				</table>
			</div>

	
		</div>		
		
	</section>

	<footer>
		<hr>
	</footer>

</body>
</html>