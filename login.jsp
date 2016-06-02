		<section class="borde-superior fondo-gris" role="dialog">
			<h4 class="text-hide reset-margin">Formulario de Ingreso</h4>
			<div class="container" >
						<div class="cuadrado separador-top separador-bottom col-sm-8 col-md-6 col-centered">
						<fieldset>
							<legend  class="text-center">Please enter your email and password</legend>
							<form class="form-horizontal" role="form" name="login" id="formLogin" action="/cofiche/validate_login.jsp?page=<%= p_page + "&country_id=" + p_country_id %>" method="post">
								<div class="form-group">
								<label for="inputEmail" class="col-sm-3 col-md-3 control-label">Email</label>
								<div class="col-sm-9 input-group">
									<span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
									<input type="email" class="form-control" id="inputEmail" placeholder="Email" name="email" >
									</div>
								</div>
								<div class="form-group">
									<label for="inputPassword" class="col-sm-3  col-md-3 control-label">Password</label>
									<div class="col-sm-9 input-group">
											<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
											<input type="password" class="form-control" id="inputPassword" placeholder="Contrase&ntilde;a" name="pwd">
									</div>
								</div>
	<% 
		if ((p_message != null) && (p_message.equals("failed_login"))) {
	%>
		The email or password is incorrect.	
	<%
		}
	%>	
	
	<% 
		if ((p_message != null) && (p_message.equals("sent_password"))) {
	%>
		We have emailed your password to you.	
	<%
		}
	%>								
								<div class="form-group">
 									<div class="col-sm-offset-3 col-lg-offset-4  col-sm-9  col-lg-8  ">
										<div class="checkbox inline">
											<!-- a href="./main.jsp?target=lost_password" title="Olvidé mi contraseña"><span>Olvid&eacute; mi contrase&ntilde;a</span></a --> 
											<a href="#" title="Forgot password"><span>Forgot Password?</span></a>
										</div>
									</div>  
								</div>
								<div class="form-group">
									<div class="col-sm-offset-3 col-sm-9">
									<button type="submit" class="btn btn-info btn-block">Login</button>
									</div>
								</div>
					  	</form>
          	</fieldset>
						</div>
			</div>        
		</section>