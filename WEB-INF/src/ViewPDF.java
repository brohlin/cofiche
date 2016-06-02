import javax.servlet.*;
import javax.servlet.http.*;
import java.io.ByteArrayOutputStream;
import java.io.PrintWriter;
import java.io.InputStream;
import java.sql.*;
import org.undp.database.*;
import org.undp.utils.*;
import org.undp.utils.arrays.*;
import org.undp.log.*;
import javax.sql.*;

public class ViewPDF extends HttpServlet
{

	public ViewPDF()
	{
		super();
	}

	public void doGet(HttpServletRequest req, HttpServletResponse resp)
		throws javax.servlet.ServletException, java.io.IOException
	{
		
		HttpSession session = req.getSession(true);
		String file = req.getParameter("file");
		String organization_id = req.getParameter("organization_id");
		ByteArrayOutputStream baosPDF2 = new ByteArrayOutputStream();		

		String mQuery = "select " + file + " from organization where id = ?";
		java.sql.Blob blob = null;
		
		Connection con = null;
		PreparedStatement prest = null;
		ResultSet rs = null;
		
		DataSource IndicaDB = null;
		
		try {
			javax.naming.Context initCtx = new javax.naming.InitialContext();
			javax.naming.Context envCtx = (javax.naming.Context) initCtx.lookup("java:comp/env");
			IndicaDB = (DataSource) envCtx.lookup("jdbc/IndicaDB");
			con = IndicaDB.getConnection();
		} catch(Exception e){
			System.out.println("inside the context exception");
			e.printStackTrace();
		}
		
		try{
			if(IndicaDB == null) {
				javax.naming.Context initCtx1 = new javax.naming.InitialContext();
				javax.naming.Context envCtx1 = (javax.naming.Context) initCtx1.lookup("java:comp/env");
				IndicaDB = (DataSource) envCtx1.lookup("jdbc/IndicaDB");
				con = IndicaDB.getConnection();
			}
		} catch(Exception e){
			System.out.println("inside the context exception");
			e.printStackTrace();
		}
		
		
		try{
			if ( session.getAttribute("temp_user_role_nm").equals("Admin") || session.getAttribute("temp_user_organization_id").equals(organization_id)) {	
			
				prest=con.prepareStatement(mQuery);
				prest.setString(1,organization_id);
				rs=prest.executeQuery();
		
				int size = 0;
				
				while(rs.next())
				{
					size++;
					blob=rs.getBlob(1);			
				}
				
			} else if (session.getAttribute("temp_user_organization_id")==null) {
				resp.sendRedirect("/indica/es/salir.jsp");
			}
		}
		catch(Exception e){
			e.printStackTrace();
			throw new javax.servlet.ServletException(e.getMessage());

		} finally {
			try {
				if(prest != null) { prest.close(); }
				if(rs != null) { rs.close(); }
				if(con != null) { con.close(); }
			} catch(Exception e2) {
				throw new javax.servlet.ServletException(e2.getMessage());
			}
		}

		try
		{
			
        	InputStream is = blob.getBinaryStream();  
        	int b = 0;  
        	while ((b = is.read()) != -1)  
        	{  
        		baosPDF2.write(b);  
        	} 
	        		        			
			StringBuffer sbFilename = new StringBuffer();
			sbFilename.append("filename_");
			sbFilename.append(System.currentTimeMillis());
			sbFilename.append(".pdf");

			resp.setHeader("Cache-Control", "max-age=30");
			
			resp.setContentType("application/pdf");
			
			StringBuffer sbContentDispValue = new StringBuffer();
			sbContentDispValue.append("inline");
			sbContentDispValue.append("; filename=");
			sbContentDispValue.append(sbFilename);
							
			resp.setHeader(
				"Content-disposition",
				sbContentDispValue.toString());

			resp.setContentLength(baosPDF2.size());

			ServletOutputStream sos;

			sos = resp.getOutputStream();
			
			baosPDF2.writeTo(sos);
			
			sos.flush();
		} catch(NullPointerException nex) {
			// resp.sendRedirect("/indica/default_error_page.jsp");
			resp.sendRedirect("/indica/es/main.jsp?target=error");
		}
		catch (Exception dex)
		{
			resp.setContentType("text/html");
			PrintWriter writer = resp.getWriter();
			writer.println(
					this.getClass().getName() 
					+ " caught an exception: " 
					+ dex.getClass().getName()
					+ "<br>");
			writer.println("<pre>");
			dex.printStackTrace(writer);
			writer.println("</pre>");
		}
		finally
		{
			if (baosPDF2 != null)
			{
				baosPDF2.reset();
			}
		}

	}

}