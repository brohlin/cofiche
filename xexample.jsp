<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ page language="java" import="java.sql.*" %>
<%@ page import="org.undp.database.*" %>
<%@ page import="org.undp.utils.*" %>
<%@ page import="org.undp.utils.arrays.*" %>
<%@ page import="org.undp.log.*" %>

<%
	int size1 = 0;
	int size2 = 0;
	int size3 = 0;
	int size4 = 0;
	int size6 = 0;
	
	DynStringArray params = new DynStringArray();
	params.add("");
	DbResults db_sex = Database.callProcResults("p_get_example_pie_chart_by_sex", params);
	DbResults db_education = Database.callProcResults("p_get_example_pie_chart_by_education", params);
	DbResults db_age = Database.callProcResults("p_get_example_pie_chart_by_age", params);
	DbResults db_issue = Database.callProcResults("p_get_example_pie_chart_by_issue", params);
	DbResults db_example = Database.callProcResults("p_get_example", params);
	
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
	while(size6<db_example.getRowCount()) {	
			if (size6==0) {
%>				
				var myLatLng = {lat: <%= db_example.getRow(size6).get(5) %>, lng: <%= db_example.getRow(size6).get(4) %>};
				var map = new google.maps.Map(document.getElementById('map'), {zoom: 12,center: myLatLng});
<%
			}
%>
		  myLatLng = {lat: <%= db_example.getRow(size6).get(5) %>, lng: <%= db_example.getRow(size6).get(4) %>};
    	  var marker = new google.maps.Marker({position: myLatLng, map: map, title: '<%= db_example.getRow(size6).get(0) %>'});
<%
    	  size6++;
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
					<h1 class="text-white">Example Pie Chart</h1>
				</div>
			</div>
		</header>	
				
		<div class="container">
					
			<div id="list-countries" class="col-md-8 col-centered separador-bottom ">

				<p>
					<table  class="table table-hover separador-top separador-bottom" >
						<tbody>
							<tr>
								<td><div id="example_pie_chart_by_sex"></div>
								</td>
							</tr>
						</tbody>
					</table>
				</p>				
				<p>
					<table  class="table table-hover separador-top separador-bottom" >
						<tbody>
							<tr>
								<td><div id="example_pie_chart_by_age"></div>
								</td>
							</tr>
						</tbody>
					</table>
				</p>
				<p>
					<table  class="table table-hover separador-top separador-bottom" >
						<tbody>
							<tr>
								<td><div id="example_pie_chart_by_education"></div>
								</td>
							</tr>
						</tbody>
					</table>
				</p>
				<p>
					<table  class="table table-hover separador-top separador-bottom" >
						<tbody>
							<tr>
								<td><div id="example_pie_chart_by_issue"></div>
								</td>
							</tr>
						</tbody>
					</table>
				</p>
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
				
				<h3 class="text-center separador-top "> Example Submissions</h3>
				
				<table class="table table-hover separador-top separador-bottom" >
					<tr>
						<th nowrap>Age</th>
						<th nowrap>Sex</th>
						<th nowrap>Education</th>
						<th nowrap>Issue</th>
						<th nowrap>GPS longitude</th>
						<th nowrap>GPS latitude</th>
						<th nowrap>Creation date</th>
						<th nowrap>Submitted by</th>
					</tr>	
					<%	
						db_example.moveFirst();
						int size5=0;
						String bgColor = "bc-grayb";
						while(size5<db_example.getRowCount())
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
							<td><%= db_example.getRow(size5).get(0) %></td>
							<td><%= db_example.getRow(size5).get(1) %></td>			
							<td><%= db_example.getRow(size5).get(2) %></td>
							<td><%= db_example.getRow(size5).get(3) %></td>
							<td><%= db_example.getRow(size5).get(4) %></td>
							<td><%= db_example.getRow(size5).get(5) %></td>			
							<td><%= db_example.getRow(size5).get(6) %></td>
							<td><%= db_example.getRow(size5).get(7) %></td>							
					</tr>
					<%
						size5++;
					}
					%>
				</table>
			</div>

	
		</div>		
		
	</section>

	<footer>
		<hr>
	</footer>

	<script src="/cofiche/assets/js/jquery-2.1.0.min.js"></script>
	<script defer src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
	<script defer src="/Highcharts-4.0.4/js/highcharts.js"></script>
	<script defer src="/Highcharts-4.0.4/js/highcharts-more.js"></script>
	<script defer src="/Highcharts-4.0.4/js/modules/exporting.js"></script>
					
<script type="text/javascript">


$(function () {
    $('#example_pie_chart_by_sex').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
		title: {
            text: 'Responses by Sex'
        },
        subtitle: {
            text: ''
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            // pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
            pointFormat: '<tr><td style="color:{series.color};padding:0"></td>' +
                '<td style="padding:0"><b>{point.y}</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true        	
        	
            // pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.2f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                }
            }
        },
        series: [{
            name: "Sex",
            colorByPoint: true,
            data: [
<%			
	while(size1<db_sex.getRowCount()) {
%>	           
				{
				name: "<%= db_sex.getRow(size1).get(0) %>",
				y: <%= db_sex.getRow(size1).get(1) %>
				},
<%
		
		size1++;
	}
%>
			]
        }]
    });
});

$(function () {
    $('#example_pie_chart_by_age').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
		title: {
            text: 'Responses by Age'
        },
        subtitle: {
            text: ''
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            // pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
            pointFormat: '<tr><td style="color:{series.color};padding:0"></td>' +
                '<td style="padding:0"><b>{point.y}</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true        	
        	
            // pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.2f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                }
            }
        },
        series: [{
            name: "Age",
            colorByPoint: true,
            data: [
<%			
	while(size2<db_age.getRowCount()) {
%>	           
				{
				name: "<%= db_age.getRow(size2).get(0) %>",
				y: <%= db_age.getRow(size2).get(1) %>
				},
<%
		
		size2++;
	}
%>
			]
        }]
    });
});


$(function () {
    $('#example_pie_chart_by_education').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
		title: {
            text: 'Responses by Education'
        },
        subtitle: {
            text: ''
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            // pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
            pointFormat: '<tr><td style="color:{series.color};padding:0"></td>' +
                '<td style="padding:0"><b>{point.y}</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true        	
        	
            // pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.2f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                }
            }
        },
        series: [{
            name: "Education",
            colorByPoint: true,
            data: [
<%			
	while(size3<db_education.getRowCount()) {
%>	           
				{
				name: "<%= db_education.getRow(size3).get(0) %>",
				y: <%= db_education.getRow(size3).get(1) %>
				},
<%
		
		size3++;
	}
%>
			]
        }]
    });
});

$(function () {
    $('#example_pie_chart_by_issue').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
		title: {
            text: 'Responses by Issue'
        },
        subtitle: {
            text: ''
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            // pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
            pointFormat: '<tr><td style="color:{series.color};padding:0"></td>' +
                '<td style="padding:0"><b>{point.y}</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true        	
        	
            // pointFormat: '{series.name}: <b>{point.percentage:.2f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.2f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                }
            }
        },
        series: [{
            name: "Issue",
            colorByPoint: true,
            data: [
<%			
	while(size4<db_issue.getRowCount()) {
%>	           
				{
				name: "<%= db_issue.getRow(size4).get(0) %>",
				y: <%= db_issue.getRow(size4).get(1) %>
				},
<%
		
		size4++;
	}
%>
			]
        }]
    });
});


</script>

</body>
</html>