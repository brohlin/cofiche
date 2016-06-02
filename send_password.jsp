<%@ page language="java" import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.undp.database.*" %>
<%@ page import="org.undp.log.*" %>
<%@ page import="org.undp.utils.*" %>
<%@ page import="org.undp.utils.arrays.*" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="java.net.URLEncoder" %>


<%
	String[] args = null;
	// InternetAddress addressTo = null;
	InternetAddress[] addressTo = new InternetAddress[1];
    
	MailSender mail = new MailSender();;
	String p_email = request.getParameter("email");
	DynStringArray parameters = new DynStringArray();
	parameters.add(p_email);
	StringBuffer sbMessage = new StringBuffer("Dear Colleague,");
	sbMessage.append(System.getProperty("line.separator"));
	sbMessage.append(System.getProperty("line.separator"));
	
	sbMessage.append("You may access the Country Fiche web page by using the following: ");
	sbMessage.append(System.getProperty("line.separator"));
	sbMessage.append(System.getProperty("line.separator"));
	

	DbResults db = Database.callProcResults("p_get_user_email", parameters);
	
	int size=0;
	
	if (db.getRowCount()>size) {
		while(size<db.getRowCount())
		{
			addressTo[0] = new InternetAddress(db.getRow(size).get(0));
			// addressTo = new InternetAddress(db.getRow(size).get(0));
			sbMessage.append("URL: " + db.getRow(size).get(3));
			sbMessage.append(System.getProperty("line.separator"));
			
			sbMessage.append("Email: " + db.getRow(size).get(0));
			sbMessage.append(System.getProperty("line.separator"));
			sbMessage.append("Password: " + db.getRow(size).get(1));
			sbMessage.append(System.getProperty("line.separator"));

			size++;
		}
		
		mail.setSubject("Your access to the Country Fiche");
		mail.setMessage(sbMessage.toString());
		mail.setSiteName("Country Fiche");
		
		mail.setAddressTo(addressTo[0]);
		mail.send();
		
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=login&message=sent_password");
	} else {
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=lost_password&message=no_email_found");
	} 

%>