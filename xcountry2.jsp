<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 

<%
	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
	
%>

<%
	String un = (String) session.getAttribute("user_id");
	System.out.println(un);
	if ( un == null || un.equals("null")) {
		System.out.println("in if statement");
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=login&page=country");
		System.out.println("after redirect");
		return;
	} else {
	
		System.out.println("in else statement");
%>

<%	
	
	DynStringArray parameters = new DynStringArray();
	parameters.add(p_country_id);

	DbResults db = Database.callProcResults("p_get_country", parameters);
	DbResults db_reports = Database.callProcResults("p_get_reports2", parameters);
	
	
	parameters.add(p_section_id);
	DbResults db2 = Database.callProcResults("p_get_section_menu", parameters);
	
	parameters.clear();
	parameters.add(p_section_id);
	DbResults db3 = Database.callProcResults("p_get_section", parameters);
	
	parameters.add(p_country_id);
	
	
	DbResults db4 = Database.callProcResults("p_get_country_section_form", parameters);
	parameters.add("Y");
	DbResults db5 = Database.callProcResults("p_get_country_section_form_view_only", parameters);
	
	parameters.clear();
	parameters.add(p_country_id);
	parameters.add(session.getAttribute("user_id").toString());
	
	// DbResults db6 = Database.callProcResults("p_get_country_user_access_id", parameters);
	// int access_id = Integer.parseInt(db6.generateHtml());

%>				
	
	<link rel="stylesheet" href="/cofiche/assets/css/COinfo.css" media="all">

	<jsp:include page="undp_js.jsp">
		<jsp:param name="country_id" value="<%= p_country_id %>"/>
	</jsp:include>


<style>
  body.page-node .article_member_info,
  body.page-comment .article_member_info,
  #single-content-counts,
  .node-additional-fields,
  .field.article_field.user-tags_field,
  .group-post-extras.group-post-extras-secondary,
  .field.article_field.field_regions_field
  {
    margin: 0;
    padding: 0;
    display: block;
    visibility: hidden;
    height: 0;
    border: 0;
    width: 0;
    -moz-appearance: separator;
    -webkit-appearance: none;
  }
  .panel.panel-default {
    background-color: #fff;
    padding: 10px 25px;
    margin-bottom: 4px;
  }
  .panel-collapse .panel-body {
    margin-top: 10px;
    border-top: 1px solid #EAEAEA;
    padding-top: 7px;
    padding-bottom: 30px;
  }
  a.collapse-link {
    font-family: "opensans-regular", Arial, Helvetica, sans-serif;
    font-weight: 200;
    color: #232323;
    padding: 2px 0px;
  }
  .collapse-link:after {
    margin-left: 5px;
    color: #8AB8E4;
    font-size: 10px;
  }
  .schedule .item {
    background-color: rgba(255, 255, 255, 0.98);
    padding: 20px;
    text-align: center;
    min-height: 235px;
  }
  .col {
    padding: 2px;
  }
  .col .item {
    text-align: center;
    background-color: #fff;
    padding: 20px 15px;
    min-height: 180px;
  }
  .col .item .event {
    display: block;
    font-size: 18px;
    line-height: 23px;
    border-bottom: 1px solid #EAEAEA;
    padding-bottom: 10px;
  }
  .col .item .location {
    display: block;
    font-size: 17px;
    font-family: "opensans-light", Arial, Helvetica, sans-serif;
    margin: 10px 0;
  }
  .col .item .date {
    display: block;
    font-family: "opensans-bold", Arial, Helvetica, sans-serif;
  }
</style>

<%
	DbResults db_user_country_access2 = (DbResults) session.getAttribute("user_country_access");
	int access_id = 0;
	int size = 0;

	if (db_user_country_access2.getRowCount()>size) {
		while(size<db_user_country_access2.getRowCount())
		{
			System.out.println(db_user_country_access2.getRow(size).get(0));
			if ( p_country_id.equals(db_user_country_access2.getRow(size).get(0)) ) {
				access_id = Integer.parseInt( db_user_country_access2.getRow(size).get(1) );
			}
			size++;
		}
	
	} else {
		// nothing to do
	}

	System.out.println("Size: " + size);
	
	parameters.clear();
	parameters.add(p_country_id);
	parameters.add(Integer.toString(access_id));
	
	DbResults db_published_reports = Database.callProcResults("p_get_published_reports", parameters);
%>

<!-- %= db_user_country_access2.generateHtml() % -->

	<section role="dialog" class="borde-superior fondo-gris">
		<header>
			<div class="bc-gray-2d text-white padding-small borde-inferior">
				<div class="container">
					<h3 class="text-white">&nbsp;</h3>
					<h1 class="text-white"><%= db.generateHtml() %></h1>
				</div>
			</div>
		</header>
<%
	if (access_id > 5) {  
%>		
		<div class="container">
			<nav class="col-xs-12 col-lg-3 separador-top navegacion2 side-menu" role="navigation">
					
				<ul class="nav nav-stacked text-center">
					
					<!-- li class="titulo-input"><h3 --><!-- %= db.generateHtml() % --><!-- /h3></li -->
					
					<li class="titulo-input"><h3>Update Profile</h3></li>
					<%= db2.generateHtml() %>
					
					<BR>
					<li class="titulo-input"><h3>News and Reports</h3></li>
					<li><a href="/cofiche/main.jsp?target=view_reports&country_id=<%= p_country_id %>">REPORTS</a></li>		
					<li><a href="/cofiche/main.jsp?target=news&country_id=<%= p_country_id %>">NEWS</a></li>					
<%

		if (access_id == 7) {  
%>
					<BR>
					<li class="titulo-input"><h3>Country Advisors Only</h3></li>
					<li><a href="/cofiche/main.jsp?target=manage_access&country_id=<%= p_country_id %>">MANAGE ACCESS</a></li>
					<li><a href="/cofiche/country_report.jsp?country_id=<%= p_country_id %>" target="_blank">VIEW COUNTRY REPORT</a></li>
					<li><a href="/cofiche/main.jsp?target=create_country_pdf&country_id=<%= p_country_id %>">CREATE COUNTRY PDF</a></li>
					
					<li><a href="/cofiche/at-a-glance.jsp?country_id=<%= p_country_id %>"  target="_blank">VIEW AT-A-GLANCE</a></li>
					<li><a href="/cofiche/main.jsp?target=create_at_a_glance&js=yes&country_id=<%= p_country_id %>">CREATE AT-A-GLANCE</a></li>  
					
<%
		}
%>					
				</ul>

			</nav>


				

			
			<div class="col-xs-12 col-lg-8 cuadrado separador-top separador-bottom">
				<fieldset>	
<%
		if ( ( p_mode.equals("edit") && access_id > 5) ) {
%>				
					<form class="form-plantilla" role="form" action="validate_country_section.jsp" method="post" enctype="multipart/form-data">
					<!-- form class="form-plantilla" role="form" action="validate_country_section2.jsp" method="post" -->
					<!-- form class="form-plantilla" role="form" action="#" method="post" -->
						<input name="country_id" value="<%= p_country_id %>" type="hidden">
						<input name="section_id" value="<%= p_section_id %>" type="hidden">
						
						<h5><label class="view_edit"><a href="./main.jsp?target=country&country_id=<%= p_country_id %>&section_id=<%= p_section_id %>&mode=view" role="button" class="fa fa-eye"></a></label></h5>
						<%= db4.generateHtml() %>
											
						<button type="submit" class="btn btn-info btn-block separador-top">SAVE</button>
					</form>
<%
		} else if (p_mode.equals("view") && access_id > 5) {
%>
					
					<form class="form-plantilla" role="form" action="#" method="post"> 			
						<h5><label class="view_edit"><a href="./main.jsp?target=country&country_id=<%= p_country_id %>&section_id=<%= p_section_id %>&mode=edit" role="button" class="fa fa-edit"></a></label></h5>

						<%= db5.generateHtml() %>
						
						<!--  button type="submit" class="btn btn-info btn-block separador-top">&nbsp;</button -->
					</form>
<%
		}
%>


				</fieldset>						
		 	</div>
		 			 	
		</div>
<%
	} else if (access_id == 4) {
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=view_reports&country_id=" + p_country_id);			
	} else if (access_id < 4 ){
%>

				<div class="container">
						<div id="published-reports" class="col-md-8 col-centered separador-bottom ">
							
							<h3 class="text-center separador-top ">Please ask the country advisor for access to any published reports.</h3>
					
						</div>
				</div>

<%
	}
%>
	</section>

<%
	}
%>

