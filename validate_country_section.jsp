<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 

<%@ page language="java" import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="org.undp.database.*" %>
<%@ page import="org.undp.log.*" %>
<%@ page import="org.undp.utils.*" %>
<%@ page import="org.undp.utils.arrays.*" %>


<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>

<%@ page import="java.util.AbstractMap.SimpleEntry" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map.Entry" %>

<%
	String un = (String) session.getAttribute("user_id");
	System.out.println(un);
	if ( un == null || un.equals("null")) {
		System.out.println("in if statement");
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=login&page=country");
		System.out.println("after redirect");
		return;
	} else {
	
		System.out.println("in else statement");
%>

<%
	response.setCharacterEncoding("UTF-8");
    request.setCharacterEncoding("UTF-8");

   	String fieldName;
   	String fieldName2;
   	String p_country_id = "";
   	String p_country_id2 = "";
   	String p_section_id = "";
   
   	List<Entry<String,String>> pairList = new ArrayList();

   	File file = null;
   	int maxFileSize = 102400000;
   	int maxMemSize = 5000 * 1024;
   	ServletContext context = pageContext.getServletContext();
   	String filePath = context.getInitParameter("file-upload");

   	// Verify the content type
   	String contentType = request.getContentType();
   	if ((contentType.indexOf("multipart/form-data") >= 0)) {

      	DiskFileItemFactory factory = new DiskFileItemFactory();
      	// maximum size that will be stored in memory
      	factory.setSizeThreshold(maxMemSize);
      	// Location to save data that is larger than maxMemSize.
      	factory.setRepository(new File(filePath));

      	// Create a new file upload handler
      	ServletFileUpload upload = new ServletFileUpload(factory);
      	// maximum file size to be uploaded.
      	upload.setSizeMax( maxFileSize );
      	try{ 
         	// Parse the request to get file items.
         	List fileItems = upload.parseRequest(request);
         	
         	if (fileItems.isEmpty()) {
         		System.out.println("no form fields");
         		LogManager.writeLog("coutry section", "no form fields");
         	};

         	// Process the uploaded file items
         	Iterator i = fileItems.iterator();
         	Iterator i2 = fileItems.iterator();
         	
         	while ( i2.hasNext () ) 
         	{
            	FileItem fi2 = (FileItem)i2.next();
            	if ( fi2.isFormField () )	
            	{
      				fieldName2 = fi2.getFieldName();
      	
      				if(fieldName2.equals("country_id")) {
      					p_country_id2 = fi2.getString("UTF-8");
      				} 
				}
			}
         	
         	
         	while ( i.hasNext () ) 
         	{
         		// System.out.println("i am in the while loop");
         		// LogManager.writeLog("coutry section", "i am in the while loop");
            	FileItem fi = (FileItem)i.next();
            	if ( !fi.isFormField () )	
            	{
            		// Get the uploaded file parameters
            		fieldName = fi.getFieldName();
            		String fileName = fi.getName();
            		boolean isInMemory = fi.isInMemory();
            		long sizeInBytes = fi.getSize();
            		
            		// System.out.println("Size: " + fileName.length());
            		
            		// Write the file
            		if( fileName.lastIndexOf("\\") >= 0 ){
            			file = new File( filePath + p_country_id2 + "_" + fileName.substring( fileName.lastIndexOf("\\"))) ;
            		}else{
            			file = new File( filePath + p_country_id2 + "_" + fileName.substring(fileName.lastIndexOf("\\")+1)) ;
            		}
            		
            		try {
            			if (fileName.length()>0) {
    	        			fi.write( file );    	        			    	        			
	            			pairList.add(new SimpleEntry<String,String>(fieldName, p_country_id2 + "_" + fileName));
	            			
	            			// create thumbnail
    	        			// IO.saveScaledImage(filePath + p_country_id2 + "_" + fileName, filePath + p_country_id2 + "_thumb_" + fileName);
            			}
            		} catch (Exception e){
            			
         				System.out.println(e.getMessage());
         				LogManager.writeLog("coutry section", e.getMessage());
            		}
            	} else {
                
      				fieldName = fi.getFieldName();
      	
      				if(fieldName.equals("country_id")) {
      					p_country_id = fi.getString("UTF-8");
      				} else if(fieldName.equals("section_id")) {
      					p_section_id = fi.getString("UTF-8");
      				} else {
      					pairList.add(new SimpleEntry<String,String>(fieldName, fi.getString("UTF-8"))); 
      				}
				}
			}
         

      	}catch(Exception ex) {
         	System.out.println(ex.getMessage());
         	LogManager.writeLog("coutry section", ex.getMessage());
         	
      	}
	}else{
		// nada
   	}
%>

<%	
	int size = 0;
	int x = 0;
	int y = 0;
	int counter = 0;
	
	String p_input_name = "";
	String p_input_value = "";
	
	DynStringArray parameters = new DynStringArray();
	parameters.add(p_section_id);
	parameters.add(p_country_id);
	
	DbResults db_field_value_pairs = Database.callProcResults("p_get_field_value_pairs", parameters);
	
	for (Entry<String, String> entr : pairList) {
		
		p_input_name = entr.getKey();
		p_input_value = entr.getValue();
	  	System.out.println("Name: " + entr.getKey() + "    Value: " + entr.getValue());	
	  	LogManager.writeLog("coutry section", "Name: " + entr.getKey() + "    Value: " + entr.getValue());
		
		parameters.clear();
		size = 0;
		
		if (p_input_value != null && !p_input_value.equals("")) {
			
			System.out.println("p_input_name: " + p_input_name + " p_input_value: " + p_input_value);	
			LogManager.writeLog("coutry section", "p_input_name: " + p_input_name + " p_input_value: " + p_input_value);
			
			
			while (size<db_field_value_pairs.getRowCount())
			{
				
				if (p_input_name.equals(db_field_value_pairs.getRow(size).get(0)) && !p_input_value.equals(db_field_value_pairs.getRow(size).get(1))) {

					System.out.println("ID: " + db_field_value_pairs.getRow(size).get(0) + " Field Value: " + db_field_value_pairs.getRow(size).get(1));
					LogManager.writeLog("coutry section", "ID: " + db_field_value_pairs.getRow(size).get(0) + " Field Value: " + db_field_value_pairs.getRow(size).get(1));
					
					parameters.add(p_input_name);
					parameters.add(p_country_id);
					parameters.add(p_input_value);
					parameters.add("2");  // 2 == Data Entry
					parameters.add(session.getAttribute("user_id").toString());
					
					x = Database.callProc("p_upd_field_value", parameters);
					y = y + x;
					counter++;
					
					System.out.println("Updated " + p_input_name + " with " + p_input_value);
					LogManager.writeLog("coutry section", "Updated " + p_input_name + " with " + p_input_value);
				}
				
				size++;
			
			}
			
		}
		
	}
	
	System.out.println("y="+y);
	LogManager.writeLog("coutry section", "y="+Integer.toString(y));
	System.out.println("counter="+counter);
	LogManager.writeLog("coutry section", "counter="+Integer.toString(counter));
	
	if (y==counter) {	
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=country&section_id=" + p_section_id + "&country_id=" + p_country_id);
	} else {
		response.sendRedirect(context.getInitParameter("domain-url") + "cofiche/main.jsp?target=error");
	}

%>

<%
	}
%>