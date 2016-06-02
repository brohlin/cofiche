<%
	String un = (String) session.getAttribute("user_id");
	System.out.println(un);
	if ( un == null || un.equals("null")) {
		System.out.println("in if statement");
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=login&page=manage_access");
		System.out.println("after redirect");
		return;
	} else {
	
		System.out.println("in else statement");
%>

<%	
	
	DynStringArray parameters = new DynStringArray();
	parameters.add(p_country_id);
	DbResults db = Database.callProcResults("p_get_country", parameters);
	DbResults db_access_permissions_by_role = Database.callProcResults("p_get_access_permissions_by_role", parameters);
	DbResults db_access_permissions_by_user = Database.callProcResults("p_get_access_permissions_by_user", parameters);	

%>

<section>

	<header>
		<div class="bc-gray-2d text-white padding-small borde-inferior">
			<div class="container">
				<h3 class="text-white">Manage Access</h3>
				<h1 class="text-white"><%= db.generateHtml() %></h1>
			</div>
		</div>
	</header>
				
	<div class="container">
			<div id="access_permissions_by_role" class="col-md-8 col-centered separador-bottom bc-gray">
				
				<h3 class="text-center separador-top "> Access permissions by role</h3>
				
				<form class="form-plantilla" role="form" action="validate_manage_access_role.jsp" method="post">
					<input type="hidden" id="country_id" name="country_id" value="<%= p_country_id %>">

					<table class="table table-hover separador-top separador-bottom" >
						<tbody>	
							<tr>
								<th>ID</th>
								<th>Role</th>
								<th>None</th>
								<th>Read</th>
								<th>Write</th>
								<th>Full</th>
								<th>Date updated</th>	
								<!-- th>Updated by</th -->	
												
							</tr>	
							<%= db_access_permissions_by_role.generateHtml() %>
						</tbody>
					</table>	
					
					<button type="submit" class="btn btn-info btn-block separador-top">SAVE</button>
				</form>
			</div>
			
			<div id="access_permissions_by_user" class="col-md-8 col-centered separador-bottom bc-gray ">
				
				<h3 class="text-center separador-top "> Access permissions by user</h3>
				
				<form class="form-plantilla" role="form" action="validate_manage_access_user.jsp" method="post">
					<input type="hidden" id="country_id" name="country_id" value="<%= p_country_id %>">

					<table class="table table-hover separador-top separador-bottom" >
						<tbody>	
							<tr>
								<th>ID</th>
								<th>User</th>
								<th>Use Group<br>Permissions</th>
								<th>None</th>
								<th>Read</th>
								<th>Write</th>
								<th>Full</th>
								<th>Date updated</th>	
								<!-- th>Updated by</th -->	
												
							</tr>	
							<%= db_access_permissions_by_user.generateHtml() %>
						</tbody>
					</table>	
					
					<button type="submit" class="btn btn-info btn-block separador-top">SAVE</button>
				</form>
			</div>			
			
	</div>
</section>

<%
	}
%>