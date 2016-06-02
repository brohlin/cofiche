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

<%
	String un = (String) session.getAttribute("user_id");
	System.out.println(un);
	if ( un == null || un.equals("null")) {
		System.out.println("in if statement");
		response.sendRedirect("/cofiche/main.jsp?target=login&page=country_report&country_id=" + p_country_id);
		System.out.println("after redirect");
		return;
	} else {
	
		System.out.println("in else statement");
%>

<%	
	
	DynStringArray parameters = new DynStringArray();
	parameters.add(p_country_id);
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
	
	if (db_published_reports.hasRows() || access_id > 5) {
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
	.pbreak {
		page-break-before: always;
	}
</style>		

	<jsp:include page="undp_js.jsp">
		<jsp:param name="country_id" value="<%= p_country_id %>"/>
	</jsp:include>
	
	<jsp:include page="all_inclusive_legacy_feed.jsp">
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

		

	<script src="/cofiche/assets/js/jquery-2.1.0.min.js"></script>
	<script defer src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
	<script defer src="/Highcharts-4.0.4/js/highcharts.js"></script>
	<script defer src="/Highcharts-4.0.4/js/highcharts-more.js"></script>
	<script defer src="/Highcharts-4.0.4/js/modules/exporting.js"></script>
	
	<!-- 	INICIALIZAR EL TOOLTIP Y EL POPOVER -->
	<script type="text/javascript">
	$( document ).ready(function() {
		$('[data-toggle="tooltip"]').tooltip();
  		$('[data-toggle="popover"]').popover({ html:true });
  		
  		$('body').on('click', function (e) {
  		    $('[data-toggle="popover"]').each(function () {
  		    	
  		        //the 'is' for buttons that trigger popups
  		        //the 'has' for icons within a button that triggers a popup
  		        if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
  		            $(this).popover('hide');
  		        }
  		        
  		    });
  		});  		
	});
	
	</script>
	
	
<script type="text/javascript">

$(function () {
    $('#irrf_development_outcomes').highcharts({
        chart: {
            type: 'column'
        },
		title: {
            text: '2015 Summary'
        },        
        subtitle: {
        	text: 'Source: <a href="https://intranet.undp.org/apps/snapshot/SitePages/ExecSnapshotHomePage.aspx?year=2015&hq_co=CO&bureau=RBLAC&unit=CUB">UNDP Intranet Executive Snapshot</a>'
        },
        xAxis: {
            categories: [
				'Outcome 1',
				'Outcome 2',
				'Outcome 3',
				'Outcome 4',
				'Outcome 5',
				'Outcome 6',
				'Outcome 7',
				'Org Results Area 1',
				'Not linked'
            ],
            crosshair: true
        },
        yAxis: {
            min: 0,
            title: {
                text: '$\'s in millions'
            }
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>${point.y}</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series: [{
            name: 'Resources',
            data: [13917927,2741791,8405283,0,290023,862115,1601679,0,1315154]

        }, {
            name: 'Budget',
            data: [8473594,2952107,8403991,724223,282850,810171,481466,506224,35683]

        }, {
            name: 'Pipeline',
            data: [933708,1969401,0,500000,12500,0,145120,0,1050]

        }, {
            name: 'Utilization',
            data: [5175175,2092911,5587318,0,92646,544829,300971,408632,10235]

        }]
    });
});


$(function () {
    $('#financials_by_funding_sources_program_resources').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
		title: {
            text: '2015 by Programme and Resources'
        },
        subtitle: {
            text: 'Source: <a href="https://intranet.undp.org/apps/snapshot/SitePages/ExecSnapshotHomePage.aspx?year=2015&hq_co=CO&bureau=RBLAC&unit=CUB">UNDP Intranet Executive Snapshot</a>'
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            // pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
            pointFormat: '<tr><td style="color:{series.color};padding:0"></td>' +
                '<td style="padding:0"><b>${point.y}</b></td></tr>',
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
            name: "Funding Source",
            colorByPoint: true,
            data: [{
				name: "Regular Resources",
				y: 423790
				},
				{
				name: "Local Cost Sharing",
				y: 181680
				},
				{
				name: "Third Party Cost Sharing",
				y: 5714871
				},
				{
				name: "EC Cost Sharing",
				y: 8596586
				},
				{
				name: "EC Trust Funds",
				y: 0
				},
				{
				name: "Thematic Trust Funds",
				y: 319578
				},
				{
				name: "Other Trust Funds",
				y: 180659
				},
				{
				name: "Vertical Trust Funds",
				y: 13171871
			}]
        }]
    });
});

