package org.undp.database;

import java.sql.*;
import javax.sql.*;

public class ConnectionManager
{

    public ConnectionManager()
    {
    }

    public static Connection getConnection()
        throws ConnManagerException
    {

		Connection con = null;
		DataSource UNDPDB;

        try
        {
			javax.naming.Context initCtx = new javax.naming.InitialContext();
			javax.naming.Context envCtx = (javax.naming.Context) initCtx.lookup("java:comp/env");
			UNDPDB = (DataSource) envCtx.lookup("jdbc/UNDPDB");

			con = UNDPDB.getConnection();

            return con;
        }
        catch(Exception e)
        {
            throw new ConnManagerException("Unable to connect to database.");
        }
    }

    public static void closeConnection(Connection aConn)
        throws ConnManagerException
    {
        try
        {
            if(aConn != null)
                aConn.close();
        }
        catch(Exception e)
        {
            throw new ConnManagerException("Unable to free the connection from database.");
        }
    }

}
