<%
	String un = (String) session.getAttribute("user_id");
	System.out.println(un);
	if ( un == null || un.equals("null")) {
		System.out.println("in if statement");
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=login&page=user_account");
		System.out.println("after redirect");
		return;
	} else {
	
		System.out.println("in else statement");
%>

<%	
	String p_user_id = request.getParameter("user_id");
	
	if (p_user_id == null || p_user_id.equals("") || p_user_id.equals("null")) {
		p_user_id = session.getAttribute("user_id").toString();
		System.out.println("no user_id param");
	} else if (session.getAttribute("user_role_nm") != null && session.getAttribute("user_role_nm").equals("ADMIN")) {
		System.out.println("ADMIN and user_id param");
	} else if (session.getAttribute("user_role_nm") != null && !session.getAttribute("user_role_nm").equals("ADMIN")) {
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=error");
		System.out.println("other user role and user_id param");
	}
	
	DbResults db_p_get_user_status_options = null;
	DbResults db_p_get_role_options = null;
	// DbResults db_p_get_organization_options = null;
		
	if (p_user_id != null) {
	
		DynStringArray parameters2 = new DynStringArray();
		parameters2.add(p_user_id);
		
		DbResults db = Database.callProcResults("p_get_user2", parameters2);
		db_p_get_user_status_options = Database.callProcResults("p_get_existing_user_status_options", parameters2);
		db_p_get_role_options = Database.callProcResults("p_get_existing_role_options", parameters2);
		
		int size=0;
		
		while(size<db.getRowCount())
		{
			session.setAttribute("user_id",db.getRow(size).get(0));
			session.setAttribute("user_user_status_id",db.getRow(size).get(1));
			session.setAttribute("user_user_status_nm",db.getRow(size).get(2));
			session.setAttribute("user_role_id",db.getRow(size).get(3));
			session.setAttribute("user_role_nm",db.getRow(size).get(4));
			session.setAttribute("user_email",db.getRow(size).get(5));
			session.setAttribute("user_pwd",db.getRow(size).get(6));
			session.setAttribute("user_first_nm",db.getRow(size).get(7));
			session.setAttribute("user_last_nm",db.getRow(size).get(8));
			session.setAttribute("user_position_title",db.getRow(size).get(9));
			session.setAttribute("user_tel_nbr",db.getRow(size).get(10));
			session.setAttribute("user_skype_handle",db.getRow(size).get(11));
			
			size++;
		}	
	}
%>

	<section role="dialog" class="fondo-gris">
		<header>
			<div class="bc-gray-2d text-white padding-small borde-inferior">
				<div class="container">
					<h3 class="text-white">&nbsp;</h3>
					<h1 class="text-white">Edit User Account</h1>
				</div>
			</div>
		</header>
<div class="container">
	<div class="col-xs-12 col-md-8 cuadrado separador-top separador-bottom col-centered">
	<fieldset>
		<form class="form-horizontal" role="form" name="user_account"  action="validate_user_account.jsp" method="post">
			<input type="hidden" value="<% if (session.getAttribute("user_id") != null) { %><%= session.getAttribute("user_id").toString() %><% } %>" name="user_id">
			<input type="hidden" value="<% if (session.getAttribute("user_skype_handle") != null) { %><%= session.getAttribute("user_skype_handle").toString() %><% } %>" name="skype_handle">			
			<input type="hidden" value="<% if (session.getAttribute("user_user_status_id") != null) { %><%= session.getAttribute("user_user_status_id").toString() %><% } %>" name="user_status">
			<input type="hidden" value="<% if (session.getAttribute("user_role_id") != null) { %><%= session.getAttribute("user_role_id").toString() %><% } %>" name="role">

			<div class="form-group">
				<label for="inputFirst_nm">First Name</label>
				<div class="col-sm-12 input-group">
					<input type="text" class="form-control" id="inputFirst_nm" placeholder="First Name" name="first_nm"  value="<% if (session.getAttribute("user_first_nm") != null) { %><%= session.getAttribute("user_first_nm").toString() %><% } %>">
				</div>
			</div>
			
			<div class="form-group">
				<label for="inputLast_nm">Last Name</label>
				<div class="col-sm-12 input-group">
					<input type="text" class="form-control" id="inputLast_nm" placeholder="Last Name" name="last_nm"  value="<% if (session.getAttribute("user_last_nm") != null) { %><%= session.getAttribute("user_last_nm").toString() %><% } %>">
				</div>
			</div>

			<div class="form-group">
				<label for="inputEmail">Email</label>
				<div class="col-sm-12 input-group">
					<input type="email" class="form-control" id="inputEmail" placeholder="Email" name="email"  value="<% if (session.getAttribute("user_email") != null) { %><%= session.getAttribute("user_email").toString() %><% } %>">
				</div>
			</div>


			<div class="form-group">
				<label for="user_status">Estatus</label>
    			<select name="user_status"  class="col-sm-12 form-control" <% if(!session.getAttribute("user_role_nm").equals("ADMIN")) { %> disabled <% } %>> 
					<%= db_p_get_user_status_options.generateSelectOptions() %>
				</select>
			</div>

			<div class="form-group">
				<label for="role">Rol</label>
    			<select name="role"  class="col-sm-12 form-control" <% if(!session.getAttribute("user_role_nm").equals("ADMIN")) { %> disabled <% } %>>
					<%= db_p_get_role_options.generateSelectOptions() %>
				</select>
			</div>		


			<div class="form-group">
				<label for="inputPosition">Position/Title</label>
				<div class="input-group col-sm-12">
					<input type="text" class=" form-control" id="inputPosition" placeholder="Position/Title" name="position_title"  value="<% if (session.getAttribute("user_position_title") != null) { %><%= session.getAttribute("user_position_title").toString() %><% } %>">
				</div>
			</div>


			<div class="form-group">
				<label for="inputTel_nbr">Telephone</label>
				<div class=" input-group col-sm-12">
					<input type="text" class="form-control" id="inputTel_nbr" placeholder="Telephone" name="tel_nbr"  value="<% if (session.getAttribute("user_tel_nbr") != null) { %><%= session.getAttribute("user_tel_nbr").toString() %><% } %>">
				</div>
			</div>

			<div class="form-group">
				<label for="inputPassword">Password</label>
				<div class=" input-group col-sm-12">
						<input type="password" class=" form-control" id="inputPassword" placeholder="Password" name="pwd" value="<% if (session.getAttribute("user_pwd") != null) { %><%= session.getAttribute("user_pwd").toString() %><% } %>">
				</div>
			</div>

			<div class="form-group">
				<label for="inputConfirmPassword">Confirm Password</label>
				<div class="input-group col-sm-12">
						<input type="password" class="col-sm-12 form-control" id="inputConfirmPassword" placeholder="Confirm Password" name="confirm_pwd" value="<% if (session.getAttribute("user_pwd") != null) { %><%= session.getAttribute("user_pwd").toString() %><% } %>">
				</div>
			</div>

			<button type="submit" class="btn btn-info btn-block separador-top">SAVE</button>
		</form>
	</fieldset>
</div>
</div>
</section>


<%
	}
%>