$(function () {
    $('#financials_by_funding_sources_program_budget').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
		title: {
            text: '2015 by Programme and Budget'
        },
        subtitle: {
            text: 'Source: <a href="https://intranet.undp.org/apps/snapshot/SitePages/ExecSnapshotHomePage.aspx?year=2015&hq_co=CO&bureau=RBLAC&unit=CUB">UNDP Intranet Executive Snapshot</a>'
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            // pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
            pointFormat: '<tr><td style="color:{series.color};padding:0"></td>' +
                '<td style="padding:0"><b>${point.y}</b></td></tr>',
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
            name: "Funding Source",
            colorByPoint: true,
            data: [{
				name: "Regular Resources",
				y: 726655
				},
				{
				name: "Local Cost Sharing",
				y: 141598
				},
				{
				name: "Third Party Cost Sharing",
				y: 4449917
				},
				{
				name: "EC Cost Sharing",
				y: 2548680
				},
				{
				name: "EC Trust Funds",
				y: 0
				},
				{
				name: "Thematic Trust Funds",
				y: 278318
				},
				{
				name: "Other Trust Funds",
				y: 134361
				},
				{
				name: "Vertical Trust Funds",
				y: 13680684
			}]
        }]
    });
});

$(function () {

    $('#irrf_development_outcomes_spider').highcharts({

        chart: {
            polar: true,
            type: 'line'
        },

        title: {
            text: 'Resources, Budget and Pipeline, and Utilization',
            x: -80
        },

        pane: {
            size: '80%'
        },

        xAxis: {
            categories: ['Outcome 1', 'Outcome 2', 'Outcome 3', 'Outcome 4','Outcome 5', 'Outcome 6', 'Outcome 7'],
            tickmarkPlacement: 'on',
            lineWidth: 0
        },

        yAxis: {
            gridLineInterpolation: 'polygon',
            lineWidth: 0,
            min: 0
        },

        tooltip: {
            shared: true,
            pointFormat: '<span style="color:{series.color}">{series.name}: <b>${point.y:,.0f}</b><br/>'
        },

        legend: {
            align: 'right',
            verticalAlign: 'top',
            y: 70,
            layout: 'vertical'
        },

        series: [{
            name: 'Budget and Pipeline',
            data: [9184879, 5168790, 8403991, 1230321, 324936, 548106,626587],
            pointPlacement: 'on'
        }, {
            name: 'Utilization',
            data: [5818677, 2681929, 6065544, 6130, 266677, 531274, 300971],
            pointPlacement: 'on'
        }, {
            name: 'Resources',
            data: [14986594, 2611018, 8405283, 606227, 644006, 862115, 1001679],
            pointPlacement: 'on'
        }]

    });
});
</script>


	</body>
</html>

<%
	} else {
%>
Access ID: <%= access_id %>

<section role="dialog" class="borde-superior fondo-gris">

	<header>
		<div class="bc-gray-2d text-white padding-small borde-inferior">
			<div class="container">
				<h3 class="text-white">Published Reports</h3>
				<h1 class="text-white"><%= db.generateHtml() %></h1>
			</div>
		</div>
	</header>
		
	<div class="container">
		<div class="col-xs-12 col-lg-8 cuadrado separador-top separador-bottom">
			<p>There are no published reports for this country.</p>	
		</div>
	</div>
</section>

<%
	}
%>

<%
	}
%>
