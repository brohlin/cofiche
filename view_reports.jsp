<%
	String un = (String) session.getAttribute("user_id");
	System.out.println(un);
	if ( un == null || un.equals("null")) {
		System.out.println("in if statement");
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=login&page=view_reports");
		System.out.println("after redirect");
		return;
	} else {
	
		System.out.println("in else statement");
%>

<%	
	
	DynStringArray parameters = new DynStringArray();
	parameters.add(p_country_id);
	
	DbResults db = Database.callProcResults("p_get_country", parameters);
	
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
	
	parameters.add( Integer.toString(access_id));	
	DbResults db_published_reports = Database.callProcResults("p_get_published_reports", parameters);	

%>

<section>

	<header>
		<div class="bc-gray-2d text-white padding-small borde-inferior">
			<div class="container">
				<h3 class="text-white">Published Reports</h3>
				<h1 class="text-white"><%= db.generateHtml() %></h1>
			</div>
		</div>
	</header>
				
	<div class="container">
			<div id="published-reports" class="col-md-8 col-centered separador-bottom ">
				
				<h3 class="text-center separador-top "> List of published reports</h3>
				
				<table class="table table-hover separador-top separador-bottom" >
					<tbody>	
						<%= db_published_reports.generateHtml() %>
					</tbody>
				</table>		
			</div>
	</div>
</section>

<%
	}
%>
