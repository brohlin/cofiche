<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 


<%@ page language="java" import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.undp.database.*" %>
<%@ page import="org.undp.log.*" %>
<%@ page import="org.undp.utils.*" %>
<%@ page import="org.undp.utils.arrays.*" %>
<%@ page import="org.json.*" %>

<%
	String un = (String) session.getAttribute("user_id");
	System.out.println(un);
	if ( un == null || un.equals("null")) {
		System.out.println("in if statement");
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=login&page=news");
		System.out.println("after redirect");
		return;
	} else {
	
		System.out.println("in else statement");
%>


	<section>
		<header>
			<div class="bc-gray-2d text-white padding-small borde-inferior">
				<div class="container">
					<h3 class="text-white">&nbsp;</h3>
					<h1 class="text-white">NEWS</h1>
				</div>
			</div>
		</header>

<%

	if ((mCountry_id.equals("0") || mCountry_id == null)  || mCountry_id.equals("") ){
%>

	
				
		<div class="bc-gray padding-medium">
			<div class="container">

				<div id="news" class="col-md-6 padding-small">
					
					<form class="form-horizontal" role="form"  name="search_news" action="./main.jsp?target=news" method="post">
						<fieldset>
						<!-- Form Name -->
						<legend>
							<h3 >Search for Country</h3>
						</legend>

						<!-- Text input-->
						<div class="form-group">
						  <label class="col-md-4 control-label" for="id">Search by ID</label>  
						  <div class="col-md-7">
						  <input id="country_id" name="country_id" type="text" placeholder="ID" class="form-control input-md">
						  </div>
						</div>

						<!-- Text input-->
						<div class="form-group">
						  <label class="col-md-4 control-label" for="name">Search by Name</label>  
						  <div class="col-md-7">
						  <input id="name" name="name" type="text" placeholder="Name" class="form-control input-md">
						
						  </div>
						</div>

						<!-- Button -->
						<div class="form-group">
						  <label class="col-md-4 control-label" for="singlebutton"></label>
						  <div class="col-md-7">
						  	<button id="singlebutton" name="singlebutton" class="btn btn-primary btn-block">Find</button>
						  </div>
						</div>

						</fieldset>
						</form>

				</div>

			</div>
		</div>	
		
		<div class="container">
					
			<div id="list-countries" class="col-md-8 col-centered separador-bottom ">
				
				<h3 class="text-center separador-top "> List of countries</h3>
				
				<table class="table table-hover separador-top separador-bottom" >
					<tr>
						<th nowrap>ID</th>
						<th nowrap>Country</th>
						<th nowrap>Country Advisor</th>
						<th nowrap>Programme Associate</th>
						<th nowrap>Access</th>
					</tr>	
					<%	

						DynStringArray parameters = new DynStringArray();
						parameters.add(mCountry_id);
						parameters.add(mName);
						parameters.add(session.getAttribute("user_id").toString());

						DbResults db = Database.callProcResults("p_get_countries", parameters);
						
						int size=0;
						String bgColor = "bc-grayb";
						while(size<db.getRowCount())
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
							<td><%= db.getRow(size).get(0) %></td>
							<td><a href="./main.jsp?target=news&country_id=<%= db.getRow(size).get(0) %>"><%= db.getRow(size).get(1) %></a></td>			
							<td><%= db.getRow(size).get(2) %></td>
							<td><%= db.getRow(size).get(3) %></td>
							<td><%= db.getRow(size).get(5) %></td>
					</tr>
					<%
						size++;
					}
					%>
				</table>
			</div>

	
		</div>

<%
	} else if ((p_country_id != null)  && p_country_id.length()>0) {
		DynStringArray params = new DynStringArray();
		params.add(mCountry_id);
		DbResults db_country_name = Database.callProcResults("p_get_country", params);
		
		try {
			JSONArray docs = JsonReader.getNYTimesArticles(db_country_name.generateHtml().replaceAll(" ", "%20"));
			
			
			if (docs != null) {
%>
		<div class="container">

			<div id="list-countries" class="col-lg-12 col-centered separador-bottom ">
				
				<h3 class="text-center separador-top "> List of recent articles where "<%= db_country_name.generateHtml() %>" is mentioned</h3>
				
				<table class="table table-hover separador-top separador-bottom" >
			
				<tbody> 
				<tr>
					<th class="text-left" colspan="2">Headline</th>
					<th class="text-left">Lead Paragraph</th>
					<th nowrap class="text-left">Source</th>
					<th nowrap class="text-left">Published</th>				
				</tr>
<%
		    	for (int i=0;i<docs.length();i++){
				
					JSONObject docsObject = docs.getJSONObject(i);
					String thumbStandard = "";
				
					JSONObject headlineObject = docsObject.getJSONObject("headline");
				
					System.out.println(docsObject.get("web_url"));
					System.out.println(docsObject.get("snippet"));
					// System.out.println(docsObject.get("lead_paragraph"));
					System.out.println(docsObject.get("source"));
					System.out.println(docsObject.get("pub_date"));
					System.out.println(headlineObject.get("main"));

	    			JSONArray multimedia = new JSONArray(docsObject.get("multimedia").toString());
	        		
	    			if (multimedia != null) {
	                	for (int j=0;j<multimedia.length();j++) {
	                		JSONObject multimediaObject = multimedia.getJSONObject(j);   
	                	
	                		if (multimediaObject.get("url").toString().contains("thumbStandard")) {
	                			System.out.println("http://www.nytimes.com/" + multimediaObject.get("url"));
	                			thumbStandard = "http://www.nytimes.com/" + multimediaObject.get("url");
	                		}
	                	
	                	}
	        		}				
				
		    		System.out.println("");
%>		    	



				<tr>
					
					
<% 
					if( !thumbStandard.equals("") ) { 

%>
						<td><img src="<%= thumbStandard %>" align="left"></td>
						<td> 
<% 
					} else {
%>
						<td colspan="2">
<%
					}
%>							<a href="<%= docsObject.get("web_url") %>" target="_blank"><%= headlineObject.get("main") %></a></td>
					<td><%= docsObject.get("snippet") %></td>
					<td nowrap><%= docsObject.get("source") %></td>
					<td nowrap><%= docsObject.get("pub_date") %></td>
				</tr>

<%
		    	}
%>
				</tbody>
				</table>
			</div>
		</div>

<%
			}
		} catch (Exception ex) {
			response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=error");
		}
%>
	</section>
<%
	}
%>


<%
	}
%>