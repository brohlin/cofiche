package org.undp.log;

// import org.uclbp.utils.misc.ExecUnixCmd;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;


public class LogManager
{

    public LogManager()
    {
    }

    public static String getLogPath()
    {
        return "/home/brohlin/tmp/log/";
    }

    public static synchronized void postError(Logable obj)
    {
        postError(obj, null);
    }

    public static synchronized void postError(Logable obj, String errorMessage)
    {
        StringBuffer sbTitle = new StringBuffer("ERROR: ");
        sbTitle.append(obj.getClass().getName());
        
        StringBuffer sbData = new StringBuffer(obj.getLogString());
        if(errorMessage != null)
            sbData.insert(0, ", ").insert(0, errorMessage);
        writeLog(sbTitle.toString(), sbData.toString());
    }

    public static synchronized void postError(Logable obj, String errorMessage, String aFileName)
    {
        StringBuffer sbTitle = new StringBuffer("ERROR: ");
        sbTitle.append(obj.getClass().getName());
        StringBuffer sbData = new StringBuffer(obj.getLogString());
        if(errorMessage != null)
            sbData.insert(0, ", ").insert(0, errorMessage);
        writeLog(sbTitle.toString(), sbData.toString(), aFileName);
    }

    public static synchronized void writeLog(String title, String data)
    {
        writeLog(title, data, "apperror.log");
    }

    public static synchronized void writeLog(String title, String data, String filename)
    {
        if(filename == null)
            filename = "apperror.log";
        String sFile = getLogPath() + filename;
        // String lOsName = System.getProperty("os.name");
        File vOutFile = new File(sFile);
        try
        {
            if(vOutFile.exists())
            {
                System.out.println("file exists");
            } else
            {
                BufferedWriter vBw = new BufferedWriter(new FileWriter(vOutFile));
                vBw.write(" ");
                vBw.flush();
                vBw.close();
                /*
                if(lOsName.equalsIgnoreCase("SunOS"))
                {
                    String lCmdStmt = "chmod 770 " + sFile;
                    String lCmd[] = {
                        lCmdStmt
                    };
                    ExecUnixCmd.main(lCmd);
                }
                */
            }
        }
        catch(IOException ioe)
        {
            System.out.println(ioe.getMessage());
        }
        catch(Exception e)
        {
            System.out.println(e.getMessage());
        }
        BufferedWriter out = null;
        try
        {
            out = new BufferedWriter(new FileWriter(sFile, true));
            out.write("--------------------------------------------");
            out.newLine();
            out.write(DATE_FORMATTER.format(new Date()));
            out.newLine();
            out.write(title);
            out.newLine();
            out.write(data);
            out.newLine();
            out.close();
        }
        catch(IOException e)
        {
            System.err.println("Logfile write error.");
            try
            {
                if(out != null)
                    out.close();
            }
            catch(IOException ioexception) { }
        }
    }

    public static final String LOG_FILE = "apperror.log";
    protected static final SimpleDateFormat DATE_FORMATTER = new SimpleDateFormat("MM-dd-yyyy hh:mm:ss aa");

}
