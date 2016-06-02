<%
	String un = (String) session.getAttribute("user_id");
	System.out.println(un);
	if ( un == null || un.equals("null")) {
		System.out.println("in if statement");
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=login&page=manage_countries");
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
					<h1 class="text-white">COUNTRIES</h1>
				</div>
			</div>
		</header>	
				
		<div class="bc-gray padding-medium">
			<div class="container">

				<div id="manage_countries" class="col-md-6 padding-small">
					
					<form class="form-horizontal" role="form"  name="search_manage_countries" action="./main.jsp?target=manage_countries" method="post">
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
						  <label class="col-md-4 control-label" for="name">Search by name</label>  
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

				<!-- div id="anadir-empresa" class="col-md-5 padding-small">
					<fieldset>
						<legend>
							<h3 >Añadir una empresa nueva</h3>
						</legend>
						<form role="form" name="empresa" action="/indica/es/main.jsp?target=empresa_nueva" method="post">
							<div class="col-centered col-md-7 separador-top">
								<button type="submit" class="btn btn-info padding-small btn-block">Pulse este botón para crear un registro de empresa</button>
							</div>
						</form>
					</fieldset>
				</div -->
			</div>
		</div> <!-- fin franja gris -->	
		
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
							<td><a href="./main.jsp?target=country&country_id=<%= db.getRow(size).get(0) %>"><%= db.getRow(size).get(1) %></a>
							</td>			
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
	</section>

<%
	}
%>