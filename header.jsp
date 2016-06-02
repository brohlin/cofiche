<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ page language="java" import="java.sql.*" %>
<%@ page import="org.undp.database.*" %>
<%@ page import="org.undp.utils.*" %>
<%@ page import="org.undp.utils.arrays.*" %>
<%@ page import="org.undp.log.*" %>


<%
	ServletContext context = pageContext.getServletContext();
	request.setCharacterEncoding("UTF-8");
	String p_target = request.getParameter("target");
	String p_message = request.getParameter("message");
	
	String p_country_id = request.getParameter("country_id");
	String p_section_id = request.getParameter("section_id");
	
	String p_page = request.getParameter("page");
	
	// String p_section = request.getParameter("section");

	String v_home = "off";	
	String v_login = "off";
	String v_country = "off";
	String v_manage_countries = "off";
	String v_manage_access = "off";
	String v_manage_adhocs = "off";
	String v_news = "off";
	
	if ((p_section_id == null) || p_section_id.equals("")) {
		p_section_id = "1";
	}		
	
	if ((p_country_id == null)  || p_country_id.equals("")) {
		
		p_country_id = "101";
		
		/*
		try {
			if ( session.getAttribute("user_role_nm").equals("CO") ) {
				p_country_id = session.getAttribute("user_country_id").toString();
			}
		} catch (Exception e) {
			// do nothing
		}		
	
		try {
			if ( session.getAttribute("user_role_nm").equals("CA") || session.getAttribute("user_role_nm").equals("RBLAC_EXEC") ) {	
				p_country_id = request.getParameter("country_id");
			}
		} catch (Exception e) {
			// do nothing
		}
		
		*/

	}

	/*
	if ((p_section == null) || p_section.equals("")) {
		p_section = "office_basic_info";		
	}
	*/
	
	if ((p_page == null) || p_page.equals("")) {
		p_page = "home";
	}			
	
	try {
		if (session.getAttribute("user_email") == null){
			v_home = "on";
		} else {
			if (p_target != null) {
				if (p_target.equals("country")) {
					v_country = "on";
				} else if (p_target.equals("manage_countries")) {
					v_manage_countries = "on";
				} else if (p_target.equals("manage_access")) {
					v_manage_access = "on";
				} else if (p_target.equals("manage_adhocs")) {
					v_manage_adhocs = "on";
				} else if (p_target.equals("home")) {
					v_home = "on";
				}  else if (p_target.equals("news")) {
					v_news = "on";
				}         
				
				session.setAttribute("target",p_target);
			}		
		}
	}
	catch (Exception e) {
		throw e;
	}

	if (session.getAttribute("user_role_nm") != null) {
		if ( session.getAttribute("user_role_nm").equals("CO") && !session.getAttribute("user_country_id").toString().equals(p_country_id)) {
			response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=error");
		}
	}
	
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
	
	<!-- script src=”http://tinymce.cachefly.net/4.0/tinymce.min.js”></script -->
	
	<script src="/cofiche/assets/js/jquery-2.1.0.min.js"></script>
	
	<script src='https://cdn.tinymce.com/4/tinymce.min.js'></script>
	
	<script type="text/javascript">
		tinymce.init({
		//	selector: 'textarea',  // change this value according to your HTML
	//		toolbar: 'undo redo | styleselect | bold italic | link image',
//			plugins : "autolink,lists,spellchecker,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",
			    selector: "textarea",
			    theme: "modern",
			    editor_deselector: "readonly",
			    plugins: [
			        "advlist autolink lists link image charmap print preview hr anchor pagebreak",
			        "searchreplace wordcount visualblocks visualchars code fullscreen",
			        "insertdatetime media nonbreaking save table contextmenu directionality",
			        "emoticons template paste textcolor colorpicker textpattern imagetools"
			    ],
			    extended_valid_elements : "script[charset|defer|language|src|type]",
			    toolbar1: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
			    toolbar2: "print preview media | forecolor backcolor emoticons",
			    image_advtab: true,
			    templates: [
			        {title: 'Test template 1', content: 'Test 1'},
			        {title: 'Test template 2', content: 'Test 2'}
			    ],
			    force_p_newlines: false
			
		});
	</script>


	
</head>
<body>


	<header>
		<nav class="navbar navbar-default" role="navigation">
			<div class="container">
				<div class="navbar-header">
					<div class="logo-pnud64-3 logo-pnud-home">Logo Pnud</div>
					<!-- <img class="pull-right  " alt="Logo Pnud" src="images/logoPnud.png"> -->
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#menu-colapsible">
						<span class="sr-only">Desplegar menu</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>  
					</button> 
				</div>

				
				<!-- Collect the nav links, forms, and other content for toggling -->
	
				<div class="row">
				<div class=" logo-cofiche-home"><!-- img alt="Country Fiche" src="/cofiche/assets/images/logo.png" --></div> 
					<div class="collapse navbar-collapse" id="menu-colapsible">
						<div class="col-md-11 col-lg-9 col-centered text-center" >
							<ul class="nav navbar-nav">
								<!--  li><a href="./main.jsp?target=home">HOME</a></li -->
								<%
									// Menu for CO
									if ((session.getAttribute("user_id") != null) && (session.getAttribute("user_role_nm").equals("CO"))) {
										if (v_home.equals("on")) {
								%>								
											<li class="active-item"><a href="./main.jsp?target=home">HOME</a>
								<%
										} else {
								%>
											<li><a href="./main.jsp?target=home">HOME</a>
								<%
										}
								%>
											</li>
										
								<%
										if (v_country.equals("on")) {
								%>								
											<li class="active-item"><a href="./main.jsp?target=country">COUNTRY</a></li>
								<%					
										} else {
								%>
											<li><a href="./main.jsp?target=country">COUNTRY</a></li>
								<%			
										}
										
									}
															
									// Menu for Country Advisor
									if ((session.getAttribute("user_id") != null) && (session.getAttribute("user_role_nm").equals("CA"))) {
										if (v_home.equals("on")) {
								%>								
											<li class="active-item"><a href="./main.jsp?target=home">HOME</a>
								<%
										} else {
								%>
											<li><a href="./main.jsp?target=home">HOME</a>
								<%
										}
								%>
											</li>
										
								<%
										if (v_manage_countries.equals("on")) {
								%>								
											<li class="active-item"><a href="./main.jsp?target=manage_countries">COUNTRIES</a>
								<%
										} else {
								%>
											<li><a href="./main.jsp?target=manage_countries">COUNTRIES</a>
								<%
										}
								%>
											</li>									
								<%			
										if (v_news.equals("on")) {
								%>								
											<li class="active-item"><a href="./main.jsp?target=news">NEWS</a>
								<%
										} else {
								%>
											<li><a href="./main.jsp?target=news">NEWS</a>
								<%
										}
								%>
											</li>											

										<li><a href="#" data-toggle="dropdown" class=" btn btn-default navbar-btndropdown-toggle">User Name <b class="caret"></b></a>
											<ul class="dropdown-menu">
												<li><a href="./main.jsp?target=user_account">EDIT PROFILE</a></li>
												<li><a href="./logout.jsp">LOGOUT</a></li>
											</ul>
										</li>
								<%
									} 
									
								// Menu for Login only
									if (session.getAttribute("user_id") == null && p_target.equals("home")) {
								%>
										<li><a href="./main.jsp?target=login">LOGIN</a></li>
								<%
									}
								%>	
											
						   </ul>
						</div>
					</div>  
				</div>	
			</div>	
		</nav>
	</header>
	
		