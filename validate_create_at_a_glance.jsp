<%@ page language="java" import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="org.undp.database.*" %>
<%@ page import="org.undp.log.*" %>
<%@ page import="org.undp.utils.*" %>
<%@ page import="org.undp.utils.arrays.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>

<!-- %
	String un = (String) session.getAttribute("user_id");
	System.out.println(un);
	if ( un == null || un.equals("null")) {
		System.out.println("in if statement");
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=login&page=create_at_a_glance");
		System.out.println("after redirect");
		return;
	} else {
	
		System.out.println("in else statement");
% -->

<%	
	request.setCharacterEncoding("UTF-8");
	String mQuery = "insert into report (country_id, title, description, file_name, file, user_id, last_mod_tmstmp,type,image,image_name) values (?,?,?,?,?,?,now(),?,?,?)";
	String p_country_id = request.getParameter("country_id");
	
	String _title = request.getParameter("title");
	String _description = request.getParameter("description");
	
	String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(Calendar.getInstance().getTime());
	String timeStamp2 = new SimpleDateFormat("MMM dd, yyyy @ HH:mm").format(Calendar.getInstance().getTime());
	
	Connection con = null;
	PreparedStatement prest = null;
	DataSource UNDPDB;
	javax.naming.Context initCtx = new javax.naming.InitialContext();
	javax.naming.Context envCtx = (javax.naming.Context) initCtx.lookup("java:comp/env");
	UNDPDB = (DataSource) envCtx.lookup("jdbc/UNDPDB");
	
	ServletContext context = pageContext.getServletContext();
	String phantomjsPath = context.getInitParameter("phantomjs-path");
	String domainUrl = context.getInitParameter("domain-url");
	String phantomjsReportsDirectory = context.getInitParameter("phantomjs-reports-directory");
	String outputFile = phantomjsReportsDirectory + p_country_id +"_at_a_glance_" + timeStamp + ".pdf";
	String outputFile2 = phantomjsReportsDirectory + p_country_id +"_at_a_glance_" + timeStamp + ".png";
	
	DynStringArray parameters = new DynStringArray();
	parameters.add(p_country_id);
	DbResults db = Database.callProcResults("p_get_country", parameters);
	
	String _country_name = db.generateHtml();
	
	int y = 0;
	int exitVal = 0;
	int z = 0;
		
	// System.out.println("Start 1: "+ timeStamp);
	try {
		Process p = Runtime.getRuntime().exec(phantomjsPath + "bin/phantomjs " + phantomjsPath + "examples/rasterize.js " + domainUrl + "cofiche/at-a-glance.jsp?js=yes&country_id=" + p_country_id + "&pnud_logo=yes" + " " + outputFile + " " + "A3");
		LogManager.writeLog("phantomjs call", (phantomjsPath + "bin/phantomjs " + phantomjsPath + "examples/rasterize.js " + domainUrl + "cofiche/at-a-glance.jsp?js=yes&country_id=" + p_country_id + "&pnud_logo=yes"  + " " +  outputFile + " " + "A3"));
		
		
		exitVal = p.waitFor();
		System.out.println("Call phantomjs to generate resultados informe: " + String.valueOf(exitVal));

        BufferedReader in = new BufferedReader(
                new InputStreamReader(p.getInputStream()));
		String line = null;
		
		while ((line = in.readLine()) != null) {
			System.out.println(line);
		} 		
		
		Process p2 = Runtime.getRuntime().exec(phantomjsPath + "bin/phantomjs " + phantomjsPath + "examples/rasterize.js " + domainUrl + "cofiche/at-a-glance.jsp?js=yes&country_id=" + p_country_id + "&pnud_logo=yes"  + " " +  outputFile2);
		LogManager.writeLog("phantomjs call", (phantomjsPath + "bin/phantomjs " + phantomjsPath + "examples/rasterize.js " + domainUrl + "cofiche/at-a-glance.jsp?js=yes&country_id=" + p_country_id + "&pnud_logo=yes"  + " " +  outputFile2));

		
		exitVal = p2.waitFor();
		System.out.println("Call phantomjs to generate at-a-glance: " + String.valueOf(exitVal));
		
        BufferedReader in2 = new BufferedReader(
                            new InputStreamReader(p2.getInputStream()));
        String line2 = null;
        while ((line2 = in2.readLine()) != null) {
            System.out.println(line2);
        }     
        
   	} catch (IOException e) {
        e.printStackTrace();
    }

	
	// if ( exitVal == 0) {
		try{
			
			con = UNDPDB.getConnection();
			prest=con.prepareStatement(mQuery);
			
			FileInputStream fs = new FileInputStream(outputFile);
			FileInputStream fs2 = new FileInputStream(outputFile2);
			
			prest.setString(1, p_country_id);
			
			// prest.setString(2, _country_name + " - " + timeStamp2);
			// prest.setString(3, "Country Report for " + _country_name + " generatated on " + timeStamp2);
					
			prest.setString(2, _title);
			prest.setString(3, _description);
			prest.setString(4, outputFile.substring(outputFile.lastIndexOf("/")+1, outputFile.length() ) );					
			prest.setBinaryStream(5,fs,fs.available());
			prest.setString(6, "5");
			prest.setString(7, "At-a-Glance");
			prest.setBinaryStream(8,fs2,fs2.available());
			prest.setString(9, outputFile2.substring(outputFile2.lastIndexOf("/")+1, outputFile2.length() ) );
				
			y = prest.executeUpdate();
			
			// response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=country&country_id=101&section_id=1");
					
		}
		catch(Exception e){
			e.printStackTrace();
			LogManager.writeLog("Insert into report table: ", e.getMessage() );
		} finally {
			if(prest != null) { prest.close(); }
			if(con != null) { con.close(); }
			// response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=error");
		} 
	// } else {
		// response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=error");
	// }
		

	
	if (y==1) {	
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=country&section_id=1&country_id=" + p_country_id);
	} else {
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=error");
	}
%>

<!-- %
	}
% -->