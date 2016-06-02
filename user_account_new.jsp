<%
	String un = (String) session.getAttribute("temp_user_id");
	System.out.println(un);
	if ( un == null || un.equals("null")) {
		System.out.println("in if statement");
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=login&page=user_account_new");
		System.out.println("after redirect");
		return;
	} else {
	
		System.out.println("in else statement");
%>

<%	

	DynStringArray parameters = new DynStringArray();
	DbResults db_p_get_user_status_options = Database.callProcResults("p_get_user_status_options", parameters);
	DbResults db_p_get_role_options = Database.callProcResults("p_get_role_options", parameters);
	DbResults db_p_get_country_options = Database.callProcResults("p_get_country_options", parameters);	

%>

<section class="fondo-gris">
	<header>
			<div class="bc-gray-2d text-white padding-small borde-inferior">
				<div class="container">
					<h3 class="text-white">General Administration</h3>
					<h1 class="text-white">CREATE ACCOUNT</h1>
				</div>
			</div>
		</header>
		
<div class="container">
	<div class="col-xs-12 col-md-8 cuadrado separador-top separador-bottom col-centered">
	
<% 
	if ((p_message != null) && (p_message.equals("user_email_already_exists"))) {
%>
		<h5>An account with an email account of <font face="arial,helvetica,sanserif" color="red"><%= mEmail %></font> already exists.</h5>			
<%
	}
%>	
	<fieldset>
		<form class="form-horizontal" role="form" name="user_account_new"  action="validate_user_account_new.jsp" method="post">
			<input type="hidden" value="" name="skype_handle">

			<div class="form-group">
				<label for="inputFirst_nm">First Name</label>
				<div class="col-sm-9 input-group">
					<input maxlength="25" type="text" class="form-control" id="inputFirst_nm" placeholder="First Name" name="first_nm"  value="">
				</div>
			</div>
			
			<div class="form-group">
				<label for="inputLast_nm">Last Name</label>
				<div class="col-sm-9 input-group">
					<input maxlength="25" type="text" class="form-control" id="inputLast_nm" placeholder="Last Name" name="last_nm"  value="">
				</div>
			</div>

			<div class="form-group">
				<label for="inputEmail">Email</label>
				<div class="col-sm-9 input-group">
					<input maxlength="45" type="email" class="form-control" id="inputEmail" placeholder="Email" name="email"  value="">
				</div>
			</div>

			<div class="form-group">
				<label for="user_status">Status</label>
    			<select name="user_status"  class="form-control"> 
    				<option disabled selected>Select an option</option>
					<%= db_p_get_user_status_options.generateSelectOptions() %>
				</select>
			</div>

			<div class="form-group">
				<label for="role">Role</label>
    			<select name="role"  class="form-control">
    				<option disabled selected>Select an option</option>
					<%= db_p_get_role_options.generateSelectOptions() %>
				</select>
			</div>		

			<div class="form-group">
				<label for="country">Country</label>
    			<select name="country"  class="form-control"> 
    				<option disabled selected>Select an option</option>
					<%= db_p_get_country_options.generateSelectOptions() %>
				</select>
			</div>	

			<div class="form-group">
				<label for="inputPosition">Position/Title</label>
				<div class="col-sm-9 input-group">
					<input maxlength="45" type="text" class="form-control" id="inputPosition_title" placeholder="Position/Title" name="position_title"  value="">
				</div>
			</div>


			<div class="form-group">
				<label for="inputTel_nbr">Telephone</label>
				<div class="col-sm-9 input-group">
					<input maxlength="20" type="text" class="form-control" id="inputTel_nbr" placeholder="Telephone" name="tel_nbr"  value="">
				</div>
			</div>

			<div class="form-group">
				<label for="inputPwd">Password</label>
				<div class="col-sm-9 input-group">
						<input maxlength="45" type="password" class="form-control" id="inputPwd" placeholder="Password" name="pwd" value="">
				</div>
			</div>

			<div class="form-group">
				<label for="inputConfirm_pwd">Confirm Password</label>
				<div class="col-sm-9 input-group">
						<input maxlength="45" type="password" class="form-control" id="inputConfirm_pwd" placeholder="Confirma Password" name="confirm_pwd" value="">
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