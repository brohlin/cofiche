package org.undp.database;

import org.undp.utils.DbResults;
import org.undp.utils.arrays.DynObjectArray;
import org.undp.utils.arrays.DynStringArray;
import java.sql.*;
import javax.sql.*;
import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;

public class Database
{

    public Database()
    {
    }

    public static DbResults callProcResults(String aProcedureName, DynStringArray parameters)
        throws SQLException, IllegalArgumentException
    {
        Connection vConnection = null;
        PreparedStatement vPs = null;
        DbResults vDbResults = new DbResults();
        SQLException vException = null;
    	ResultSet rs = null;
    	DataSource ds;

    	try {
	    	javax.naming.Context initCtx = new javax.naming.InitialContext();
	    	javax.naming.Context envCtx = (javax.naming.Context) initCtx.lookup("java:comp/env");
	    	ds = (DataSource) envCtx.lookup("jdbc/UNDPDB");
	    	vConnection = ds.getConnection();
	    	System.out.println("got connection ...");
    	} catch (Exception e)
        {
            vException = new SQLException("Unable to get a connection to the database.");
        }


        try
        {
           	vPs = buildPreparedStatement(vConnection, aProcedureName, parameters);
            for(int i = 2; i < parameters.size() + 2; i++)
                vPs.setString(i-1, parameters.get(i - 2));

            System.out.println("before executing prepared statement ...");
            System.out.println(vPs.toString());
            rs = vPs.executeQuery();
            System.out.println("executed callable statement ...");
            vDbResults.build(rs);
            System.out.println("got dbresults ...");
        }
        catch(SQLException e)
        {
            vException = e;
            System.out.println("sql exception ...");
        }
        catch(NullPointerException nullpointerexception)
        {
        	System.out.println("null pointer exception ...");
        	throw new SQLException();
        }
        finally
        {
            try
            {
                if(vPs != null)
                    vPs.close();
                ConnectionManager.closeConnection(vConnection);
            }
            catch(SQLException e)
            {
                throw e;
            }
            catch(ConnManagerException e)
            {
                throw new SQLException(e.getMessage());
            }
            if(vException != null)
                throw vException;
        }
        return vDbResults;
    }

    protected static PreparedStatement buildPreparedStatement(Connection aConnection, String aStoredProcedureName, DynStringArray aParameters)
        throws SQLException, IllegalArgumentException
    {
        if(aStoredProcedureName == null || aParameters == null || aConnection == null)
            throw new IllegalArgumentException("Invalid parameters.");
        StringBuffer vPreparedStatement = new StringBuffer(100);
        vPreparedStatement.append("{call ");
        vPreparedStatement.append(aStoredProcedureName);
        vPreparedStatement.append("(");

        int vParametersLength = aParameters.size();

        for(int i = 0; i < vParametersLength; i++)
            if(i < vParametersLength - 1)
                vPreparedStatement.append("?,");
            else
                vPreparedStatement.append("?");

        vPreparedStatement.append(")}");
        return aConnection.prepareStatement(vPreparedStatement.toString());
    }

    public static int callProc(String aProcedureName, DynStringArray parameters)
            throws SQLException, IllegalArgumentException, MySQLIntegrityConstraintViolationException
        {
            Connection vConnection = null;
            PreparedStatement vPs = null;
            SQLException vException = null;
        	ResultSet rs = null;
        	DataSource ds;
        	int recs = 0;

        	try {
    	    	javax.naming.Context initCtx = new javax.naming.InitialContext();
    	    	javax.naming.Context envCtx = (javax.naming.Context) initCtx.lookup("java:comp/env");
    	    	ds = (DataSource) envCtx.lookup("jdbc/UNDPDB");
    	    	vConnection = ds.getConnection();
    	    	System.out.println("got connection ...");
        	} catch (MySQLIntegrityConstraintViolationException m) {
        		throw m;
            } catch (Exception e)
            {
                vException = new SQLException("Unable to get a connection to the database.");
            }


            try
            {
               	vPs = buildPreparedStatement(vConnection, aProcedureName, parameters);
                for(int i = 2; i < parameters.size() + 2; i++)
                    vPs.setString(i-1, parameters.get(i - 2));

                System.out.println("before executing prepared statement ...");
                System.out.println(vPs.toString());
                recs = vPs.executeUpdate();
                System.out.println("executed callable statement ...");
                System.out.println("got dbresults ...");
            }
            catch(SQLException e)
            {
                vException = e;
                System.out.println("sql exception ...");
            }
            catch(NullPointerException nullpointerexception)
            {
            	System.out.println("null pointer exception ...");
            	throw new SQLException();
            }
            finally
            {
                try
                {
                    if(vPs != null)
                        vPs.close();
                    ConnectionManager.closeConnection(vConnection);
                }
                catch(SQLException e)
                {
                    throw e;
                }
                catch(ConnManagerException e)
                {
                    throw new SQLException(e.getMessage());
                }
                if(vException != null)
                    throw vException;
            }

            return recs;
        }


}