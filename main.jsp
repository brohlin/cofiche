<%@include file="./header.jsp"%>

 <%
 	request.setCharacterEncoding("UTF-8");
  	String mName = "";
  	String mCountry_id = "0";
  	String mEmail = "";
  	String mUser_id = "";
  	
	String p_mode = "edit"; 	  	
	
	String p_js = "";
	
 	try {
 		
 		p_mode = request.getParameter("mode");
 		
 		if ((p_mode == null) || p_mode.equals("")) {
 			p_mode = "view";
 		}
 		
		mName = request.getParameter("name");
		mCountry_id = request.getParameter("country_id"); 
		mEmail = request.getParameter("email");
		mUser_id = request.getParameter("user_id"); 		
		if (mName == null) {
			mName = "";
		} else {
			mName = mName.toLowerCase();
		}
		if ((mCountry_id == null) || mCountry_id.equals("")) {
			mCountry_id = "0";
		}	
		
		if (mEmail == null) {
			mEmail = "";
		} else {
			mEmail = mEmail.toLowerCase();
		}
		if ((mUser_id == null) || mUser_id.equals("")) {
			mUser_id = "0";
		}	
		
		p_js = request.getParameter("js");

		if (p_js == null || p_js.equals("")) {
			p_js = "no";
		}	
		
	} catch (Exception ex) {
		// dont do anything here
	}
 
 %>
 
<%
	if (p_target != null) {
		if (p_target.equals("login")) { 
%>
			<%@include file="./login.jsp" %>
<%
		} else if (p_target.equals("failed_login")) {
%>
			<%@include file="./login.jsp" %>
<%	
		} else if (p_target.equals("lost_password")) {
%>
			<%@include file="./lost_password.jsp" %>
<%	
		} else if (p_target.equals("manage_countries")) {
%>
			<%@include file="./manage_countries.jsp" %>
<%	
		}  else if (p_target.equals("country")) {
%>
			<%@include file="./country.jsp" %>
<%	
		}  else if (p_target.equals("country_report")) {
%>
			<jsp:include page="country_report.jsp">
        		<jsp:param name="country_id" value="<%= mCountry_id %>"/>
    		</jsp:include>
<%	
		}  else if (p_target.equals("create_country_pdf")) {
%>
			<jsp:include page="create_country_pdf.jsp">
        		<jsp:param name="country_id" value="<%= mCountry_id %>"/>
    		</jsp:include>
<%	
		}  else if (p_target.equals("create_at_a_glance")) {
%>
			<jsp:include page="create_at_a_glance.jsp">
        		<jsp:param name="country_id" value="<%= mCountry_id %>"/>
        		<jsp:param name="js" value="<%= p_js %>"/>
    		</jsp:include>
<%	
		}    else if (p_target.equals("manage_access")) {
%>
			<%@include file="./manage_access.jsp" %>
<%	
		}  else if (p_target.equals("view_reports")) {
%>
			<%@include file="./view_reports.jsp" %>
<%	
		}    else if (p_target.equals("user_account")) {
%>
			<%@include file="./user_account.jsp" %>
<%	
		}  else if (p_target.equals("user_account_new")) {
%>
			<%@include file="./user_account_new.jsp" %>
<%	
		}  else if (p_target.equals("news")) {
%>
			<%@include file="./news.jsp" %>
<%	
		}  else if (p_target.equals("error")) {
%>
			<%@include file="./error.jsp" %>
<%	
		} else if (p_target.equals("home")) {
%>
			<jsp:include page="home.jsp">
        		<jsp:param name="country_id" value="<%= mCountry_id %>"/>
    		</jsp:include>
<%	
		}  else {
%>					
		<jsp:include page="under_construction.jsp" flush="true" />
<%
		}
	} 
%>
								
<%@include file="./footer.jsp"%>