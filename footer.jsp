<%@ page language="java" import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="org.undp.database.*" %>
<%@ page import="org.undp.log.*" %>
<%@ page import="org.undp.utils.*" %>
<%@ page import="org.undp.utils.arrays.*" %>

<%
	String logged_in = "no";

	try {
		if (session.getAttribute("user_id") == null ) {
		 	logged_in = "no";
		} else {
			logged_in = "yes";
		}
	} catch (Exception e) {
		LogManager.writeLog("Footer", e.getMessage());
	}

	
	DynStringArray parameters = new DynStringArray();
	parameters.add(logged_in);
	
	DbResults db_country_flags = Database.callProcResults("p_get_country_flags", parameters);

%>

	<footer>
		<hr>
		<div class="container footer-arriba">
			<!-- div class="row" -->
			<div class="col-md-8 col-centered separador-bottom ">
				 <!-- nav class="col-sm-12 col-md-3 navegacion2" role="navigation">
					<h4 class="titulo">&nbsp;</h4>                    
				
				</nav -->  
				<section class="col-sm-12 col-md-3">
					<h4 class=" titulo">Countries</h4>
					<table class="table">
						<tbody >
						
							<%= db_country_flags.generateHtml() %>
							<!--  tr>
								<td><a class="brazil" href="#" title="Brazil">Brazil</a></td>
								<td><a class="chile" href="#" title="Chile">Chile</a></td>
								<td><a class="colombia" href="#" title="Colombia">Colombia</a></td>      
								<td><a class="costa-rica" href="#" title="Costa Rica">Costa Rica</a></td>
								<td><a class="cuba" href="#" title="Cuba">Cuba</a></td>
								<td><a class="el-salvador" href="#" title="El Salvador">El Salvador</a></td>								
							</tr>
							<tr>	
								<td><a class="brazil" href="#" title="Brazil">Brazil</a></td>
								<td><a class="chile" href="#" title="Chile">Chile</a></td>
								<td><a class="colombia" href="#" title="Colombia">Colombia</a></td>      
								<td><a class="costa-rica" href="#" title="Costa Rica">Costa Rica</a></td>
								<td><a class="cuba" href="#" title="Cuba">Cuba</a></td>
								<td><a class="el-salvador" href="#" title="El Salvador">El Salvador</a></td> 
							</tr>
							<tr>
								<td><a class="brazil" href="#" title="Brazil">Brazil</a></td>
								<td><a class="chile" href="#" title="Chile">Chile</a></td>
								<td><a class="colombia" href="#" title="Colombia">Colombia</a></td>      
								<td><a class="costa-rica" href="#" title="Costa Rica">Costa Rica</a></td>
								<td><a class="cuba" href="#" title="Cuba">Cuba</a></td>
								<td><a class="el-salvador" href="#" title="El Salvador">El Salvador</a></td> 
							</tr>
							<tr>
								<td><a class="brazil" href="#" title="Brazil">Brazil</a></td>
								<td><a class="chile" href="#" title="Chile">Chile</a></td>
								<td><a class="colombia" href="#" title="Colombia">Colombia</a></td>      
								<td><a class="costa-rica" href="#" title="Costa Rica">Costa Rica</a></td>
								<td><a class="cuba" href="#" title="Cuba">Cuba</a></td>
								<td><a class="el-salvador" href="#" title="El Salvador">El Salvador</a></td>
							</tr -->
						</tbody>
					</table>
				</section>    

			</div>
		</div>
		<hr>
		<section class="container">
		<h4 class="text-hide reset-margin">Redes sociales</h4>	
			<!-- div class="row">
				<div class="col-sm-5 col-md-5">
					<ul class="social text-hide list-inline">
						<li><a class=" facebook" target="_blank" href="https://www.facebook.com/AmericaLatinaGenera" title="Facebook">Facebook</a></li>
						<li><a class="twitter" target="_blank"  href="https://twitter.com/PNUD_ALGenera" title="Twitter">Twitter</a></li>
						<li><a class="linkedin" target="_blank"  href="http://www.linkedin.com/pub/am%C3%A9ricalatinagenera-rsclac-pnud/24/192/a86" title="Linkedin">Linkedin</a></li>
						<li><a class="youtube" target="_blank"  href="http://www.youtube.com/user/RSCLACPNUDAreaGenero" title="Youtube">Youtube</a></li>
						<li><a class="scoopit" target="_blank"  href="http://www.scoop.it/t/genera-igualdad?sc_source=http%3A%2F%2F192.64.74.193%2F%7Egenera%2Fnewsite%2Findex.php%2Fes%2Finformate" title="Scoop It ">Scoop It!</a></li>
						 <li><a class="flipboard" target="_blank"  href="https://flipboard.com/section/revista-genera-igualdad-bP85HX" title="Flipboard ">Flipboard </a></li>
					</ul>
				</div>
				 <div class="col-sm-7 col-md-7 ">
				   <ul class="policies list-inline pull-right ">
					<li class="active"><a href="#">T&eacute;rminos de uso ·</a></li>
					<li><a href="#">Privacidad ·</a></li>
					<li><a href="#">Pol&iacute;ticas de cookies</a></li> 
					   <li><span class="copyright">&copy;  2014 INDICA IGUALDAD</span></li>   
				  </ul>
				</div>
			</div -->
		</section>
	</footer>

	<script src="/cofiche/assets/js/jquery-2.1.0.min.js"></script>
	<script defer src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
	
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
	
	
</body>
</html>